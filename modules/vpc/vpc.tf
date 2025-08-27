# VPC资源
resource "tencentcloud_vpc" "vpc" {
  name         = var.vpc_name
  cidr_block   = var.vpc_cidr
  dns_servers  = var.vpc_dns_servers
  is_multicast = var.vpc_is_multicast
  assistant_cidrs = var.vpc_assistant_cidrs

  # 直接使用传入的标签，不进行额外处理
  tags = var.tags

}