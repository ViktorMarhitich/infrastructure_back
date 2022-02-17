data "vault_generic_secret" "DB" {
  path = "secret/DB"
}

resource "aws_db_instance" "default" {
    allocated_storage = 20
    identifier = "mysqlinstance"
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.m5.large"
    name = "test"
    username = data.vault_generic_secret.DB.data["DB_USERNAME"]
    password = data.vault_generic_secret.DB.data["DB_PASSWORD"]
    parameter_group_name = "default.mysql8.0"
    publicly_accessible = "true"
    enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
}