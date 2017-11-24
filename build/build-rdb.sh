#!/bin/bash
source base.cfg

echo -e "\nJSpider build script start to run to build the aws RDB instance..."

# Create rdb security group
rdbSecurityGroup=`aws ec2 describe-security-groups --group-names rdb-spider-securitygroup --query 'SecurityGroups[0].GroupId'`
if [ $? -ne 0 ]; then
	rdbSecurityGroup=`aws ec2 create-security-group --group-name rdb-spider-securitygroup --description "rdb-spider security group" --query 'GroupId' | sed 's/"//g'`

	myip=`curl -s https://api.ipify.org`
	aws ec2 authorize-security-group-ingress --group-name rdb-spider-securitygroup --protocol tcp --port 5432 --cidr $myip/32

	echo "Security group created: ${green}$rdbSecurityGroup${reset}"
else
	rdbSecurityGroup=`echo $rdbSecurityGroup | sed 's/"//g'`
	echo "Security group used: ${green}$rdbSecurityGroup${reset}"
fi


# create RDB postgres manually on AWS
# psql -h spider.cwjm8lssrlxz.ap-northeast-1.rds.amazonaws.com -p 5432 -U root -d postgres -f db.sql
#It will ask to input db root password

