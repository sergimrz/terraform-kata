# Define full name with the prefix and the name to avoid duplicate code
# and apply the same naming to all components.
locals {
  fullname = "${var.prefix}-${var.name}"
}

# Define iam user
resource "aws_iam_user" "user" {
  name = var.toggle_suffix ? "${local.fullname}-user" : "${local.fullname}"
}

# Define iam group
resource "aws_iam_group" "group" {
  name = "${local.fullname}-group"
}

# Attach user to group
resource "aws_iam_group_membership" "team" {
  name = var.toggle_suffix ? "${local.fullname}-membership" : "${local.fullname}"
  users = [
    aws_iam_user.user.name,
  ]
  group = aws_iam_group.group.name
}

# Define role allowing all users from the account to assume the role.
resource "aws_iam_role" "role" {
  name = var.toggle_suffix ? "${local.fullname}-role" : "${local.fullname}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "${var.account}"    # Take account from variables
        }
      },
    ]
  })
}

# Create policy with permissions to assume the previous role
resource "aws_iam_policy" "policy" {
  name = var.toggle_suffix ? "${local.fullname}-policy" : "${local.fullname}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   =  "sts:AssumeRole"
        Effect   = "Allow"
        Resource = aws_iam_role.role.arn
      },
    ]
  })
}

# Attach the policy to the iam group
resource "aws_iam_group_policy_attachment" "group-policy-attach" {
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.policy.arn
}
