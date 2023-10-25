data "aws_caller_identity" "current" {}


data "aws_iam_policy_document" "assume_by_codebuild" {
  statement {
    sid     = "AllowAssumeByCodebuild"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codebuild" {
  name               = "${var.project}-codebuild-role"
  assume_role_policy = "${data.aws_iam_policy_document.assume_by_codebuild.json}"
}

data "aws_iam_policy_document" "codebuild" {
  statement {
    sid    = "S3"
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "codebuild"
    effect = "Allow"

    actions = [
      "codebuild:*"
    ]

    resources = [
      aws_codebuild_project.terraformplan.arn,
      aws_codebuild_project.terraformapply.arn
      ]
  }

    statement {
    sid    = "codepipeline"
    effect = "Allow"

    actions = [
      "codepipeline:*"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "Lambda"
    effect = "Allow"

    actions = [
      "lambda:*"
    ]

    resources = [
      module.lambda.function_arn
      ]
  }

  statement {
    sid    = "IAM"
    effect = "Allow"

    actions = [
      "iam:ListRoles",
      "iam:GetRole",
      "iam:ListRolePolicies",
      "iam:GetRolePolicy",
      "iam:ListAttachedRolePolicies",
      "iam:CreateRole"
    ]

    resources = ["*"]
  }

    statement {
    sid    = "Codestar"
    effect = "Allow"

    actions = [
      "codestar-connections:GetConnection",
			"codestar-connections:CreateConnection",
			"codestar-connections:TagResource",
			"codestar-connections:ListConnections",
      "codestar-connections:ListTagsForResource"
    ]

    resources = [
      aws_codestarconnections_connection.connect.arn,
      "arn:aws:codestar-connections:${var.aws_region}:*"
    ]
  }

  statement {
    sid    = "API"
    effect = "Allow"

    actions = [
      "apigateway:*"
    ]

    resources = [
      module.apigw.apigw_arn,
      module.apigw.apigw_stage_arn,
      "${module.apigw.apigw_arn}/integrations/${module.apigw.apigw_integration_id}",
      "${module.apigw.apigw_arn}/routes/${module.apigw.apigw_routes_id}",
      "arn:aws:apigateway:${var.aws_region}::*"
    ]
  }
  

  statement {
    sid    = "AllowLogging"
    effect = "Allow"

    actions = [
      "logs:*"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "codebuild" {
  role   = "${aws_iam_role.codebuild.name}"
  policy = "${data.aws_iam_policy_document.codebuild.json}"
}


data "aws_iam_policy_document" "assume_by_pipeline" {
  statement {
    sid = "AllowAssumeByPipeline"
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "pipeline" {
  name = "${var.project}-pipeline-service-role"
  assume_role_policy = "${data.aws_iam_policy_document.assume_by_pipeline.json}"
}

data "aws_iam_policy_document" "pipeline" {
  statement {
    sid = "S3"
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = ["*"]
  }

  statement {
    sid = "IAM"
    effect = "Allow"

    actions = [
      "iam:PassRole",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:CreateRole"
    ]

    resources = ["*"]
  }

  statement {
    sid = "AllowCodebuild"
    effect = "Allow"

    actions = [
      "codebuild:*"
    ]
    resources = ["*"]
  }

  statement {
    sid = "AllowCodestar"
    effect = "Allow"

    actions = [
      "codestar-connections:UseConnection"
    ]
    resources = ["*"]
  }
  
  statement {
    sid = "AllowCodedepoloy"
    effect = "Allow"

    actions = [
      "codedeploy:CreateDeployment",
      "codedeploy:GetApplication",
      "codedeploy:GetApplicationRevision",
      "codedeploy:GetDeployment",
      "codedeploy:GetDeploymentConfig",
      "codedeploy:RegisterApplicationRevision"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "pipeline" {
  role = "${aws_iam_role.pipeline.name}"
  policy = "${data.aws_iam_policy_document.pipeline.json}"
}