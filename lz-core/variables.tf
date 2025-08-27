# ========================================
# Stacks 变量定义
# ========================================

# 腾讯云认证信息
#variable "tencentcloud_secret_id" {
#  description = "腾讯云 Secret ID"
#  type        = string
#  sensitive   = true
#}
#
#variable "tencentcloud_secret_key" {
#  description = "腾讯云 Secret Key"
#  type        = string
#  sensitive   = true
#}

variable "tencentcloud_region" {
  description = "腾讯云区域"
  type        = string
  default     = "ap-guangzhou"
}

# 环境标签
variable "environment_tags" {
  description = "环境特定标签"
  type        = map(string)
  default = {
    Environment = "nonprod"
    ManagedBy   = "terraform"
    Project     = "hkjc-sandbox"
  }
}

# 新增：环境标识变量，用于区分不同环境
variable "environment" {
  description = "部署环境 (nonprod/prod)"
  type        = string
  default     = "nonprod"
  validation {
    condition     = contains(["nonprod", "prod"], var.environment)
    error_message = "环境必须是 'nonprod' 或 'prod'。"
  }
}

# 新增：TFC 组织名称
variable "tfc_organization" {
  description = "Terraform Cloud 组织名称"
  type        = string
  default     = "hkjc-sandbox-uat"
}

# 新增：TFC 工作空间名称
variable "tfc_workspace" {
  description = "Terraform Cloud 工作空间名称"
  type        = string
  default     = "tencent-core-network-nonprod"
} 