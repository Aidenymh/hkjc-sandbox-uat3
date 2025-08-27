variable "environment" {
  description = "部署环境 (nonprod/prod)"
  type        = string
  validation {
    condition     = contains(["nonprod", "prod"], var.environment)
    error_message = "环境必须是 'nonprod' 或 'prod'。"
  }
}
