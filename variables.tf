variable "state_bucket_name" {
  description = "S3 bucket storing the networking remote state"
  type        = string
  default     = "student.59-aa7483bucket"
}

variable "network_state_key" {
  description = "S3 key for the networking state file"
  type        = string
  default     = "student.59-network-state"
}

variable "aws_region" {
  description = "AWS region where resources and state bucket reside"
  type        = string
  default     = "ap-south-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-05fbd65e334e88c16"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t8i.small"
}

variable "vm_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "student.59-vm1"
}
