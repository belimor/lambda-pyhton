#data "aws_lambda_layer_version" "Lambda-Layer" {
#  layer_name = "Lambda-Layer"
#  version    = 1
#}

# resource "aws_lambda_layer_version" "My-Lambda-Layer" {
#   layer_name          = "My-Lambda-Layer"
#   description         = "Create my lambda layer"
#   compatible_runtimes = ["python3.7"]
#   s3_bucket  = "s3-bucket-name"
#   s3_key     = "file-name.zip"
# }

