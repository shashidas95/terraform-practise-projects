# Terraform Documentation for VPC Creation

## **Overview**

This documentation outlines how to set up a VPC in AWS using Terraform. It includes creating a VPC, public and private subnets, an internet gateway, a route table, associating the route table with the public subnet, and creating an EC2 instance in the VPC

---

### **Code for VPC Setup**

#### **1. Create a VPC**

```hcl
resource "aws_vpc" "tf_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "sas_pvc"
  }
}
```

This code creates a VPC with a CIDR block of `10.0.0.0/16` and assigns it a name tag `sas_pvc`.

---

#### **2. Create a Public Subnet**

```hcl
resource "aws_subnet" "tf_public_subnet" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "sas_public_subnet"
  }
}
```

This code creates a public subnet within the VPC.

---

#### **3. Create a Private Subnet**

```hcl
resource "aws_subnet" "tf_private_subnet" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "sas_private_subnet"
  }
}
```

This code creates a private subnet within the VPC.

---

#### **4. Create an Internet Gateway**

```hcl
resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "sas_igw"
  }
}
```

This code creates an internet gateway for the VPC.

---

#### **5. Create a Route Table**

```hcl
resource "aws_route_table" "tf_route_table" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }

  tags = {
    Name = "sas_route_table"
  }
}
```

This code creates a route table with a default route to the internet gateway.

---

#### **6. Associate Route Table with Public Subnet**

```hcl
resource "aws_route_table_association" "tf_rta_pub_sub" {
  route_table_id = aws_route_table.tf_route_table.id
  subnet_id      = aws_subnet.tf_public_subnet.id
}
```

This code associates the route table with the public subnet.

---

#### **7. Create an EC2 Instance in the Public Subnet**

```hcl
resource "aws_instance" "tf_ec2_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.tf_public_subnet.id
  tags = {
    Name = var.app_name
  }
}
```

This code creates an EC2 instance in the public subnet.

---

#### **8. Output VPC ID**

```hcl
output "vpc_id" {
  value = aws_vpc.tf_vpc.id
}
```

This code outputs the VPC ID after creation.

---

### **Using AWS Profiles in Terraform**

To determine and use AWS profiles, follow these steps:

#### **1. Locate the AWS Credentials File**

- Path: `~/.aws/credentials` on Linux/macOS or `%USERPROFILE%\.aws\credentials` on Windows.

#### **2. Open the Credentials File**

- **Command:**
  ```bash
  cat ~/.aws/credentials
  ```
- **Example Output:**

  ```ini
  [default]
  aws_access_key_id = YOUR_DEFAULT_ACCESS_KEY
  aws_secret_access_key = YOUR_DEFAULT_SECRET_KEY

  [dev]
  aws_access_key_id = YOUR_DEV_ACCESS_KEY
  aws_secret_access_key = YOUR_DEV_SECRET_KEY

  [test]
  aws_access_key_id = YOUR_TEST_ACCESS_KEY
  aws_secret_access_key = YOUR_TEST_SECRET_KEY
  ```

#### **3. List Profiles Using AWS CLI**

```bash
aws configure list-profiles
```

- **Example Output:**
  ```bash
  default
  dev
  test
  ```

#### **4. Use the Profile Name in Terraform**

Update the `provider "aws"` block:

```hcl
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "dev"  # Replace with your profile
}
```

---

### **Changing or Adding Profiles**

#### **1. Open the Credentials File**

Use a text editor:

```bash
nano ~/.aws/credentials
```

#### **2. Modify or Add Profiles**

- Modify an existing profile:
  ```ini
  [dev]
  aws_access_key_id = UPDATED_ACCESS_KEY
  aws_secret_access_key = UPDATED_SECRET_KEY
  ```
- Add a new profile:
  ```ini
  [new-profile]
  aws_access_key_id = YOUR_NEW_ACCESS_KEY
  aws_secret_access_key = YOUR_NEW_SECRET_KEY
  ```

#### **3. Save and Exit**

- In `nano`, press `Ctrl + O`, then `Enter` to save, and `Ctrl + X` to exit.

#### **4. Update Terraform Configuration**

Update the `provider "aws"` block:

```hcl
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "new-profile"
}
```

#### **5. Verify the Profile**

Test with the AWS CLI:

```bash
aws sts get-caller-identity --profile new-profile
```

---

This completes the documentation for setting up a VPC, managing AWS profiles, and creating an EC2 instance in Terraform with Nginx and HTTPS access.
