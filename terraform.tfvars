###############################################################
# Terraform module to provision Lambda Python
###############################################################

aws_region  = "us-west-2"
aws_profile = "default"

project = "TEST"

custom_tags = {
  Owner     = "Dmtr"
  Createdby = "Terraform"
}

AMI           = "ami-0cf6f5c8a62fa5da6"
INSTANCE_TYPE = "t2.nano"
KEY_NAME      = "ssh_key"
SUBNET_ID     = "subnet-0123456789109da4"

