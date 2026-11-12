data "terraform_remote_state" "network_details" {
  backend = "s3"
  config = {
    bucket = var.state_bucket_name
    key    = var.network_state_key
    region = var.aws_region
  }
}

resource "aws_instance" "my_vm" {
  ami                    = var.ami_id
  subnet_id              = data.terraform_remote_state.network_details.outputs.my_subnet
  instance_type          = var.instance_type
  key_name               = data.terraform_remote_state.network_details.outputs.key_name
  vpc_security_group_ids = data.terraform_remote_state.network_details.outputs.security_group_id_array
  tags = {
    Name = var.vm_name
  }
}
