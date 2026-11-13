data "terraform_remote_state" "network_details" {
  backend = "s3"
  config = {
    bucket = var.state_bucket_name
    key    = var.network_state_key
    region = var.aws_region
  }
}

module "webserver" {
  source = "./modules/linux_node"
  ami                    = "ami-04b0b8ee9ce90920a"
  instance_count = "1"
  subnet_id              = data.terraform_remote_state.network_details.outputs.my_subnet
  instance_type          = "t8i.small"
  key_name               = data.terraform_remote_state.network_details.outputs.key_name
  vpc_security_group_ids = data.terraform_remote_state.network_details.outputs.security_group_id_array
  tags = {
    Name = "student.59-vm"
  }
}
