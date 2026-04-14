# 🏗️ Terraform Practice & Infrastructure Projects

This repository is a dedicated space for my **Infrastructure as Code (IaC)** journey. It contains a series of projects focused on automating cloud resource provisioning on **AWS** using **Terraform**.

---

## 🎯 Learning Objectives

- **Modular Design**: Building reusable Terraform modules to keep code DRY (Don't Repeat Yourself).
- **State Management**: Understanding remote state storage and locking using S3 and DynamoDB.
- **Provider Orchestration**: Managing complex dependencies between AWS services like VPCs, Subnets, and Security Groups.
- **Scalability**: Implementing Auto Scaling Groups (ASG) and Load Balancers (ALB) via code.

---

## 📂 Project Structure

Each subdirectory represents a specific architectural pattern or lab:

- `01-basic-ec2/`: Provisioning a single EC2 instance with custom security groups.
- `02-vpc-networking/`: Automating a custom VPC with public/private subnets and an Internet Gateway.
- `03-rds-database/`: Deploying managed relational databases within a private subnet.
- `04-modular-infra/`: A complete project utilizing custom modules for high reusability.

---

## 🛠️ Tech Stack

- **Tool**: [Terraform](https://www.terraform.io/) (HCL - HashiCorp Configuration Language)
- **Cloud Provider**: [Amazon Web Services (AWS)](https://aws.amazon.com/)
- **Target Services**: EC2, VPC, S3, RDS, IAM, Route53

---

## 🚀 How to Use These Projects

### **Prerequisites**
1.  **Terraform CLI** installed locally.
2.  **AWS CLI** configured with appropriate IAM credentials.
3.  A code editor (VS Code recommended with Terraform extension).

### **Execution Steps**
Navigate to any project directory and run:

```bash
# Initialize the working directory (downloads providers)
terraform init

# Preview the changes Terraform will make
terraform plan

# Execute the plan and build the infrastructure
terraform apply
