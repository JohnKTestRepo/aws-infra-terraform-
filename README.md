# terraform-aws-apache-example

Terraform Module to provision an EC2 Instance running Apache HTTP server.

> Not for production use. This is a demo module to showcase creating a public Terraform module on the Terraform Registry.
> 

## **Folder structure**

```css
terraform-aws-apache-example/
├── main.tf
├── variables.tf
├── outputs.tf
├── userdata.yaml
├── terraform.tfvars.example
├── .gitignore
└── README.md
```

## 1. How to install Terraform on Windows 10 using Git Bash Terminal in VS Code

1. Download the latest Terraform zip for Windows from the Terraform downloads page.
2. Extract the `terraform.exe` binary.
3. Move `terraform.exe` to a folder on your system PATH, for example `C:\terraform`.
4. Add this folder to your system environment variables `PATH` if not already present.
5. Restart your Git Bash terminal in VS Code.
6. Verify installation:

```bash
terraform -version

```

---

## 2. Usage

1. **Fork this repository** on GitHub to your own account by clicking the "Fork" button at the top right of the repo page.
2. Clone your forked repository to your local machine:

```bash
git clone <https://github.com/YOUR_GITHUB_USERNAME/terraform-aws-apache-example.git>
cd terraform-aws-apache-example

```

1. Commit the provided `.gitignore` **before adding any sensitive files**:
    
    ```bash
    git add .gitignore
    git commit -m "Add .gitignore to protect sensitive files"
    git push origin main
    ```
    
2. Configure your AWS CLI profile (run once before the demo):
    
    ```bash
    aws configure --profile default (name of profile you created)
    ```
    
3. Copy `terraform.tfvars.example` to `terraform.tfvars` and update your values (do **not** commit this file):
    
    ```bash
    cp terraform.tfvars.example terraform.tfvars
    ```
    
    **Edit** `terraform.tfvars` to add your own values for VPC ID, IP, keys, etc.
    
4. Initialize Terraform:
    
    ```bash
    terraform init
    ```
    
5. Validate configuration:
    
    ```bash
    terraform validate
    ```
    
6. Preview changes with plan:
    
    ```bash
    terraform plan -var-file="terraform.tfvars"
    ```
    
7. Deploy resources:
    
    ```bash
    terraform apply -var-file="terraform.tfvars" -auto-approve
    ```
    
8. Get the public IP output:
    
    ```bash
    terraform output public_ip
    ```
    
9. (Optional) SSH into your EC2 instance:
    
    ```bash
    ssh -i ~/.ssh/id_rsa ec2-user@$(terraform output -raw public_ip)
    ```
    

---

### **Terraform Provider Configuration**

The provider is configured to use the AWS CLI named profile `default` and region `us-east-1`:

```hcl
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}
```

---

### Credential Safety Best Practices

When working with Terraform and AWS, it’s crucial to keep your AWS credentials and private keys secure:

- **Never hardcode AWS access keys or secrets** directly in your Terraform files or commit them to version control.
- Use **AWS CLI named profiles** stored securely in your `~/.aws/credentials` file, and specify the profile in your Terraform provider configuration (e.g., `profile = "default"`).
- Keep sensitive files like private keys and `terraform.tfvars` **excluded from Git** by listing them in `.gitignore`.
- During live demos or recordings, **avoid showing your credentials on screen** — do not open or display credential files or environment variables.
- Authenticate using preconfigured AWS CLI profiles or environment variables **outside the demo window** to keep your secrets safe.

Following these practices protects your AWS account and infrastructure from accidental exposure or misuse.

---

## Notes

- This module creates an AWS EC2 instance running Apache with SSH access restricted to your public IP.
- The HTTP port (80) is open to the world.
- Use this module as a learning/demo tool — **not for production**.