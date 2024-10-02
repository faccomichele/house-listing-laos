# Connect to the remote host via SSH, this relies on Terraform output so it must be executed within the terraform folder

ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa_house-listing-laos -f -N ec2-user@$(terraform output -json | jq -r .host.value.dns) -L 3306:$(terraform output -json | jq -r .rds.value)

SECRET_ARN=$(aws secretsmanager list-secrets --filters 'Key=name,Values=rds!db-' | jq -r .SecretList[0].ARN)
aws secretsmanager get-secret-value --secret-id $SECRET_ARN | jq -r .SecretString | jq -r
