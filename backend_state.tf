terraform {
  backend "s3" {
     bucket = "student.59-aa7483bucket"
     key = "student.59-instance-state"
     region = "ap-south-1"
  }
}
