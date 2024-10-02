resource "aws_vpc_endpoint" "s3" {
  vpc_id = aws_vpc.host.id
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "Allow full access to S3"
        Principal = "*"
        Effect    = "Allow"
        Action    = "s3:*"
        Resource  = "arn:aws:s3:::*"
      }
    ]
  })

  tags ={
    Name     = "s3-endpoint-${var.name}-host"
    Template = "s3.tf"
  }
}

resource "aws_vpc_endpoint_route_table_association" "s3-public" {
  route_table_id = aws_route_table.public.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

resource "aws_s3_bucket" "host" {
  bucket = "${var.name}-host-bucket-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name     = "Bucket for ${var.name}-host"
    Template = "s3.tf"
  }
}
