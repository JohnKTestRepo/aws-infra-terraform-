# 🚀 Terraform AWS EC2 Apache Server (Modular + GitHub Actions)

This project provisions a simple **EC2 instance running Apache** on **AWS**, using **Terraform modules** for cleaner structure and **GitHub Actions** for continuous deployment.  
When you push changes to the main branch, GitHub Actions automatically runs Terraform to apply updates to your AWS environment.

---

## 🧱 Project Structure

```
aws-infra-terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── .github/
│   └── workflows/
│       └── terraform.yml
├── modules/
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── security_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── key_pair/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── userdata.yaml
│     
└── README.md

```

---

## ⚙️ Prerequisites

Before starting, ensure the following are ready:

1. **AWS Account** with permissions to create EC2 instances and related resources.
2. **AWS Access Key** and **Secret Key** stored in GitHub as secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
3. **GitHub Repository** linked to your local environment.
4. **Terraform** installed locally (`v1.6+` recommended).
5. **Ubuntu 24.04 LTS (WSL2)** setup with Git and Terraform.

---

## 🌍 Terraform Configuration Files

### provider.tf
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.6.0"
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
```

### main.tf
```hcl
module "ec2_apache" {
  source          = "./modules/ec2_apache"
  instance_name   = var.instance_name
  instance_type   = var.instance_type
  ami_id          = var.ami_id
  key_name        = var.key_name
}
```

### terraform.tfvars
```hcl
aws_region     = "us-east-2"
aws_access_key = "YOUR_AWS_ACCESS_KEY"
aws_secret_key = "YOUR_AWS_SECRET_KEY"
instance_name  = "MyApacheServer"
instance_type  = "t2.micro"
ami_id         = "ami-0c55b159cbfafe1f0" # Ubuntu 22.04 AMI (Ohio)
key_name       = "my-ec2-keypair"
```

---

## 🧩 Module: EC2 Apache

`modules/ec2_apache/main.tf`
```hcl
resource "aws_instance" "apache_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y apache2
              sudo systemctl enable apache2
              sudo systemctl start apache2
              echo "<h1>Hello from Terraform Apache Server</h1>" | sudo tee /var/www/html/index.html
              EOF

  tags = {
    Name = var.instance_name
  }
}
```

---

## 🤖 GitHub Actions Workflow

`.github/workflows/terraform.yml`
```yaml
name: "Terraform Apply"

on:
  push:
    branches:
      - main

jobs:
  terraform:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.6.6

      - name: Terraform Init
        run: terraform init

      - name: Terraform Plan
        run: terraform plan -input=false

      - name: Terraform Apply
        run: terraform apply -auto-approve -input=false
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

---

## 🧪 How to Use

### 1️⃣ Clone Repo
```bash
git clone https://github.com/JohnKTestRepo/aws-infra-terraform.git
cd aws-infra-terraform
```

### 2️⃣ Initialize Terraform
```bash
terraform init
```

### 3️⃣ Apply Infrastructure
```bash
terraform apply -auto-approve
```

### 4️⃣ Verify Deployment
After the deployment, open your EC2 instance’s public IP in a browser:
```
http://<EC2_PUBLIC_IP>
```

You should see:
> **Hello from Terraform Apache Server**

---

## 🔄 Automate with GitHub Actions

Once configured, every push to the **main branch** will:
1. Initialize Terraform
2. Plan changes
3. Apply updates automatically to AWS

---

## 🧹 Cleanup
To remove all created resources:
```bash
terraform destroy -auto-approve
```

---

## 🧭 Next Steps
- Add more modules for VPC, Security Groups, and Load Balancers.
- Store AWS credentials in a separate **Terraform Cloud workspace** or use **OIDC authentication** for improved security.
- Extend your GitHub workflow with `terraform fmt` and `terraform validate` checks.

---

### ✨ Author
**John Kennedy**  
AWS & Azure DevOps Certified | Navy Veteran | Cloud & ML Engineer  
