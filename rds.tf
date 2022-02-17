# data "vault_generic_secret" "DB" {
#   path = "secret/DB"
# }

resource "aws_security_group" "private_rds" {
  # vpc_id = "vpc-0ba811da86e5e49b7"
  vpc_id = aws_vpc.aws-vpc.id
  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["${var.ingress_cidr_blocks}"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name        = "${var.app_name}-sg"
    Environment = var.app_environment
  }
}

resource "aws_db_subnet_group" "default" {
  # vpc_id = aws_vpc.aws_vpc.id
  name       = "main"
  subnet_ids = [aws_subnet.public[0].id, aws_subnet.public[1].id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "default" {
  db_subnet_group_name = aws_db_subnet_group.default.name
  allocated_storage               = 20
  identifier                      = "mysqlinstance"
  storage_type                    = "gp2"
  engine                          = "mysql"
  engine_version                  = "8.0"
  instance_class                  = "db.t2.micro"
  name                            = "test"
  username                        = var.DB_USERNAME
  password                        = var.DB_PASSWORD
  parameter_group_name            = "default.mysql8.0"
  publicly_accessible             = "true"
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  vpc_security_group_ids = ["${aws_security_group.private_rds.id}"]
  skip_final_snapshot = true
}

resource "null_resource" "setup_db1q" {
  depends_on = [aws_db_instance.default] #wait for the db to be ready
  provisioner "local-exec" {
    # command = "mysql --port=3306 -u ${var.DB_USERNAME} -p ${var.DB_PASSWORD} -h ${aws_db_instance.default.address} < ${data.local_file.sql_script.content}"
    command = "mysql --port=3306 --user=${var.DB_USERNAME} --password=${var.DB_PASSWORD} --host=${aws_db_instance.default.address} < ./scripts/1_generate_database.sql"
   }
}

resource "null_resource" "setup_db2q" {
  depends_on = [aws_db_instance.default, null_resource.setup_db1q] #wait for the db to be ready
  provisioner "local-exec" {
    command  = "mysql --port=3306 --user=${var.DB_USERNAME} --password=${var.DB_PASSWORD} --host=${aws_db_instance.default.address} < ./scripts/2_final_script_with_data.sql"
  }
}

resource "null_resource" "setup_db3q" {
  depends_on = [aws_db_instance.default, null_resource.setup_db2q] #wait for the db to be ready
  provisioner "local-exec" {
    command = "mysql --port=3306 --user=${var.DB_USERNAME} --password=${var.DB_PASSWORD} --host=${aws_db_instance.default.address} < ./scripts/3_changing_logic_for_homeworks.sql"
  }
}

resource "null_resource" "setup_db4q" {
  depends_on = [aws_db_instance.default, null_resource.setup_db3q] #wait for the db to be ready
  provisioner "local-exec" {
    command = "mysql --port=3306 --user=${var.DB_USERNAME} --password=${var.DB_PASSWORD} --host=${aws_db_instance.default.address} < ./scripts/4_update_data_for_homeworks.sql"
  }
}

resource "null_resource" "setup_db5q" {
  depends_on = [aws_db_instance.default, null_resource.setup_db4q] #wait for the db to be ready
  provisioner "local-exec" {
    command = "mysql --port=3306 --user=${var.DB_USERNAME} --password=${var.DB_PASSWORD} --host=${aws_db_instance.default.address} < ./scripts/5_adding_history_of_homeworks.sql"
  }
}

resource "null_resource" "setup_db6q" {
  depends_on = [aws_db_instance.default, null_resource.setup_db5q] #wait for the db to be ready
  provisioner "local-exec" {
    command = "mysql --port=3306 --user=${var.DB_USERNAME} --password=${var.DB_PASSWORD} --host=${aws_db_instance.default.address} < ./scripts/6_add_avatars.sql"
  }
}

resource "null_resource" "setup_db7q" {
  depends_on = [aws_db_instance.default, null_resource.setup_db6q] #wait for the db to be ready
  provisioner "local-exec" {
    command = "mysql --port=3306 --user=${var.DB_USERNAME} --password=${var.DB_PASSWORD} --host=${aws_db_instance.default.address} < ./scripts/7_add_homework_attachments.sql"
  }
}

resource "null_resource" "setup_db8q" {
  depends_on = [aws_db_instance.default, null_resource.setup_db7q] #wait for the db to be ready
  provisioner "local-exec" {
    command = "mysql --port=3306 --user=${var.DB_USERNAME} --password=${var.DB_PASSWORD} --host=${aws_db_instance.default.address} < ./scripts/8_add_students_homeworks.sql"
  }
}

resource "null_resource" "setup_db9q" {
  depends_on = [aws_db_instance.default, null_resource.setup_db8q] #wait for the db to be ready
  provisioner "local-exec" {
    command = "mysql --port=3306 --user=${var.DB_USERNAME} --password=${var.DB_PASSWORD} --host=${aws_db_instance.default.address} < ./scripts/9_add_IsActive_for_studentgroups.sql"
  }
}