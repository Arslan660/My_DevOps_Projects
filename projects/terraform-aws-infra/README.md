# AWS Infrastructure with Terraform (Modular)

A modular, environment-based Terraform setup that provisions a production-style AWS network: a VPC with **public and private subnets across two availability zones**, a **NAT Gateway** for private subnet outbound access, and an **EC2 web server** — all defined as reusable modules.

## Architecture

```
                        Internet
                           │
                    ┌──────┴──────┐
                    │ Internet GW │
                    └──────┬──────┘
              ┌────────────┴────────────┐
      ┌───────┴───────┐         ┌───────┴───────┐
      │ Public Subnet │         │ Public Subnet │   (AZ-a / AZ-b)
      │  (+ EC2, NAT) │         │               │
      └───────┬───────┘         └───────────────┘
              │ NAT Gateway
      ┌───────┴───────┐         ┌───────────────┐
      │ Private Subnet│         │ Private Subnet│   (AZ-a / AZ-b)
      └───────────────┘         └───────────────┘
```

## Why Modular Structure
Instead of one large `main.tf`, infrastructure is split into **reusable modules** (`modules/vpc`, `modules/ec2`) called from an **environment folder** (`environments/dev`). This mirrors how Terraform is structured in real teams — the same modules could be reused to spin up a `staging` or `prod` environment just by adding another environment folder with different variable values.

## Project Structure
```
terraform-aws-infra/
├── modules/
│   ├── vpc/                  # VPC, subnets (public+private), NAT gateway, route tables
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── ec2/                  # Security group + EC2 instance
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── environments/
│   └── dev/
│       ├── provider.tf       # Provider + optional S3 remote backend
│       ├── variables.tf
│       ├── main.tf           # Calls the vpc and ec2 modules
│       └── outputs.tf
└── README.md
```

## What This Provisions
- 1 VPC
- 2 public subnets + 2 private subnets (across 2 AZs, for high availability)
- 1 Internet Gateway (public internet access)
- 1 NAT Gateway + Elastic IP (so private subnets can reach the internet outbound without being publicly exposed)
- Public and private route tables, correctly associated
- 1 EC2 instance in the public subnet with a security group (SSH, HTTP, HTTPS)

## Usage
```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

To tear down:
```bash
terraform destroy
```

## Remote State (Optional)
`provider.tf` includes a commented-out `backend "s3"` block. In a real team setting, this would point to an S3 bucket so state is shared and locked properly instead of living only on one person's machine.

## What I Learned
- Structuring Terraform into **modules** vs. one monolithic file, and why that matters for reusability
- Difference between **public and private subnets**, and why private subnets need a **NAT Gateway** for outbound-only internet access
- Using **count** and splat expressions (`[*]`) to provision multiple subnets from a list of CIDR blocks instead of duplicating resource blocks
- Passing outputs from one module (VPC) as inputs to another module (EC2)
- Why remote state (S3 backend) matters for team-based infrastructure management
