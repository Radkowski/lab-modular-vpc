variable "COMPONENT" {}


locals {
  COMPONENT_WITH_CIDRS = { for k, v in var.COMPONENT.PrivateSubnets : k => merge(v, zipmap([for k, v in var.COMPONENT.PrivateSubnets : k], [for k in(cidrsubnets(var.COMPONENT.CIDR, [for k, v in var.COMPONENT.PrivateSubnets : (tonumber(v.Mask) - tonumber(regex("[0-9]*$", var.COMPONENT.CIDR)))]...)) : { "CIDR" = k }])[k]) }
}


output "VAP-DATA" {
  value = merge(var.COMPONENT, { "PrivateSubnets" : local.COMPONENT_WITH_CIDRS })
    
}
