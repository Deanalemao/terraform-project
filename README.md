# 🚀 AWS Infrastructure with Terraform

> A hands-on Infrastructure as Code project for provisioning and managing AWS infrastructure using Terraform.

---

## 📌 Overview

This project demonstrates how to provision and connect multiple AWS services using **Terraform** instead of creating resources manually through the AWS Management Console.

The project focuses on understanding how AWS networking, compute, storage, and load balancing components work together and how Terraform can be used to manage infrastructure through code.

---

## 🏗️ Architecture

```text
                              🌐 Internet
                                  │
                                  ▼
                     ┌────────────────────────┐
                     │ Application Load       │
                     │ Balancer (ALB)         │
                     └────────────┬───────────┘
                                  │
                       ┌──────────┴──────────┐
                       │                     │
                       ▼                     ▼
                ┌──────────────┐      ┌──────────────┐
                │ EC2 Instance │      │ EC2 Instance │
                │      #1      │      │      #2      │
                └──────────────┘      └──────────────┘
                       │                     │
                       └──────────┬──────────┘
                                  │
                     ┌────────────▼────────────┐
                     │          VPC            │
                     │       10.0.0.0/16       │
                     │                         │
                     │  ┌───────────────────┐  │
                     │  │ Public Subnet #1  │  │
                     │  └───────────────────┘  │
                     │                         │
                     │  ┌───────────────────┐  │
                     │  │ Public Subnet #2  │  │
                     │  └───────────────────┘  │
                     └─────────────────────────┘

                         ┌─────────────┐
                         │ S3 Bucket   │
                         └─────────────┘
```

---

## ☁️ AWS Resources

The infrastructure includes the following AWS resources:

| Resource | Description |
|----------|-------------|
| **VPC** | Custom VPC with a dedicated CIDR block |
| **Subnets** | Two public subnets across Availability Zones |
| **Internet Gateway** | Provides internet connectivity to the public subnets |
| **Route Table** | Routes internet traffic through the Internet Gateway |
| **Security Group** | Controls inbound and outbound traffic |
| **EC2** | Two EC2 instances provisioned using Terraform |
| **Application Load Balancer** | Distributes incoming HTTP traffic between EC2 instances |
| **Target Group** | Registers the EC2 instances as targets |
| **ALB Listener** | Listens for HTTP traffic and forwards requests to the target group |
| **S3** | S3 bucket provisioned using Terraform |
| **S3 Backend** | Used for storing Terraform remote state |

---

## 🛠️ Technologies Used

- ☁️ **Amazon Web Services (AWS)**
- 🏗️ **Terraform**
- 🌐 **Amazon VPC**
- 💻 **Amazon EC2**
- ⚖️ **Application Load Balancer**
- 🪣 **Amazon S3**
- 🔐 **AWS Security Groups**
- 📦 **Terraform Remote State**
- 📝 **Infrastructure as Code (IaC)**

---

## 📂 Project Structure

```text
terraform-project/
│
├── main.tf
├── provider.tf
├── variables.tf
├── output.tf
├── terraform.tfvars
├── userdata.sh
├── userdata1.sh
├── .gitignore
└── README.md
```

### File Description

| File | Purpose |
|------|---------|
| `main.tf` | Defines the AWS infrastructure resources |
| `provider.tf` | Configures the AWS provider |
| `variables.tf` | Declares Terraform input variables |
| `terraform.tfvars` | Provides values for Terraform variables |
| `output.tf` | Defines Terraform outputs such as the ALB DNS |
| `userdata.sh` | Startup configuration for EC2 instance 1 |
| `userdata1.sh` | Startup configuration for EC2 instance 2 |
| `.gitignore` | Prevents unnecessary and sensitive files from being committed |
| `README.md` | Project documentation |

---

# 🚀 Getting Started

## 1 Prerequisites

Before running this project, make sure you have:

- An AWS account
- AWS CLI installed
- Terraform installed
- Git installed
- Proper AWS IAM permissions

Verify the installations:

```bash
terraform --version
aws --version
git --version
```

---

## 2 Configure AWS Credentials

Configure your AWS credentials using the AWS CLI:

```bash
aws configure
```

Provide:

```text
AWS Access Key ID
AWS Secret Access Key
Default region
Output format
```

