# Lambda Function
output "lambda_function_arn" {
  description = "Lambda Function ARN"
  value       = element(concat(aws_lambda_function.this.*.arn, [""]), 0)
}

output "lambda_function_invoke_arn" {
  description = "Lambda Function Invoke ARN"
  value       = element(concat(aws_lambda_function.this.*.invoke_arn, [""]), 0)
}

output "lambda_function_name" {
  description = "Lambda Function name"
  value       = element(concat(aws_lambda_function.this.*.function_name, [""]), 0)
}