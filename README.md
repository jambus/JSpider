# houseSpider

### Install Steps

1) Prepare aws credential

	Example:

	aws configure --profile jambus2018
	
	=>input IAM key pair & region

2) Update config-aws.cfg if required and build config properties

3) Prepare RDB instance and run sql script to initial DB schema

	./build/build-rdb.sh

4) Create aws EC2 instance with source package installed

Run below script to create the ec2 instance and it will print command to connect this instance via SSH:
	
	./build/build-ec2.sh jambus2018

It will create one ec2 intance and start script to install according required softwares.

Then it will download source package from Github and install

Then it will startup the pyspider and service on port 5000 and print the URL which can access console via browser

Then it will install airflow and service on port default 8089 and print the URL which can access console via browser


5) Load spider python scripts and execute on pyspider console

Navigate the source code **spiders** folder to select or develop the python script and load it in the pyspider console as a project.

Then change the project status "running" after debug working fine. 

It will fetch the data from website and put the data into RDS database.

6) Airflow Job configuration

TBD