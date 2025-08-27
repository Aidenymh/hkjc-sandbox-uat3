# ========================================
# Stacks 输出定义
# ========================================

# 输出 VPC 模块信息
output "vpc_module_outputs" {
  description = "VPC 模块的输出信息"
  value       = module.vpc
}
