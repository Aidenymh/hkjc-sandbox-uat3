module "vpc" {
  source     = "../../../modules/vpc"
  for_each   = try(local.vpc_info, {})
  vpc_name   = try(each.value.vpc_name, null)
  vpc_cidr   = try(each.value.cidr_block, null)
  tags       = try(each.value.tags, null)                  
  vpc_dns_servers    = try(each.value.dns_servers, null)
  vpc_is_multicast = try(each.value.is_multicast, null)
  vpc_assistant_cidrs = try(each.value.assistant_cidrs, null)
}