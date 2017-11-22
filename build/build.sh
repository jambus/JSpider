#!/bin/bash
echo "JSpider build script start to run to build the aws ec2 instance..."

#echo "Encoding the install-software script with base64"
#base64 install-software > install-software64

if [ $# -lt 1 ]; then
	echo "Use default aws profile"
	aws ec2 run-instances --image-id ami-15872773 --count 1 --instance-type t2.micro --key-name jambus2018-ec2 --security-group-ids sg-c02bdab9 \
	--query 'Instances[0].InstanceId' \
	--user-data file://install-software | xargs -I {} aws ec2 create-tags --resources {} --tags Key=Name,Value=jambus_spider
else 
	echo "Use aws profile: $1"
	aws ec2 run-instances --profile $1 --image-id ami-15872773 --count 1 --instance-type t2.micro --key-name jambus2018-ec2 --security-group-ids sg-c02bdab9 \
	--query 'Instances[0].InstanceId' \
	--user-data file://install-software | xargs -I {} aws ec2 create-tags --resources {} --tags Key=Name,Value=jambus_spider
fi

echo "ec2 instance start to create. Use below command to connect with SSH:"
aws ec2 describe-instances --filters "Name=tag:Name,Values=jambus_spider" --query 'Reservations[0].Instances[0].PublicDnsName' | sed 's/"//g' | xargs -I {} echo "ssh -i ~/jambus2018-ec2.pem ubuntu@{}"

#echo "Clean up temp files"
#rm install-software64

