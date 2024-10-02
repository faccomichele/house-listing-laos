resource "aws_db_subnet_group" "host" {
  name_prefix = "${var.name}-host-rds-subnet-group"
  subnet_ids  = aws_subnet.public[*].id
  tags        = {
    Name     = "${var.name}-host-rds-subnet-group"
    Template = "rds.tf"
  }
}

resource "aws_db_instance" "host" {
  identifier_prefix                   = "${var.name}-host-rds-"
  allocated_storage                   = 20
  engine                              = "mariadb"
  auto_minor_version_upgrade          = true
  engine_version                      = "10.11"
  instance_class                      = "db.t4g.micro"
  publicly_accessible                 = false
  network_type                        = "IPV4"
  storage_type                        = "gp2" # It seems like if you pick gp3 instead, you get charged by the GB...
  skip_final_snapshot                 = true # change to 'false' when we start to use the application for real
  # snapshot_identifier                 =
  # final_snapshot_identifier           =
  copy_tags_to_snapshot               = true
  apply_immediately                   = true
  username                            = "joseph"
  manage_master_user_password         = true
  db_subnet_group_name                = aws_db_subnet_group.host.id
  vpc_security_group_ids              = [ aws_security_group.rds.id ]
  iam_database_authentication_enabled = true
  tags                                = {
    Name     = "${var.name}-host-rds"
    Template = "rds.tf"
  }
}

output "rds" {
  value = aws_db_instance.host.endpoint
}
