# verification and preparation module

variable "COMPONENT" {}

data "aws_availability_zones" "AZs" {
  state = "available"
}

locals {


  # this section update original config by adding CIDR to each defined subnet
  COMPONENT_WITH_CIDRS = { for k, v in var.COMPONENT.PrivateSubnets : k => merge(v, zipmap([for k, v in var.COMPONENT.PrivateSubnets : k], [for k in(cidrsubnets(var.COMPONENT.CIDR, [for k, v in var.COMPONENT.PrivateSubnets : (tonumber(v.Mask) - tonumber(regex("[0-9]*$", var.COMPONENT.CIDR)))]...)) : { "CIDR" = k }])[k]) }


  # this section checks if availability zones has been defined correctly (for example AZ *-d has been defined where thare are only a,b,c). If VALIDATE_ASC is NOT empty, it means that mistake has been made
  VALIDATE_AZS = setsubtract(distinct([for k, v in var.COMPONENT.PrivateSubnets : join("", [data.aws_availability_zones.AZs.id, lower(v["AZ"])])]), data.aws_availability_zones.AZs.names)


  # this section updates config by adding proper availability zones name
  UPDATE_AZS    = { for k, v in local.COMPONENT_WITH_CIDRS : k => merge(v, { "AZ" = join("", [data.aws_availability_zones.AZs.id, lower(v["AZ"])]) }) }

  # this section updates the main config
  NEW_COMPONENT = merge(var.COMPONENT, { "PrivateSubnets" : local.UPDATE_AZS })

}


output "VAP-DATA" {
  value   = local.NEW_COMPONENT
    
}

output "VAP-ERROR" {
    value = length(local.VALIDATE_AZS) == 0 ? false : true
  
}