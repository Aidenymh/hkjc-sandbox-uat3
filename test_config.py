#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
测试配置文件读取的脚本
"""

import yaml
import os

def test_config_reading():
    """测试配置文件读取"""
    
    # 测试 nonprod 环境
    print("=== 测试 nonprod 环境配置 ===")
    nonprod_config_path = "env/nonprod/lz-core/vpc.yaml"
    
    if os.path.exists(nonprod_config_path):
        with open(nonprod_config_path, 'r', encoding='utf-8') as f:
            config = yaml.safe_load(f)
            print(f"✅ nonprod 配置文件读取成功")
            print(f"   区域: {config.get('region_info', {}).get('region', 'N/A')}")
            print(f"   VPC 数量: {len(config.get('vpc_info', {}))}")
            for vpc_name, vpc_config in config.get('vpc_info', {}).items():
                print(f"   - {vpc_name}: {vpc_config.get('vpc_name', 'N/A')}")
    else:
        print(f"❌ nonprod 配置文件不存在: {nonprod_config_path}")
    
    print("\n=== 测试 prod 环境配置 ===")
    prod_config_path = "env/prod/lz-core/vpc.yaml"
    
    if os.path.exists(prod_config_path):
        with open(prod_config_path, 'r', encoding='utf-8') as f:
            config = yaml.safe_load(f)
            print(f"✅ prod 配置文件读取成功")
            print(f"   区域: {config.get('region_info', {}).get('region', 'N/A')}")
            print(f"   VPC 数量: {len(config.get('vpc_info', {}))}")
            for vpc_name, vpc_config in config.get('vpc_info', {}).items():
                print(f"   - {vpc_name}: {vpc_config.get('vpc_name', 'N/A')}")
    else:
        print(f"❌ prod 配置文件不存在: {prod_config_path}")

if __name__ == "__main__":
    test_config_reading()
