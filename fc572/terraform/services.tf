resource "aws_ecs_service" "fc572_first_service" {
  name            = "fc572-first-service"                             # Naming our first service
  cluster         = "${aws_ecs_cluster.fc572_cluster.id}"             # Referencing our created Cluster
  task_definition = "${aws_ecs_task_definition.fc572_first_task.arn}" # Referencing the task our service will spin up
  launch_type     = "FARGATE"
  desired_count   = 3 # Setting the number of containers we want deployed to 1 (it was 3)

  load_balancer {
    target_group_arn = "${aws_lb_target_group.target_group.arn}" # Referencing our target group
    container_name   = "${aws_ecs_task_definition.fc572_first_task.family}"
    container_port   = 8080 # Specifying the container port
  }
   
 network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}", "${aws_default_subnet.default_subnet_c.id}"]
    assign_public_ip = true # Providing our containers with public IPs
    security_groups  = ["${aws_security_group.service_security_group.id}"]
  }
}