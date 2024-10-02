# Connect to the remote host via SSH, this relies on Terraform output so it must be executed within the terraform folder

ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa_house-listing-laos ec2-user@$(terraform output -json | jq -r .host.value.dns)

# You can you the IP Address, if DNS resolution doesn't work
# ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa_house-listing-laos ec2-user@$(terraform output -json | jq -r .host.value.ip)
