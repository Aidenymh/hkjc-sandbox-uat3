output "vpc_id" {
  description = "VPC 的 ID"
  value       = { for k, v in module.vpc : k => v.vpc_id }
}

output "vpc_name" {
  description = "VPC 的名称"
  value       = { for k, v in module.vpc : k => v.vpc_name }
}

output "vpc_cidr_block" {
  description = "VPC 的 CIDR 块"
  value       = { for k, v in module.vpc : k => v.vpc_cidr_block }
}

output "vpc_dns_servers" {
  description = "VPC 的 DNS 服务器列表"
  value       = { for k, v in module.vpc : k => v.vpc_dns_servers }
}

output "vpc_is_multicast" {
  description = "VPC 是否启用多播"
  value       = { for k, v in module.vpc : k => v.vpc_is_multicast }
}

output "vpc_tags" {
  description = "VPC 的标签"
  value       = { for k, v in module.vpc : k => v.vpc_tags }
}

output "vpc_default_route_table_id" {
  description = "VPC 的默认路由表 ID"
  value       = { for k, v in module.vpc : k => v.vpc_default_route_table_id }
}

output "vpc_docker_assistant_cidrs" {
  description = "VPC Docker Assistant CIDR 列表"
  value       = { for k, v in module.vpc : k => v.vpc_docker_assistant_cidrs }
}

output "vpc_is_default" {
  description = "VPC 指示它是否是此区域的默认 VPC"
  value       = { for k, v in module.vpc : k => v.vpc_is_default }
}