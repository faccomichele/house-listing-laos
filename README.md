# house-listing-laos
Project for House Listing in Laos PDR

Setup: https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose#installing-wordpress-with-docker-compose

wp plugins setup: https://www.radiustheme.com/how-to-create-rental-property-website/#why-clclassified


# Install AWS CLI

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
sudo ./aws/install


docker-compose -f ops/docker/docker-compose.yml -p my_project_name up -d
docker-compose -f ops/docker/docker-compose.yml -p my_project_name ps
docker-compose -f ops/docker/docker-compose.yml -p my_project_name logs webserver


docker-compose up -d
docker-compose ps
docker-compose logs webserver
docker-compose down

docker-compose exec webserver ls -la /etc/letsencrypt/live

docker exec -it wordpress /bin/ash

# automation plan
- we can have docker compose to run all the componens at the same time
- the wordpress folder will change and we need to be able to respan the application with all the changes (including the customer's ones), so we need to store it somewhere else
- the database will change too, so we need a backup plan for it
- backup and restore from somewhere (maybe s3)? hourly backup to s3 for mysql too?
- if this is so, we don't need to change the docker images, as we connect a pre-existing dataset for those
- maintenance: do the bakcup 

- DEV > PACK > DEPLOY <> BACKUP

# to do 
- investigate the certbot image and automate it

# configure pingdom for avail checks

# ditroless options
https://medium.com/@sajal.devops/docker-on-a-diet-distroless-images-for-security-speed-2a4145f5c56d

# I am not a robot
https://stevesohcot.medium.com/php-tutorial-how-to-implement-a-captcha-im-not-a-robot-checkbox-using-google-e8f110590141
