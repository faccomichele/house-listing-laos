resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.host.id
  tags   = {
    Name     = "${var.name}-igw"
    Template = "routing.tf"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.host.id
  tags   = {
    Name     = "${var.name}-rt-public"
    Template = "routing.tf"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
  count          = 2
}

resource "aws_route" "public-internet-ipv4" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet.id
}

resource "aws_route" "public-internet-ipv6" {
  route_table_id              = aws_route_table.public.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.internet.id
}
