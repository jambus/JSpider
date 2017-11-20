# houseSpider

# Install Steps
1) Create aws EC2 instance
aws configure --profile jambus2018
=>input IAM key pair & region
export AWS_PROFILE=jambus2018

aws ec2 run-instances --profile jambus2018 --image-id ami-15872773 --count 1 --instance-type t2.micro --key-name jambus2018-ec2 --security-group-ids sg-c02bdab9 --query 'Instances[0].InstanceId' | xargs -I {} aws ec2 create-tags --resources {} --tags Key=Name,Value=jambus_spider

2) Print command SSH to ec2
aws ec2 describe-instances --filters "Name=tag:Name,Values=jambus_spider" --query 'Reservations[0].Instances[0].PublicDnsName' | sed 's/"//g' | xargs -I {} echo "ssh -i jambus2018-ec2.pem ubuntu@{}"

2) Prepare python & pyspider

sudo apt update
sudo apt install python3-pip
pip3 install --upgrade pip
sudo pip3 install pyspider
sudo apt install unzip

3) Download source package
mkdir projects
cd projects
wget -O jspider.zip --no-check-certificate https://github.com/jambus/JSpider/archive/master.zip
unzip jspider.zip
mv JSpider-master/ JSpider
rm jspider.zip

sudo pip3 install pymongo

4) Run script
sh ~/projects/JSpider/HouseSpider/spider.sh

TBD