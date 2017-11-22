# houseSpider

### Install Steps

1) Prepare aws credential

	aws configure --profile jambus2018
	
	=>input IAM key pair & region
	
	export AWS_PROFILE=jambus2018

2) Create aws EC2 instance with source package installed

Run below script to create the ec2 instance and it will print command to connect this instance via SSH:
	
	./build/build.sh jambus2018

It will create one ec2 intance and start script to install according required softwares.
Then it will download source package from Github

3) Download source package

	mkdir projects
	
	cd projects
	
	wget -O jspider.zip --no-check-certificate https://github.com/jambus/JSpider/archive/master.zip
	
	unzip jspider.zip
	
	mv JSpider-master/ JSpider
	
	rm jspider.zip
	
	sudo pip3 install pymongo


4) Prepare RDB


5) Run script

	sh ~/projects/JSpider/HouseSpider/spider.sh

TBD