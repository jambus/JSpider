# houseSpider

### Install Steps

1) Prepare aws credential

	aws configure --profile jambus2018
	
	=>input IAM key pair & region
	
	export AWS_PROFILE=jambus2018


2) Prepare RDB instance



3) Create aws EC2 instance with source package installed

Run below script to create the ec2 instance and it will print command to connect this instance via SSH:
	
	./build/build-ec2.sh jambus2018

It will create one ec2 intance and start script to install according required softwares.
Then it will download source package from Github and install


4) Run script

	sh ~/projects/JSpider/HouseSpider/spider.sh

TBD