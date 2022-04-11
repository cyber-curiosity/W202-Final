variable "PATH_TO_PUBLIC_KEY" {
  # Add the path to the public key you made in AWS like below
  # default = "./keys/terraform-key.pub"
  default = "./keys/Terraform.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  # Add the path to the private key you made in AWS like below
  # default = "./keys/terraform-key.pem"
  default = "./keys/Terraform.pem"
}

variable "VPC_CIDR" {
  default = "10.0.0.0/16"
}

variable "FIRST_SUBNET_CIDR" {
  default = "10.0.1.0/24"
}

variable "_1_SERVER_IP" {
  default = "10.0.1.11"
}

variable "_2_SERVER_IP" {
  default = "10.0.1.13"
}

variable "_3_SERVER_IP" {
  default = "10.0.1.15"
}

variable "WIN_SERVER_IP" {
  default = "10.0.1.17"
}

variable "PUBLIC_DNS" {
  default = "1.1.1.1"
}

variable "MANAGEMENT_IPS" {
  # Add in the public IP Address you will be hitting the cloud from, for example the public IP of your home address or VPN
  #default = ["1.2.3.4/32"]
  default = ["67.172.223.27/32"]
}

variable "SSM_S3_BUCKET" {
  # Add in the name of your S3 bucket like the example below
  #default = "this-is-just-a-fake-bucket"
  default = "redteam-lab"
}

data "aws_ami" "latest-windows-server" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
}

# Find Latest Debian
data "aws_ami" "latest-debian" {
  most_recent = true
  owners = ["136693071363"]

  filter {
    name   = "name"
    values = ["debian-10-amd64-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
