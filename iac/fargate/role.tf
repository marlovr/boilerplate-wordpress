

# creates an application role that the container/task runs as
resource "aws_iam_role" "app_role" {
  name               = "${var.app}-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.app_role_assume_role_policy.json
}

# assigns the app policy
resource "aws_iam_role_policy" "app_policy" {
  name   = "${var.app}-${var.environment}"
  role   = aws_iam_role.app_role.id
  policy = data.aws_iam_policy_document.app_policy.json
}

resource "aws_iam_role_policy" "uploads" {
  name = "${var.app}-${var.environment}-s3"
  role = aws_iam_role.app_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:DeleteObjectTagging",
                "s3:ListBucketMultipartUploads",
                "s3:DeleteObjectVersion",
                "s3:ListBucket",
                "s3:DeleteObjectVersionTagging",
                "s3:GetBucketAcl",
                "s3:ListMultipartUploadParts",
                "s3:PutObject",
                "s3:GetObjectAcl",
                "s3:GetObject",
                "s3:AbortMultipartUpload",
                "s3:DeleteObject",
                "s3:GetBucketLocation",
                "s3:PutObjectAcl"
            ],
            "Resource": [
                "arn:aws:s3:::uploads.bland.monster/*",
                "arn:aws:s3:::uploads.bland.monster"
            ]
        },
        {
            "Effect": "Allow",
            "Action": "s3:HeadBucket",
            "Resource": "*"
        }
    ]
}
EOF
}

# TODO: fill out custom policy
data "aws_iam_policy_document" "app_policy" {
  statement {
    actions = [
      "ecs:DescribeClusters",
    ]

    resources = [
      aws_ecs_cluster.app.arn,
    ]
  }
}

data "aws_caller_identity" "current" {
}

# allow role to be assumed by ecs and local saml users (for development)
data "aws_iam_policy_document" "app_role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::776691755094:user/wordpress-boilerplate",
      ]
    }
  }
}
