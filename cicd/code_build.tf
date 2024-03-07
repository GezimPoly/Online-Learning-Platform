resource "aws_codebuild_project" "example" {
  name         = "oln-codebuild"
  service_role = aws_iam_role.example.arn
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type         = "LINUX_CONTAINER"
  }
  source {
    type            = "CODECOMMIT"
    location        = data.aws_codecommit_repository.repo.clone_url_http
    git_clone_depth = 1
    
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
  source_version = "main"
}