data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.github.certificates[0].sha1_fingerprint
  ]
}

data "aws_iam_policy_document" "github_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.github.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:${var.github_owner}/${var.github_repository}:ref:refs/heads/main",
        "repo:${var.github_owner}/${var.github_repository}:pull_request"
      ]
    }
  }
}

resource "aws_iam_role" "terraform_plan" {
  name               = "github-actions-terraform-plan"
  assume_role_policy = data.aws_iam_policy_document.github_assume_role.json
}

data "aws_iam_policy_document" "terraform_plan" {
  statement {
    sid = "ReadTerraformState"

    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      var.terraform_state_bucket_arn,
      "${var.terraform_state_bucket_arn}/*"
    ]
  }

  statement {
    sid = "UseTerraformLockTable"

    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]

    resources = [
      var.terraform_lock_table_arn
    ]
  }

  statement {
    sid = "TerraformPlanReadOnly"

    actions = [
      "ssm:GetParameters",
      "ssm:GetParameter",

      "iam:List*",
      "iam:Get*",

      "elasticloadbalancing:Describe*",
      "ec2:Describe*",
      "autoscaling:Describe*",

      "cloudwatch:DescribeAlarms",
      "cloudwatch:GetDashboard",
      "cloudwatch:ListDashboards",
      "cloudwatch:ListMetrics",
      "cloudwatch:GetMetricData",
      "cloudwatch:GetMetricStatistics"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "terraform_plan" {
  name   = "terraform-plan-read-only"
  role   = aws_iam_role.terraform_plan.id
  policy = data.aws_iam_policy_document.terraform_plan.json
}