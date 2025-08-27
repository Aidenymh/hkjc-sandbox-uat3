# 🚀 Issue-Based Deployment Guide

这个项目使用GitHub Issues来触发Terraform Cloud的部署，而不是传统的push触发方式。

## 📋 如何使用

### 1. 创建部署请求Issue

1. 在GitHub仓库中点击 "Issues" 标签
2. 点击 "New issue"
3. 选择 "🚀 Deployment Request" 模板
4. 填写以下信息：
   - **Environment**: 选择 `nonprod` 或 `prod`
   - **TFC Organization**: 你的Terraform Cloud组织名称（可选）
   - **TFC Workspace**: 你的Terraform Cloud工作空间名称（可选）
   - **Deployment Description**: 部署描述（可选）

### 2. 自动标签

确保issue包含 `deploy` 标签。如果使用模板，这个标签会自动添加。

### 3. 触发部署

当issue被创建或编辑时，GitHub Actions会自动：
1. 解析issue内容中的参数
2. 触发Terraform Cloud的部署
3. 在issue下添加确认评论

## 🔧 参数说明

### Environment
- **nonprod**: 非生产环境
- **prod**: 生产环境

### TFC Organization
- 如果未指定，将使用仓库secrets中的默认值
- 格式：`your-org-name`

### TFC Workspace
- 如果未指定，将使用默认模式：`tencent-core-network-{environment}`
- 例如：`tencent-core-network-nonprod`

## 📝 Issue内容示例

```
Environment: nonprod
Organization: my-company
Workspace: my-vpc-workspace
Description: Deploy VPC changes for testing
```

或者简单填写：

```
Environment: prod
Description: Production deployment for new features
```

## ⚠️ 注意事项

1. **权限要求**: 确保GitHub Actions有权限访问仓库和Terraform Cloud
2. **Secrets配置**: 需要在仓库secrets中配置：
   - `TFC_TOKEN`: Terraform Cloud API令牌
   - `TFC_ORG`: 默认的Terraform Cloud组织名称
3. **标签要求**: issue必须包含 `deploy` 标签才会触发工作流
4. **参数验证**: 如果某些参数未指定，系统会使用默认值并显示警告

## 🔍 故障排除

### 工作流未触发
- 检查issue是否包含 `deploy` 标签
- 确认issue内容格式正确

### 参数解析错误
- 检查issue内容中的参数格式
- 确保环境名称拼写正确（nonprod 或 prod）

### TFC连接失败
- 验证 `TFC_TOKEN` 是否有效
- 确认组织和工作空间名称正确
- 检查网络连接和防火墙设置

## 📚 相关链接

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Terraform Cloud API Documentation](https://www.terraform.io/docs/cloud/api/index.html)
- [Issue Templates](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/configuring-issue-templates-for-your-repository)
