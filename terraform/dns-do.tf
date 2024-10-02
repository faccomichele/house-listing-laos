###
# NOTE: DNS Records are hosted on Digital Ocean
###

resource "digitalocean_record" "host" {
  domain = var.domain-name
  type   = "A"
  name   = "www.${var.name}"
  value  = aws_eip.host.public_ip
  ttl    = 1800
}

output "host" {
  value = {
    dns = digitalocean_record.host.fqdn
    ip  = aws_eip.host.public_ip
  }
}
