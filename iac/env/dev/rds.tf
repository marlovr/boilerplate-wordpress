resource "random_integer" "snapshot" {
  min = 1
  max = 50000
}

resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  identifier           = replace("${var.app}-${var.environment}", "-", "")
  name                 = var.db_name
  username             = var.db_user
  password             = var.db_pass
  parameter_group_name = "default.mysql5.7"

  final_snapshot_identifier = replace("${var.app}-${var.environment}-${random_integer.snapshot.result}", "-", "")
  skip_final_snapshot       = true

  vpc_security_group_ids = [aws_security_group.nsg_db.id]
}

resource "aws_security_group" "nsg_db" {
  name        = "${var.app}-${var.environment}-db"
  description = "Limit connections to only internal resources"
  vpc_id      = var.vpc

  tags = var.tags
}

# Rules for the DATABASE (Task can talk to DB)
resource "aws_security_group_rule" "nsg_db_ingress_rule" {
  description              = "Only allow connections from SG ${var.app}-${var.environment}-task on port 3306"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nsg_task.id

  security_group_id = aws_security_group.nsg_db.id
}

output "db_address" {
  value = aws_db_instance.mysql.address
}
