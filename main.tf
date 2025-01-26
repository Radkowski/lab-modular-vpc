
module "VAP" {
  source = "./vap"
  COMPONENT = merge({ "Tags" = local.COMPONENT.Tags },
    { "CIDR" = local.COMPONENT.CIDR },
    { "PrivateSubnets" = { for k, v in local.COMPONENT.PrivateSubnets : k =>
      { Mask = v.Mask
        TAGS = v.TAGS
        AZ   = local.ID_to_NAME[v.AZ]
      }
    } }
  )
}

module "ACE-VPC" {
  source    = "./vpc"
  GENERAL   = local.GENERAL
  COMPONENT = module.VAP.VAP-DATA
}


output "VAP-DATA" {
  value = module.VAP.VAP-DATA
}
