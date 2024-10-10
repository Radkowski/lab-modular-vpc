
module "VAP" {
  source    = "./vap"
  COMPONENT = local.COMPONENT
}

module "ACE-VPC" {
  source    = "./vpc"
  GENERAL   = local.GENERAL
  COMPONENT = module.VAP.VAP-DATA
  STATUS    = module.VAP.VAP-ERROR

}


output "VAP-DATA" {
  value = module.VAP.VAP-DATA
}

