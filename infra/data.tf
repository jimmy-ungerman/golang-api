data "aws_availability_zones" "available" {}

locals {
  cluster_name = "golang-api-demo"
}