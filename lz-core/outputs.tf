# ========================================
# Stacks 输出定义
# ========================================

# 输出当前环境
output "current_environment" {
  description = "当前部署环境"
  value       = var.environment
}

# 输出环境配置路径
output "env_config_path" {
  description = "环境配置文件路径"
  value       = local.env_config_path
}

# 输出 VPC 模块信息
output "vpc_module_outputs" {
  description = "VPC 模块的输出信息"
  value       = module.vpc
}
