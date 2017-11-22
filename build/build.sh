#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "JSpider build script start to run to build the aws ec2 instance..."

#echo "Encoding the install-software script with base64"
#base64 install-software > install-software64

if [ $# -lt 1 ]; then
	echo "Use aws profile: ${green}Default${reset}"
	instanceResourceId=`aws ec2 run-instances --image-id ami-15872773 --count 1 --instance-type t2.micro --key-name jambus2018-ec2 --security-group-ids sg-c02bdab9 \
	--query 'Instances[0].InstanceId' \
	--user-data file://install-software | sed 's/"//g'` 
else
	echo "Use aws profile: ${green}$1${reset}"
	instanceResourceId=`aws ec2 run-instances --profile $1 --image-id ami-15872773 --count 1 --instance-type t2.micro --key-name jambus2018-ec2 --security-group-ids sg-c02bdab9 \
	--query 'Instances[0].InstanceId' \
	--user-data file://install-software | sed 's/"//g'`
fi

echo "Instance Resource ID created: ${green}$instanceResourceId${reset}"
aws ec2 create-tags --resources $instanceResourceId --tags Key=Name,Value=jambus_spider

echo "ec2 instance start to create. Use below command to connect with SSH:"
#aws ec2 describe-instances --filters "Name=tag:Name,Values=jambus_spider" --query 'Reservations[0].Instances[0].PublicDnsName' | sed 's/"//g' | xargs -I {} echo "ssh -i ~/jambus2018-ec2.pem ubuntu@{}"
aws ec2 describe-instances --instance-ids $instanceResourceId --query 'Reservations[0].Instances[0].PublicDnsName' | sed 's/"//g' | xargs -I {} echo "${green}ssh -i ~/jambus2018-ec2.pem ubuntu@{}${reset}"

#echo "Clean up temp files"
#rm install-software64

