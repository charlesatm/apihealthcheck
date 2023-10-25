resource "aws_codebuild_project" "terraformplan" {
  name         = "${var.project}-plan-codebuild"
  description  = "Terraform plan through CodeBuild"
  service_role = "${aws_iam_role.codebuild.arn}"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "hashicorp/terraform:latest"
    type            = "LINUX_CONTAINER"
  }

  source {
     type   = "CODEPIPELINE"
     buildspec = file("./pipeline/buildspec-plan.yml")
 }
}


resource "aws_codebuild_project" "terraformapply" {
  name         = "${var.project}-apply-codebuild"
  description  = "Terraform Apply through CodeBuild"
  service_role = "${aws_iam_role.codebuild.arn}"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "hashicorp/terraform:latest"
    type            = "LINUX_CONTAINER"
  }

  source {
     type   = "CODEPIPELINE"
     buildspec = file("./pipeline/buildspec-apply.yml")
 }
}
