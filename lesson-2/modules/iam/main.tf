resource "aws_iam_user" "nguyendt15_iam" {
  name = "nguyendt15-iam"
}

resource "aws_iam_access_key" "nguyendt15_iam_access_key" {
  user = aws_iam_user.nguyendt15_iam.name
}

resource "aws_iam_group" "nguyendt15_iam_group" {
  name = "nguyendt15-iam-group"
}

resource "aws_iam_group_policy" "nguyendt15_iam_group_policy" {
  name = "nguyendt15-iam-policy"
  group = aws_iam_group.nguyendt15_iam_group.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
		  "ec2:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_group_membership" "nguyendt15_iam_group_membership" {
  name = "nguyendt15-iam-membership"
  group = aws_iam_group.nguyendt15_iam_group.name

  users = [
    aws_iam_user.nguyendt15_iam.name
  ]
}