You can verify your AWS identity with:

```bash
aws sts get-caller-identity
```

> ⚠️ Never commit AWS access keys, secret keys, private keys, or other credentials to GitHub.

---

# ⚙️ Terraform Workflow

## 3 Initialize Terraform

Initialize the Terraform working directory:

```bash
terraform init
```

This will:

- Initialize the Terraform project
- Download required providers
- Configure the backend
- Prepare Terraform for execution

---

## 4 Format the Configuration

Format the Terraform files:

```bash
terraform fmt
```

This keeps the Terraform configuration consistently formatted.

---

## 5 Validate the Configuration

Run:

```bash
terraform validate
```

This checks whether the Terraform configuration is syntactically valid and internally consistent.

---

## 6 Review the Execution Plan

Before creating any resources, review what Terraform intends to create:

```bash
terraform plan
```

Terraform will display the resources that will be:

```text
+ created
~ modified
- destroyed
```

Always review the plan before applying changes.

---

## 7 Create the Infrastructure

Apply the configuration:

```bash
terraform apply
```

Terraform will ask for confirmation.

Enter:

```text
yes
```

Terraform will then provision the AWS infrastructure.

---

# 🌐 Accessing the Application

After the infrastructure is created, Terraform outputs the Application Load Balancer DNS name.

Run:

```bash
terraform output
```

Or specifically:

```bash
terraform output loadbalancerdns
```

You can then open the ALB DNS name in a browser:

```text
http://<ALB-DNS-NAME>
```

Traffic will be handled by the Application Load Balancer and forwarded to the EC2 instances through the configured Target Group.

---

# 🔄 Infrastructure Flow

The traffic flow is:

```text
User
 │
 ▼
Internet
 │
 ▼
Application Load Balancer
 │
 ▼
Target Group
 │
 ├──────────────► EC2 Instance 1
 │
 └──────────────► EC2 Instance 2
```

The EC2 instances are deployed inside the VPC's public subnets and configured using Terraform.

---

# 🔐 Security Considerations

This project is primarily intended for learning and experimentation.

For a production environment, consider:

- Restricting SSH access to trusted IP addresses
- Avoiding `0.0.0.0/0` for SSH access
- Using IAM roles instead of hardcoded credentials
- Storing sensitive values securely
- Using HTTPS with the Application Load Balancer
- Separating public and private subnets
- Using NAT Gateway where required
- Using separate Security Groups for the ALB and EC2 instances
- Protecting the Terraform state
- Following the principle of least privilege for IAM permissions

---

# 📚 What I Learned

Through this project, I practiced and gained a better understanding of:

### AWS

- VPC networking
- CIDR blocks
- Public subnets
- Availability Zones
- Internet Gateways
- Route Tables
- Security Groups
- EC2
- Application Load Balancers
- Target Groups
- ALB Listeners
- S3

### Terraform

- Terraform providers
- Terraform resources
- Terraform variables
- `terraform.tfvars`
- Terraform state
- Remote state
- S3 backend
- Resource dependencies
- EC2 User Data
- Terraform outputs
- `terraform init`
- `terraform fmt`
- `terraform validate`
- `terraform plan`
- `terraform apply`
- `terraform destroy`

---

# 🧹 Destroying the Infrastructure

When the infrastructure is no longer required, it can be removed using:

```bash
terraform destroy
```

Review the resources Terraform plans to remove and confirm with:

```text
yes
```

> ⚠️ Be careful when using `terraform destroy`, as it removes resources managed by the Terraform configuration.

---

# 🚧 Future Improvements

This project is part of my ongoing DevOps and Cloud learning journey.

Some areas I plan to explore next:

- [ ] Terraform Modules
- [ ] Private Subnets
- [ ] NAT Gateway
- [ ] Improved Security Group Architecture
- [ ] Auto Scaling Groups
- [ ] CI/CD with GitHub Actions
- [ ] Docker
- [ ] Kubernetes
- [ ] Amazon EKS
- [ ] Monitoring with Prometheus and Grafana

---

# 👨‍💻 Author

**Dean Alemao**

**Github link**: https://github.com/Deanalemao/terraform-project.git

Learning and building with:

`AWS` • `Terraform` • `DevOps` • `Cloud Computing`

---
