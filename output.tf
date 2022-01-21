output "password" {
  value = aws_iam_user_login_profile.login.*.encrypted_password
}
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}