resource "aws_cloudwatch_log_group" "log-group" {
  name = "${var.name}-logs"

  tags = {
    Application = var.name
  }
}
