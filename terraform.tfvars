###############################################################
# Terraform module to provision Lambda StopEC2
###############################################################

aws_region  = "us-west-2"
aws_profile = "default"
aws_project = "TEST"

project_tags = {
  owner     = "Name"
  createdby = "Terraform"
}

AMI           = "ami-0cf6f5c8a62fa5da6"
INSTANCE_TYPE = "t2.nano"
KEY_NAME      = "ssh_key"
SUBNET_ID     = "subnet-update-id"
