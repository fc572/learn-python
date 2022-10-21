resource "aws_ecr_repository" "fc572-ecr-repo" {
  name = "fc572-ecr-repo"
  image_scanning_configuration {
    scan_on_push = false
  }
}
