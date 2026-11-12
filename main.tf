data "terraform_remote_state" "network_details" {
 backend = "s3"
 config = {
  bucket = "student.59-aa7483bucket"
  key = "student.59-network-state"
  region = "ap-south-1"
 }
}

resource "aws_instance" "my_vm" {
     ami = "ami-05fbd65e334e88c16"
     subnet_id = data.terraform_remote_state.network_details.outputs.my_subnet
     instance_type = "t8i.small"
     tags = {
            Name = "student.59-vm1"
 }
}
