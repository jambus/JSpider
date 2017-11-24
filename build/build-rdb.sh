#!/bin/bash
source base.cfg

echo -e "\nJSpider build script start to run to build the aws RDS instance..."

# Create rds security group if require
rdsSecurityGroup=`aws ec2 describe-security-groups --group-names rds-spider-securitygroup --query 'SecurityGroups[0].GroupId'`
if [ $? -ne 0 ]; then
	rdbSecurityGroup=`aws ec2 create-security-group --group-name rds-spider-securitygroup --description "rds-spider security group" --query 'GroupId' | sed 's/"//g'`

	myip=`curl -s https://api.ipify.org`
	aws ec2 authorize-security-group-ingress --group-name rds-spider-securitygroup --protocol tcp --port 5432 --cidr $myip/32
	#aws ec2 revoke-security-group-ingress --group-name rds-spider-securitygroup --protocol tcp --port 5432 --cidr $myip/32

	echo "Security group created: ${green}$rdsSecurityGroup${reset}"
else
	rdsSecurityGroup=`echo $rdsSecurityGroup | sed 's/"//g'`
	echo "Security group used: ${green}$rdsSecurityGroup${reset}"
fi

# Create RDS instance if require

rdsInstanceAddress=`aws rds describe-db-instances --db-instance-identifier $aws_rds_name --query 'DBInstances[0].Endpoint.Address'`
if [ $? -ne 0 ]; then
	aws rds create-db-instance --db-instance-identifier $aws_rds_name --vpc-security-group-ids $rdsSecurityGroup \
	--allocated-storage 20 --db-instance-class db.t2.micro --engine postgres \
	--master-username $aws_rds_master --master-user-password $aws_rds_password

	echo "RDS start to create: ${green}$aws_rds_name${reset}"

	echo -e "Please wait a moment until DB instance ready..."
	aws rds wait db-instance-available --db-instance-identifier $aws_rds_name
else
	echo "RDS exist and no require to create: ${green}$aws_rds_name${reset}"
fi

rdsInstanceAddress=`aws rds describe-db-instances --db-instance-identifier $aws_rds_name --query 'DBInstances[0].Endpoint.Address' | sed 's/"//g'`
rdsInstancePort=`aws rds describe-db-instances --db-instance-identifier $aws_rds_name --query 'DBInstances[0].Endpoint.Port'`
echo -e "RDS address to connect: ${green}$rdsInstanceAddress:$rdsInstancePort${reset}"

echo -e "\nRDS is ready. Start to initial DB schema & user..."
PGPASSWORD=$aws_rds_password psql -h $rdsInstanceAddress -p $rdsInstancePort -U $aws_rds_master -d postgres -f db.sql	

echo "Script complete!"


#PGPASSWORD=vdyg85VC psql -h spider-rdb.cwjm8lssrlxz.ap-northeast-1.rds.amazonaws.com -p 5432 -U rootjambus -d postgres -f db.sql

