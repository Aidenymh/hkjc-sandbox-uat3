# 🚀 Terraform GitHub Actions 工作流使用指南

这个项目使用GitHub Actions来自动化Terraform的Plan和Apply过程，支持手动触发和自动触发两种模式。

## 📋 工作流概述

工作流包含三个主要阶段：
1. **Terraform Plan** - 生成执行计划
2. **手动审批** - 等待人工确认
3. **Terraform Apply** - 执行部署

## 🔧 触发方式

### 1. 手动触发 (workflow_dispatch)

在GitHub仓库的Actions页面，你可以手动触发工作流并指定以下参数：

#### 必需参数
- **Environment**: 选择部署环境
  - `nonprod` - 非生产环境
  - `prod` - 生产环境

#### 可选参数
- **TFC Organization**: Terraform Cloud组织名称
  - 默认值: `hkjc-sandbox-uat`
- **TFC Workspace**: Terraform Cloud工作空间名称
  - 默认值: `sandbox-uat-test`
- **Confirm Apply**: 是否确认执行Apply
  - 默认值: `false`

### 2. 自动触发

- **Push to main**: 推送到main分支时自动触发
- **Pull Request**: 创建PR时触发（仅Plan）

## 📊 变量传递机制

### GitHub Actions → Terraform 变量映射

| GitHub Actions 输入 | Terraform 变量 | 环境变量 | 说明 |
|---------------------|----------------|----------|------|
| `environment` | `var.environment` | `TF_VAR_environment` | 部署环境 |
| `tfc_organization` | `var.tfc_organization` | `TF_VAR_tfc_organization` | TFC组织 |
| `tfc_workspace` | `var.tfc_workspace` | `TF_VAR_tfc_workspace` | TFC工作空间 |

### 变量传递流程

1. **用户输入** → GitHub Actions workflow_dispatch inputs
2. **环境变量** → 通过 `TF_VAR_*` 前缀传递给Terraform
3. **Terraform使用** → 在 `lz-core` 目录中执行

## 🚀 使用方法

### 手动触发部署

1. 进入GitHub仓库的 **Actions** 标签页
2. 选择 **Terraform** 工作流
3. 点击 **Run workflow** 按钮
4. 填写部署参数：
   ```
   Environment: nonprod
   TFC Organization: hkjc-sandbox-uat
   TFC Workspace: sandbox-uat-test
   Confirm Apply: false
   ```
5. 点击 **Run workflow** 开始执行

### 自动部署流程

1. **推送代码到main分支**
   - 自动触发Plan阶段
   - 生成执行计划
   - 创建审批issue

2. **人工审批**
   - 查看Plan结果
   - 在issue中回复批准命令
   - 系统自动执行Apply

3. **部署完成**
   - 查看Apply结果
   - 检查部署状态

## 📝 审批命令

在审批issue中，使用以下命令：

### 批准部署
- `approved`
- `approve`
- `lgtm`
- `yes`

### 拒绝部署
- `denied`
- `deny`
- `no`

## 🔍 故障排除

### 工作流未触发
- 检查分支名称是否为 `main`
- 确认文件路径在 `lz-core` 目录下
- 验证GitHub Actions权限设置

### 变量传递失败
- 检查环境变量名称是否正确
- 确认Terraform变量定义存在
- 查看工作流日志中的环境变量检查

### TFC连接失败
- 验证 `TFC_TOKEN` secret是否正确
- 确认组织和工作空间名称
- 检查网络连接和防火墙设置

## 📚 相关文件

- `.github/workflows/deploy.yml` - 主要工作流文件
- `lz-core/` - Terraform代码目录
- `DEPLOYMENT_README.md` - 详细部署说明

## ⚠️ 注意事项

1. **权限要求**: 确保GitHub Actions有足够权限
2. **Secrets配置**: 需要配置 `TFC_TOKEN` secret
3. **目录结构**: Terraform代码必须在 `lz-core` 目录中
4. **审批流程**: 生产环境部署需要人工审批
5. **变量验证**: 确保所有必需的Terraform变量都已定义

## 🔗 相关链接

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Terraform Cloud Documentation](https://www.terraform.io/docs/cloud)
- [Hashicorp Setup Terraform Action](https://github.com/hashicorp/setup-terraform)
