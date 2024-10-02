# Print out docker ps -a command output via SSH, this relies on Terraform output so it must be executed within the terraform folder

ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa_house-listing-laos ec2-user@$(terraform output -json | jq -r .host.value.dns) docker ps -a
