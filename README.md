
# terraform-aws-apache-example

Terraform Module to provision an EC2 Instance running Apache HTTP server.

> Not for production use. This is a demo module to showcase creating a public Terraform module on the Terraform Registry.

---

## 📁 Folder Structure

```
terraform-aws-apache-example/
├── main.tf
├── variables.tf
├── outputs.tf
├── userdata.yaml
├── terraform.tfvars.example
├── .gitignore
└── README.md
```

---

## 1. Installing Prerequisites

### ✅ Install Git

Download and install Git from: https://git-scm.com/downloads

Verify installation:

```bash
git --version
```

### ✅ Install Visual Studio Code

Download and install VS Code from: https://code.visualstudio.com/

---

## 2. Install Terraform on Windows 10 using Git Bash Terminal in VS Code

1. Download the latest Terraform zip for Windows from the [Terraform downloads page](https://developer.hashicorp.com/terraform/downloads).
2. Extract the `terraform.exe` binary.
3. Move `terraform.exe` to a folder on your system PATH, for example `C:\terraform`.
4. Add this folder to your system environment variables `PATH` if not already present.
5. Restart your Git Bash terminal in VS Code.
6. Verify installation:

```bash
terraform -version
```

---

## 3. Fork and Clone the GitHub Repo

1. **Fork this repository** on GitHub to your own account by clicking the "Fork" button.
2. Clone your forked repository to your local machine:

```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/terraform-aws-apache-example.git
cd terraform-aws-apache-example
```

3. Commit the provided `.gitignore` **before adding any sensitive files**:

```bash
git add .gitignore
git commit -m "Add .gitignore to protect sensitive files"
git push origin main
```

---

## 4. Creating SSH Keys (For First-Time Users)

If you don't already have an SSH key pair, generate one:

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
clip < ~/.ssh/id_rsa.pub  # Copies public key to clipboard on Windows
```

Use the public key in your `terraform.tfvars` file:

```hcl
public_key = "ssh-rsa AAAAB3..."
```

---

## 5. Configure AWS CLI

Configure AWS credentials (stored in `~/.aws/credentials`):

```bash
aws configure --profile default
```

---

## 6. Using the Module

### ✅ Copy the example tfvars file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Then edit `terraform.tfvars` to include your actual values.

### ✅ Initialize Terraform

```bash
terraform init
```

### ✅ Validate Configuration

```bash
terraform validate
```

### ✅ Preview with Plan

```bash
terraform plan -var-file="terraform.tfvars"
```

### ✅ Apply and Deploy

```bash
terraform apply -var-file="terraform.tfvars" -auto-approve
```

### ✅ Get the Public IP

```bash
terraform output public_ip
```

### ✅ SSH Into Your Instance

```bash
ssh -i ~/.ssh/id_rsa ec2-user@$(terraform output -raw public_ip)
```

---

## 7. Apache Server Troubleshooting

If Apache doesn’t show in the browser:

- ✅ Run `curl http://<public_ip>` from a terminal — if you see HTML, Apache is running.
- ✅ Try using a non-Incognito browser window.
- ✅ Confirm port 80 is open in the security group.
- ✅ Ensure `userdata.yaml` installs & starts Apache.

To manually check Apache status via SSH:

```bash
ssh -i ~/.ssh/id_rsa ec2-user@<public_ip>
sudo systemctl status httpd
```

---

## 8. Terraform Provider Configuration

The provider is configured to use the AWS CLI named profile `default` and region `us-east-1`:

```hcl
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}
```

---

## 9. Credential Safety Best Practices

- ❌ Never hardcode AWS access keys or secrets in `.tf` files.
- ✅ Use AWS CLI named profiles stored in `~/.aws/credentials`.
- ✅ Keep sensitive files like private keys and `terraform.tfvars` out of Git using `.gitignore`.
- 🎥 For demos, do not show terminal output with credentials or open those files live.

---

## Notes

- This module creates an AWS EC2 instance running Apache with SSH access restricted to your public IP.
- The HTTP port (80) is open to the world.
- Use this module as a learning/demo tool — **not for production**.
