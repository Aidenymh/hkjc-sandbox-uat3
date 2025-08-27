locals {
  # 读取配置文件
  network_config = yamldecode(file("../global-configs/network.yaml"))
  tag_policy_config = yamldecode(file("../global-configs/tag_policy.yaml"))

  # 区域配置
  region = try(local.network_config["region_info"]["region"], "ap-guangzhou")

  # 根据环境动态设置配置路径
  env_config_path = "../env/${var.environment}"
  
  # 动态读取环境特定配置
  env_config = try(yamldecode(file("${local.env_config_path}/config.yaml")), {})
  
}