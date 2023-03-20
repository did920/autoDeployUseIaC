# autoDeployUseIaC  
Terraform과 ansible 을 활용하여 그룹웨어들을 aws로 이관 프로젝트  
공부한 내용 정리이기에 사내 정보가 들어가 있는 항목은 전부 삭제 처리함(app 파일, 자료, id/pw 등)  

## 프로젝트 개요  
약 2개월 간 작업, 혼자서 진행

## 동작 방식  
### Terraform  
provider aws 사용, awscli와 연동
사전에 vars에 기록한 자원들을 바탕으로 aws 자원 배포(vpc, subnet, ec2, EBS 등)
output 과정에서 ansible 실행  

### ansible
ansible galaxy에서 주로 배포하는 방식대로 디렉토리 구성  
1. 처음 key_exchange 호출하여 백업 서버와 키 교환  
2. 필요한 모듈 호출하여 application, db, db.conf, java 환경 등을 구성하고 배포
