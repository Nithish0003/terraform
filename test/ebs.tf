# ebs volume creation
resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = "ap-south-1a"
  size              = 1
  tags = {
    Name = "ebs-volume"
  }
}
# attaching ebs volume
resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_volume.id
  instance_id = aws_instance.vpc2_instance["vpc2-test-1"].id
}