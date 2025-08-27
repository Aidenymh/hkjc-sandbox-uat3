# VPC 网络地址块
variable "vpc_cidr" {
  description = <<-EOT
    (必需) 网络地址块，必须是以下内网网段的子网：
    - 10.0.0.0/16
    - 172.16.0.0/12
    - 192.168.0.0/16
  EOT
  type        = string
}

# VPC 名称
variable "vpc_name" {
  description = "(必需) VPC 的名称"
  type        = string
}

# 辅助 CIDR 列表
variable "vpc_assistant_cidrs" {
  description = <<-EOT
    (可选) 辅助 CIDR 列表，注意：
    - 仅包含键入的 CIDR
    - 按只读方式检查 Docker CIDR
    - 类型为 StringNORMALassistant_docker_cidrs
  EOT
  type        = set(string)
  default     = []
}

# DNS 服务器列表
variable "vpc_dns_servers" {
  description = "(可选) VPC 的 DNS 服务器列表"
  type        = list(string)
  default     = []
}

# 多播功能开关
variable "vpc_is_multicast" {
  description = "(可选) 是否启用 VPC 多播，默认值: true"
  type        = bool
  default     = true
}

# VPC 标签 - 通过标签注入模式传入
variable "tags" {
  description = "(可选) VPC 的标签映射，由调用方通过tag_policy模块生成"
  type        = map(string)
  default     = {}
}

# 注意：标签验证已移至调用层，不再需要此变量

