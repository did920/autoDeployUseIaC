terraform {
  #aws module plugin 사용
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.34"
    }
  }
}

  #aws module plugin 설정
provider "aws" {
  profile = "default"
  region = var.aws_region
}



module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"

  name = var.vpc_name
  cidr = var.vpc_cidr
  
  azs = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets = var.vpc_public_subnets
  
  enable_nat_gateway = var.vpc_enable_nat_gateway

}

resource "aws_ebs_volume" "disk01" {
  availability_zone = "ap-northeast-2a"
  size = "80"
}

resource "aws_volume_attachment" "backup" {
  device_name = "/dev/sdd"
  volume_id = aws_ebs_volume.disk01.id
  instance_id = aws_instance.center2_backup.id
}

resource "aws_instance" "center2_backup" {
  ami = "ami-09b0badd34cf9696f"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = [aws_security_group.basic.id]
  key_name = aws_key_pair.my_sshkey.key_name
#  key_name = "id_rsa"
  subnet_id = module.vpc.public_subnets[0]

  connection {
    type = "ssh"
    user = "root"
   # password = "${var.root_password}"
    private_key = file("/root/.ssh/id_rsa")
    host = self.public_ip
    timeout = "3m"
  }

  provisioner "remote-exec" {
    inline = [
    "sudo yum install -y update",
    "sudo yum install -y python3",
      ]
  }
  tags = {
    NAME = "center2"
  }

}

resource "null_resource" "ansible" {

  
  
  provisioner "local-exec" {
    command = <<-EOF
       echo "[main]
       ${aws_eip.center2_eip.public_ip} ansible_ssh_user=root ansible_ssh_private_key_file=/root/.ssh/id_rsa
       [backup]
       115.68.157.254 ansible_ssh_user=root" > inventory.ini
       EOF
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini ../ansible/center2.yaml"
  } 
  depends_on = [aws_volume_attachment.backup]
}




resource "aws_key_pair" "my_sshkey" {
  key_name = "id_rsa"
  public_key = file("/root/.ssh/id_rsa.pub")
}

resource "aws_eip" "center2_eip" {
  vpc = true
  instance = aws_instance.center2_backup.id
}



