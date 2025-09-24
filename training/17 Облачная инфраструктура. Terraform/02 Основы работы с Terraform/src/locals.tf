locals {
  # name-web = "netology-develop-platform-web"
  name-web = "netology-${var.vpc_name}-${var.loc_plat}-web"

  # name-db = "netology-develop-platform-db"
  name-db = "netology-${var.vpc_name}-${var.loc_plat}-db"
}