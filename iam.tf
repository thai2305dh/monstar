#Dinh nghia IAM va nhom
resource "aws_iam_user" "user1" {
    name = "user1"
}

resource "aws_iam_user" "user2" {
    name = "user2"
}

resource "aws_iam_group" "ec2-container-registry-power-user-group" { #group ve EC2 instance
    name = "ec2-container-registry-power-user-group"
}

# Gan users cho group
resource "aws_iam_group_membership" "assigment" {
    name =  "assigment"
    users = [
        aws_iam_user.user1.name,
        aws_iam_user.user2.name
    ]
    group = aws_iam_group.ec2-container-registry-power-user-group.name
}
resource "aws_iam_policy" "policy" {
  name        = "policy"
  path        = "/"
#   description =  policy"
# create Inline Policy chỉ định block 2 luồng truy vấn (Get) và luồng trả về (List) được viết bằng JSON
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "iam:Get*",	// các action bắt đầu bằng Get liên quan đến IAM
            "iam:List*",	// các action bắt đầu bằng List liên quan đến IAM

        ]
        Effect   = "Deny"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "role" {
  name = "role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Attach
resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  users      = [aws_iam_user.user1.name,
        aws_iam_user.user2.name
  ]
  roles      = [aws_iam_role.role.name]
  groups     = [aws_iam_group.ec2-container-registry-power-user-group.name]
policy_arn = aws_iam_policy.policy.arn
}
