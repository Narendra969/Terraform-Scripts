resource "aws_db_instance" "mysqlrds" {
    allocated_storage = 10
    db_name = "mysqlrds"
    engine = "mysql"
    engine_version = "8.0.32"
    instance_class = "db.t3.micro"
    username = var.mysql_username
    password = var.mysql_password
    parameter_group_name = "default.mysql5.7"
    skip_final_snapshot = true
}