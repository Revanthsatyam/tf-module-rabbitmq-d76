#!/bin/bash

set-hostname rabbitmq
yum install ansible -y &>>/opt/userdata.log
ansible-pull -i localhost, -U https://github.com/Revanthsatyam/roboshop-ansible-d76.git -e component=rabbitmq main.yml &>>/opt/userdata.log