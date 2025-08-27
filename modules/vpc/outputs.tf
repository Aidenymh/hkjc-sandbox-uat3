output "vpc_id" {
  description = "VPC 的 ID"
  value       = tencentcloud_vpc.vpc.id
}

output "vpc_name" {
  description = "VPC 的名称"
  value       = tencentcloud_vpc.vpc.name
}

output "vpc_cidr_block" {
  description = "VPC 的 CIDR 块"
  value       = tencentcloud_vpc.vpc.cidr_block
}

output "vpc_dns_servers" {
  description = "VPC 的 DNS 服务器列表"
  value       = tencentcloud_vpc.vpc.dns_servers
}

output "vpc_is_multicast" {
  description = "VPC 是否启用多播"
  value       = tencentcloud_vpc.vpc.is_multicast
}

output "vpc_tags" {
  description = "VPC 的标签"
  value       = tencentcloud_vpc.vpc.tags
}

output "vpc_default_route_table_id" {
  description = "VPC 的默认路由表 ID"
  value       = tencentcloud_vpc.vpc.default_route_table_id
} 

output "vpc_docker_assistant_cidrs" {
  description = "VPC Docker Assistant CIDR 列表"
  value       = tencentcloud_vpc.vpc.docker_assistant_cidrs
} 

output "vpc_is_default" {
  description = "VPC 指示它是否是此区域的默认 VPC"
  value       = tencentcloud_vpc.vpc.is_default
}

output "vpc_created" {
  description = "VPC 是否已创建"
  value       = true
}

 