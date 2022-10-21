resource "aws_ecs_task_definition" "fc572_first_task" {
  family                   = "fc572-first-task" # Naming our first task
  container_definitions    = <<DEFINITION
  [
    {
      "name": "fc572-first-task",
      "image": "${aws_ecr_repository.fc572-ecr-repo.repository_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 8080,
          "hostPort": 8080
        }
      ],
      "memory": 1024,
      "cpu": 256,
      "entryPoint": ["bash","/app/bin/run.sh"]
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"] # Stating that we are using ECS Fargate
  network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
  memory                   = 1024        # Specifying the memory our container requires
  cpu                      = 256         # Specifying the CPU our container requires
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
}