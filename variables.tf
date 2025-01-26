data "aws_availability_zones" "AZs" {
  state = "available"
}

locals {
  user_data  = fileexists("./config.yaml") ? yamldecode(file("./config.yaml")) : jsondecode(file("./config.json"))
  GENERAL    = local.user_data.General
  COMPONENT  = local.user_data.Component
  ID_to_NAME = zipmap(data.aws_availability_zones.AZs.zone_ids, data.aws_availability_zones.AZs.names)
}



