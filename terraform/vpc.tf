resource "aws_vpc" "host" {
  cidr_block                       = var.cidr
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = true
  tags                             = {
    Name     = "${var.name}-host-vpc"
    Template = "vpc.tf"
  }
}

resource "aws_subnet" "public" {
  vpc_id                          = aws_vpc.host.id
  cidr_block                      = cidrsubnet(var.cidr, 2, count.index)
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.host.ipv6_cidr_block, 8, count.index)
  assign_ipv6_address_on_creation = true
  availability_zone               = data.aws_availability_zones.available.names[count.index]
  count                           = 2
  tags                            = {
    Name     = "${var.name}-host-public-${data.aws_availability_zones.available.names[count.index]}"
    Template = "vpc.tf"
  }
}
