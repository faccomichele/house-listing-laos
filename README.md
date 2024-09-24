# house-listing-laos
Project for House Listing in Laos PDR

Setup: https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose#installing-wordpress-with-docker-compose

docker-compose -f ops/docker/docker-compose.yml -p my_project_name up -d
docker-compose -f ops/docker/docker-compose.yml -p my_project_name ps
docker-compose -f ops/docker/docker-compose.yml -p my_project_name logs webserver


docker-compose -p my_project_name up -d
docker-compose -p my_project_name ps
docker-compose -p my_project_name logs webserver

# automation plan
- we can have docker compose to run all the componens at the same time

# to do 
- investigate the certbot image and automate it
