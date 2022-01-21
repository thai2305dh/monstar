resource "aws_iam_user_login_profile" "login" {
    #name = "login"
  user = aws_iam_user.user1.name
  password_reset_required = true
  pgp_key = "keybase:thainguyen23"
}