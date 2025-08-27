# Terraform HKJC Sandbox UAT3 Infrastructure

This repository contains Terraform configurations for managing cloud infrastructure in the HKJC (Hong Kong Jockey Club) sandbox UAT3 environment. The project follows a modular architecture with environment-specific configuration management.

## 📁 Directory Structure

```
terraform-hkjc-sandbox-uat3/
├── .github/                          # GitHub Actions workflows
│   └── workflows/
│       └── deploy.yml               # CI/CD pipeline for Terraform deployment
├── env/                             # Environment-specific configurations
│   ├── nonprod/                     # Non-production environment
│   │   └── lz-core/                # Landing Zone core configurations
│   │       └── vpc.yaml            # VPC configuration for nonprod
│   └── prod/                        # Production environment
│       └── lz-core/                # Landing Zone core configurations
│           └── vpc.yaml            # VPC configuration for prod
├── lz-core/                         # Landing Zone core stack
│   ├── main.tf                     # Main stack configuration
│   ├── variables.tf                # Variable definitions
│   ├── outputs.tf                  # Output definitions
│   ├── providers.tf                # Provider configurations
│   └── locals.tf                   # Local variable definitions
├── modules/                         # Reusable Terraform modules
│   └── vpc/                        # VPC module
│       ├── main.tf                 # Module main configuration
│       ├── variables.tf            # Module variables
│       ├── outputs.tf              # Module outputs
│       ├── locals.tf               # Module local variables
│       └── versions.tf             # Module version constraints
└── README.md                       # This file
```

## 🏗️ Architecture Overview

### Landing Zone Core (`lz-core/`)
The landing zone core acts as the main orchestrator that:
- Manages the overall infrastructure stack
- Orchestrates module deployments
- Handles environment-specific configurations
- Provides centralized outputs and state management

### Modules (`modules/`)
Reusable, self-contained Terraform configurations:
- **VPC Module**: Manages Virtual Private Cloud resources
- Each module follows Terraform best practices with proper variable definitions, outputs, and version constraints

### Environment Configuration (`env/`)
Environment-specific configurations stored as YAML files:
- **Non-production (`nonprod/`)**: Development, testing, and staging environments
- **Production (`prod/`)**: Live production environment
- Each environment has its own configuration files that can be version controlled separately

## 🔄 Environment Switching Mechanism

### How It Works

The project uses a dynamic configuration loading approach that automatically switches between environments based on the `environment` variable:

1. **Variable Definition**: The `environment` variable is defined in `lz-core/variables.tf`:
   ```hcl
   variable "environment" {
     description = "Deployment environment (nonprod/prod)"
     type        = string
     default     = "nonprod"
     validation {
       condition     = contains(["nonprod", "prod"], var.environment)
       error_message = "Environment must be 'nonprod' or 'prod'."
     }
   }
   ```

2. **Dynamic Configuration Loading**: Modules dynamically read environment-specific configurations:
   ```hcl
   # In modules/vpc/locals.tf
   locals {
     vpc_config = yamldecode(file("../env/${var.environment}/lz-core/vpc.yaml"))
     region = try(local.vpc_config["region_info"]["region"], "ap-guangzhou")
     vpc_info = try(local.vpc_config["vpc_info"], {})
   }
   ```

3. **Environment-Specific Files**: Each environment has its own configuration files:
   - `env/nonprod/lz-core/vpc.yaml` - Non-production VPC settings
   - `env/prod/lz-core/vpc.yaml` - Production VPC settings

### Switching Environments

#### Method 1: Command Line Variable
```bash
# Deploy to non-production
terraform plan -var="environment=nonprod"

# Deploy to production
terraform plan -var="environment=prod"
```

#### Method 2: Environment Variable
```bash
# Set environment variable
export TF_VAR_environment=prod

# Run Terraform commands
terraform plan
terraform apply
```

#### Method 3: GitHub Actions (CI/CD)
The GitHub Actions workflow automatically uses the environment from secrets:
```yaml
env:
  TF_VAR_environment: ${{ github.event.inputs.environment || 'nonprod' }}
```

## 🚀 Getting Started

### Prerequisites
- Terraform >= 1.0
- Tencent Cloud CLI configured
- Access to Terraform Cloud (if using remote state)

### Initial Setup
1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd terraform-hkjc-sandbox-uat3
   ```

2. **Navigate to the landing zone core**:
   ```bash
   cd lz-core
   ```

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

4. **Select environment and plan**:
   ```bash
   # For non-production
   terraform plan -var="environment=nonprod"
   
   # For production
   terraform plan -var="environment=prod"
   ```

### Configuration Files

#### VPC Configuration Example (`env/nonprod/lz-core/vpc.yaml`)
```yaml
region_info:
  region: ap-guangzhou

vpc_info:
  vpc01:
    vpc_name: hkjc-sandbox-nonprod-vpc01
    cidr_block: 10.0.0.0/16
    assistant_cidrs: 
      - 172.16.0.0/16
    dns_servers: 
      - 183.60.82.98
      - 183.60.83.19
    is_multicast: false
    tags:
      create-project: hkjc-sandbox-nonprod-vpc01
      create-owner: terraform
```

## 🔧 Module Development

### Adding New Modules
1. Create a new directory in `modules/`
2. Follow the standard module structure:
   - `main.tf` - Main resource definitions
   - `variables.tf` - Input variables
   - `outputs.tf` - Output values
   - `versions.tf` - Version constraints
   - `locals.tf` - Local variables and configuration loading

3. Update the main stack in `lz-core/main.tf` to include the new module

### Module Configuration Pattern
Modules should follow this pattern for environment-specific configurations:
```hcl
locals {
  config = yamldecode(file("../env/${var.environment}/lz-core/<module-name>.yaml"))
  # Use the config variable for resource creation
}
```

## 🚦 CI/CD Pipeline

The project includes GitHub Actions workflows for automated deployment:

- **Automatic Triggers**: Push to main branch, pull requests
- **Manual Triggers**: Workflow dispatch with environment selection
- **Approval Process**: Manual approval required for production deployments
- **Environment Management**: Automatic environment variable injection from GitHub Secrets

## 📋 Best Practices

1. **Environment Isolation**: Keep environment-specific configurations separate
2. **Configuration as Code**: Use YAML files for environment-specific settings
3. **Module Reusability**: Design modules to be environment-agnostic
4. **State Management**: Use Terraform Cloud for remote state management
5. **Security**: Store sensitive values in GitHub Secrets, not in code

## 🆘 Troubleshooting

### Common Issues

1. **Configuration File Not Found**: Ensure the environment variable is set correctly
2. **Module Path Issues**: Verify relative paths in module configurations
3. **Provider Authentication**: Check Tencent Cloud credentials and region settings

### Debug Commands
```bash
# Enable debug logging
export TF_LOG=DEBUG

# Check environment variables
echo $TF_VAR_environment

# Validate configuration
terraform validate
```

## 📚 Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [Tencent Cloud Provider Documentation](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices)

## 🤝 Contributing

1. Create a feature branch from `main`
2. Make your changes following the established patterns
3. Test with both environments
4. Submit a pull request with detailed description

## 📄 License

This project is proprietary to HKJC. All rights reserved.
