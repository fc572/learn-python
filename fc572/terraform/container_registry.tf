resource "aws_ecr_repository" "fc572-ecr-repo" {
  name         = "fc572-ecr-repo-tb-deleted"
  force_delete = true
  image_scanning_configuration {
    scan_on_push = false
  }
}


resource "null_resource" "docker_build_push" {
  provisioner "local-exec" {
    command = <<EOT
      # Log in to AWS ECR
      aws ecr get-login-password --region eu-west-2 | podman login --username AWS --password-stdin 045741104708.dkr.ecr.eu-west-2.amazonaws.com/fc572-ecr-repo-tb-deleted
      
      # Build your Docker image
      podman build -t 045741104708.dkr.ecr.eu-west-2.amazonaws.com/fc572-ecr-repo-tb-deleted ../
      
      # Push the Docker image to ECR
      podman push 045741104708.dkr.ecr.eu-west-2.amazonaws.com/fc572-ecr-repo-tb-deleted
    EOT
  }
}
