# creating subnet group
resource "aws_db_subnet_group" "subnet_group" {
  name       = "subnet_group"
  subnet_ids = [aws_subnet.subnet["subnet-5"].id, aws_subnet.subnet["subnet-6"].id]
}
# creating RDS
resource "aws_db_instance" "db" {
  allocated_storage      = 8
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.id
  db_name                = "marks_db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  multi_az               = true
  username               = "admin"
  password               = "root1234"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.database-sg.id]
  tags = {
    Name="Mysql"
  }
}