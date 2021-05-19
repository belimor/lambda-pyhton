#######################
# Function variables
#######################

variable "aws_project" {
  description = ""
  type        = string
  default     = ""
}

variable "function_name" {
  description = ""
  type        = string
  default     = "HelloWorld"
}

variable "description" {
  description = ""
  type        = string
  default     = "Hello World Lambda Function"
}

variable "memory_size" {
  description = ""
  type        = number
  default     = 128
}

variable "timeout" {
  description = ""
  type        = number
  default     = 3
}

# variable "publish" {
#   description = ""
#   type        = bool
#   default     = false
# }

variable "environment_variables" {
  description = ""
  type        = map(string)
  default     = {}
}