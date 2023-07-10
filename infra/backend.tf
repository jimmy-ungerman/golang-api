terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "tf-state-golang-api"
    key            = "terraform/golang-api-eks"
    region         = "us-east-1"
  }
}