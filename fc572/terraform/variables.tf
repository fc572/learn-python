variable "region" {
  description = "AWS Region, defaults to London"
  default     = "eu-west-2"
}

variable "profile" {
  description = "The credentials to be used"
  default     = "deep-dive"
}

variable "cluster_name" {
  description = "The name of the cluster. It is a param so that terratest can create multiple cluster for parallel testing"
  default = "fc572-cluster"
}

variable "load_balancer_name" {
  description = "The load balancer name"
  default = "fc572-lb-tf" # Naming our load balancer
}