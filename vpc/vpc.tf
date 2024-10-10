variable "GENERAL" {}

variable "COMPONENT" {}

variable "STATUS" {
  description = "Config validation"
  validation {
    condition     = var.STATUS == false
    error_message = "Config Error detected"
  }
}


resource "aws_vpc" "AceVPC" {
  cidr_block                       = var.COMPONENT.CIDR
  instance_tenancy                 = "default"
  enable_dns_hostnames             = "true"
  assign_generated_ipv6_cidr_block = "false"
  tags                             = var.COMPONENT.Tags
}


resource "aws_subnet" "Priv-Subnets" {
  for_each                        = var.COMPONENT.PrivateSubnets
  vpc_id                          = aws_vpc.AceVPC.id
  cidr_block                      = each.value["CIDR"]
  availability_zone               = each.value["AZ"]
  assign_ipv6_address_on_creation = false
  map_public_ip_on_launch         = false
  tags                            = each.value["TAGS"]
}


resource "aws_route_table" "PrivRT" {
  vpc_id     = aws_vpc.AceVPC.id
  timeouts {
    create = "5m"
  }
}


resource "aws_route_table_association" "PrivAssociation" {
  for_each = aws_subnet.Priv-Subnets
  subnet_id      = each.value["id"]
  route_table_id = aws_route_table.PrivRT.id
}



output "VPC-DATA" {
  value = {
    "whatever": "you"
    "want": "to return"
    
  }
}


