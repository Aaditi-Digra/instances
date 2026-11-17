resource "aws_instance" "my_vm" {
  count = var.instance_count
  ami                    = var.ami
  subnet_id              = var.subnet_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  tags = var.tags
}

resource "null_resource" "install_package" {
  count = length(aws_instance.my_vm)>0 ? 1 :0
  depends_on = [time_sleep.wait_30_seconds, local_file.inventory]
  provisioner "local-exec" {
       command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user -i ./tf_ansible_${var.install_package}_inventory.ini -i ./tf_ansible_webservers_inventory.ini ../ansible-playbooks/${var.playbook_name} --private-key '../keys/student.59-vm-key'"
  }
}

resource "time_sleep" "wait_30_seconds" {
  depends_on      = [aws_instance.my_vm]
  create_duration = "30s"
}

resource "local_file" "inventory" {
  filename = "${path.root}/tf_ansible_${var.install_package}_inventory.ini"
  content  = <<-EOT
    [${var.install_package}]
    %{ for ip in aws_instance.my_vm[*].public_ip ~}
    ${ip}
    %{ endfor ~}
  EOT
}
