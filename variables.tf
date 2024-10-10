locals {
  user_data = fileexists("./config.yaml") ? yamldecode(file("./config.yaml")) : jsondecode(file("./config.json"))
  GENERAL   = local.user_data.General
  COMPONENT = local.user_data.Component
}


