# Create IAM role for EC2 instances.
resource "aws_iam_role" "ec2-role-fallback" {
  name = "ec2-role-fallback"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

# Create IAM profile

resource "aws_iam_instance_profile" "ec2-profile-fallback" {
  name = "ec2-profile-fallback"
  role = aws_iam_role.ec2-role-fallback.name
}

# Create IAM policy for S3 admin access.

resource "aws_iam_role_policy" "ec2-policy" {
  name = "ec2-policy"
  role = aws_iam_role.ec2-role-fallback.id
  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListAllMyBuckets"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOT
}