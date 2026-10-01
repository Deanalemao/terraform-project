# 🚀 AWS Infrastructure with Terraform

> A hands-on Infrastructure as Code project for provisioning and managing AWS infrastructure using Terraform.

## 📌 Overview

This project demonstrates how to provision and connect multiple AWS services using **Terraform** instead of creating resources manually through the AWS Management Console.

The project focuses on understanding how AWS networking, compute, storage, and load balancing components work together and how Terraform can be used to manage infrastructure through code.

## 🏗️ Architecture


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

---

## ☁️ AWS Resources

The infrastructure includes the following AWS resources:
- VPC – Custom VPC with a dedicated CIDR block
- Subnets – Two public subnets across Availability Zones
- Internet Gateway – Provides internet connectivity for the public subnets
- Route Table – Configures routing through the Internet Gateway
- Security Group – Configured for HTTP and SSH access with outbound traffic rules
- EC2 – Two EC2 instances provisioned using Terraform
- Application Load Balancer – Distributes incoming traffic between the EC2 instances
- Target Group – Registers both EC2 instances as targets
- ALB Listener – Handles HTTP traffic and forwards requests to the target group
- S3 – S3 bucket created using Terraform
- Terraform Remote State – Terraform state configured to be stored remotely using Amazon S3

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


# 🚀 Getting Started

## 1 Prerequisites

Before running this project, make sure you have:

- An AWS account
- AWS CLI installed
- Terraform installed
- Proper AWS IAM permissions

Verify the installations:

terraform --version
aws --version

---

## 2 Configure AWS Credentials

Configure your AWS credentials using the AWS CLI:

command: aws configure


Provide:

AWS Access Key ID
AWS Secret Access Key
Default region
Output format

You can verify your AWS identity with:

aws sts get-caller-identity


> ⚠️ Never commit AWS access keys, secret keys, private keys, or other credentials to GitHub.

---

# ⚙️ Terraform Workflow

## 3 Initialize Terraform

Initialize the Terraform working directory:

terraform init

This will:

- Initialize the Terraform project
- Download required providers
- Configure the backend
- Prepare Terraform for execution

---

## 4 Format the Configuration

Format the Terraform files:

terraform fmt

This keeps the Terraform configuration consistently formatted.

---

## 5 Validate the Configuration

Run:

terraform validate

This checks whether the Terraform configuration is syntactically valid and internally consistent.

---

## 6 Review the Execution Plan

Before creating any resources, review what Terraform intends to create:

terraform plan

Terraform will display the resources that will be:

+ created
~ modified
- destroyed

Always review the plan before applying changes.

---

## 7 Create the Infrastructure

Apply the configuration:

terraform apply

Terraform will ask for confirmation.

Enter:
yes

Terraform will then provision the AWS infrastructure.

---

# 🌐 Accessing the Application

After the infrastructure is created, Terraform outputs the Application Load Balancer DNS name.

Run:

terraform output

Or specifically:

terraform output loadbalancerdns


You can then open the ALB DNS name in a browser:

http://<ALB-DNS-NAME>


Traffic will be handled by the Application Load Balancer and forwarded to the EC2 instances through the configured Target Group.

---

# 🔄 Infrastructure Flow

The traffic flow is:

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

terraform destroy

Review the resources Terraform plans to remove and confirm with:

yes

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

Learning and building with:

`AWS` • `Terraform` • `DevOps` • `Cloud Computing`

---
