locals {
  # 动态读取配置文件 - 根据环境变量选择对应的配置文件
  vpc_config = yamldecode(file("../../env/${var.environment}/lz-core/vpc.yaml"))

  # 区域配置
  region = try(local.vpc_config["region_info"]["region"], "ap-guangzhou")

  # VPC 配置信息
  vpc_info = try(local.vpc_config["vpc_info"], {})
}