#!/bin/bash

# Remove AWS execute command
# sudo apt-get install --only-upgrade python-pip
# sudo pip uninstall requests
# sudo pip install requests

echo "Start to execute startup.sh ..."

if [ -f /sys/hypervisor/uuid ] && [ `head -c 3 /sys/hypervisor/uuid`=="ec2" ]; then
    echo -e "Start EC2 mode..."

    pyspider -c build/pyspider-config-ec2.json > pyspider.log
else
    echo -e "Start local mode..."
    pyspider -c build/pyspider-config-local.json
fi