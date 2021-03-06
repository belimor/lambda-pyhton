variable "aws_project" {
  type        = string
  description = "Project name"
}

variable "aws_region" {
  type        = string
  description = "AWS deployment region"
}

variable "aws_profile" {
  type        = string
  description = "AWS credentials profile"
}

variable "project_tags" {
  description = ""
  type        = map(string)
}

variable "AMI" {}
variable "INSTANCE_TYPE" {}
variable "KEY_NAME" {}
variable "SUBNET_ID" {}

variable "environment_variables" {
  description = ""
  type        = map(string)
}
