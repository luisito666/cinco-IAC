
resource "aws_efs_file_system" "bmm_efs_file_system" {
  creation_token = "bbm-file-system"

  tags = {
    Name = "MyProduct"
  }
}

resource "aws_efs_access_point" "bmm_efs_acccess_point" {
  file_system_id = aws_efs_file_system.bmm_efs_file_system.id
}

resource "aws_efs_mount_target" "mount" {
  count = length(var.subnets)
  file_system_id = aws_efs_file_system.bmm_efs_file_system.id
  subnet_id      =  element(var.subnets, count.index)
  security_groups = var.security_group_microservice
}
