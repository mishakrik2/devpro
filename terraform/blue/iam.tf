# Create IAM role for EC2 instances.
resource "aws_iam_role" "ec2-role" {
  name = "ec2-role"
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

resource "aws_iam_instance_profile" "ec2-profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2-role.name
}

# Create IAM policy for S3 admin access.

resource "aws_iam_role_policy" "ec2-policy" {
  name = "ec2-policy"
  role = aws_iam_role.ec2-role.id
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
    },
    {
      "Action": [
        "rds:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    
  ]
}
EOT
}


# Attach Policies to Instance Role

resource "aws_iam_policy_attachment" "ssm_attach_core" {
  name       = "test-attachment"
  roles      = [aws_iam_role.ec2-role.id]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_policy_attachment" "ssm_attach_role" {
  name       = "test-attachment"
  roles      = [aws_iam_role.ec2-role.id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}