#!/bin/bash

# Remove AWS execute command
# sudo apt-get install --only-upgrade python-pip
# sudo pip uninstall requests
# sudo pip install requests

echo "Start to execute startup.sh ..."
source base.cfg

if [ -f /sys/hypervisor/uuid ] && [ `head -c 3 /sys/hypervisor/uuid` == ec2 ]; then
    echo -e "Start EC2 mode..."

    rdsInstanceAddress=`aws rds describe-db-instances --db-instance-identifier $aws_rds_name --query 'DBInstances[0].Endpoint.Address' | sed 's/"//g'`
    echo -e "Add RDS address into config properties: ${green}$rdsInstanceAddress${reset}"
    properties+=("aws_rds_address=$rdsInstanceAddress")

    parseTemplateWithConfigProp pyspider-config-ec2.template > pyspider-config-ec2.json

    pyspider -c build/pyspider-config-ec2.json
else
    echo -e "Start local mode..."
    pyspider -c build/pyspider-config-local.json
fi

pyspider -c build/config-ec2.json