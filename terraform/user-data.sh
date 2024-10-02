#!/bin/bash

set -xe

sudo yum update && sudo yum upgrade

sudo yum install -y ec2-instance-connect docker git # cronie

sudo usermod -a -G docker ec2-user
sudo systemctl enable docker && sudo systemctl start docker
# sudo systemctl enable crond && sudo systemctl start crond

sudo curl -L "https://github.com/docker/compose/releases/download/v2.29.7/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose

cd /opt && git clone https://github.com/faccomichele/house-listing-laos.git && cd house-listing-laos

SECRET_ARN=$(aws secretsmanager list-secrets --filters 'Key=name,Values=rds!db-' | jq -r .SecretList[0].ARN)
aws secretsmanager get-secret-value --secret-id $SECRET_ARN | jq -r .SecretString | jq -r

# DOMAIN=$(hostname -f | cut -d '.' -f2-)
# echo "HOSTNAME=$(hostname -f)" > .env
# echo "DOMAIN=$DOMAIN" >> .env
# docker-compose up -d

# SECURE_PASSWORD=$(openssl rand -base64 32)
# docker-compose exec mailserver setup email add admin@$DOMAIN $SECURE_PASSWORD
# docker-compose exec mailserver setup email add info@$DOMAIN $SECURE_PASSWORD
