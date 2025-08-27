# VPC资源
resource "tencentcloud_vpc" "vpc" {
  for_each = try(local.vpc_info, {})     # 从YAML配置文件读取的VPC信息
  name         = try(each.value.vpc_name, null)
  cidr_block   = try(each.value.cidr_block, null)
  dns_servers  = try(each.value.dns_servers, null)
  is_multicast = try(each.value.is_multicast, true)
  assistant_cidrs = try(each.value.assistant_cidrs, [])
  tags             = try(each.value.tags, null)
}