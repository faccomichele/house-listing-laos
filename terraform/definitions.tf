locals {
  my_public_ip_cidr = format("%s/32", jsondecode(data.http.my-current-public-ip.response_body).ip)
}
