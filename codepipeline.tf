resource "aws_codestarconnections_connection" "connect" {
  name          = "github-connection"
  provider_type = "GitHub"
}


resource "aws_codepipeline" "pipeline" {
  name = "${var.project}-pipeline"
  role_arn = "${aws_iam_role.pipeline.arn}"

  artifact_store {
    location = "${var.project}-codepipeline-buckets"
    type = "S3"
  }

  stage {
    name = "Source"

    action {
      name = "Source"
      category = "Source"
      owner = "AWS"
      provider = "CodeStarSourceConnection"
      version = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.connect.arn
        FullRepositoryId = "${local.github_owner}/${local.github_repo}"
        BranchName = "${local.github_branch}"
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Plan"

    action {
      name = "Build"
      category = "Build"
      owner = "AWS"
      provider = "CodeBuild"
      version = "1"
      input_artifacts = ["SourceArtifact"]
      configuration = {
        ProjectName = aws_codebuild_project.terraformplan.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name = "ExternalDeploy"
      category = "Build"
      owner = "AWS"
      provider = "CodeBuild"
      input_artifacts = ["SourceArtifact"]
      version = "1"

      configuration = {
        ProjectName = aws_codebuild_project.terraformapply.name
      }
    }
  }
}
