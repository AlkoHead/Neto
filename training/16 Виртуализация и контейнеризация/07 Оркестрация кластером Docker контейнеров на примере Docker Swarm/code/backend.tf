# где хроним стейт
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}