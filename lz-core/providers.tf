terraform {
  cloud {
    organization = var.tfc_organization
    workspaces {
      name = var.tfc_workspace
    }
  }
  required_version = ">=1.0.0"
  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = "~> 1.81.0"
    }
  }
}

# 腾讯云 Provider 配置
provider "tencentcloud" {
  region = var.tencentcloud_region
  # 腾讯云凭证现在通过 Terraform Cloud 环境变量管理
  # 不再需要在这里配置 secret_id 和 secret_key
}
