# creating efs
resource "aws_efs_file_system" "efs" {
  performance_mode = "generalPurpose"
  throughput_mode = "bursting"
  tags = {
    Name = "efs"
  }
}
# mount target
resource "aws_efs_mount_target" "mount" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = aws_subnet.vpc2_subnet["vpc2-subnet-1"].id
}