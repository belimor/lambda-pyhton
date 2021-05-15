##############################
# IAM Roles
##############################

resource "aws_iam_role" "Lambda-Role" {
  name                = "${var.project}-Lambda-Role"
  #managed_policy_arns = [data.aws_iam_policy.AWSLambdaBasicExecutionRole.arn, ]

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "Lambda-Policy" {
  name = "${var.project}-Lambda-Policy"
  role = aws_iam_role.Lambda-Role.id

  policy = templatefile("${path.module}/lambda-Policy.tmpl", {
    account_id = data.aws_caller_identity.current.account_id,
    region     = data.aws_region.current.name
  })
}