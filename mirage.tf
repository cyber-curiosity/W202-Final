# Basic AWS configuration which will grab our keys from the AWS CLI
# If you are not using the keys in the default profile of aws cli, then change below to the profile name 
provider "aws" {
  profile = "default"
  region     = "us-east-1"
}

# Our AWS keypair
resource "aws_key_pair" "terraformkey" {
  key_name   = "${terraform.workspace}-terraform-lab"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

# Our VPC definition, using a default IP range of 10.0.0.0/16
resource "aws_vpc" "lab-vpc" {
  cidr_block           = var.VPC_CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Default route required for the VPC to push traffic via gateway
resource "aws_route" "first-internet-route" {
  route_table_id         = aws_vpc.lab-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lab-vpc-gateway.id
}

# Gateway which allows outbound and inbound internet access to the VPC
resource "aws_internet_gateway" "lab-vpc-gateway" {
  vpc_id = aws_vpc.lab-vpc.id
}

# Create our first subnet (Defaults to 10.0.1.0/24)
resource "aws_subnet" "first-vpc-subnet" {
  vpc_id = aws_vpc.lab-vpc.id

  cidr_block        = var.FIRST_SUBNET_CIDR
  availability_zone = "us-east-1a"

  tags = {
    Name = "First Subnet"
  }
}

# Set DHCP options for delivering things like DNS servers
resource "aws_vpc_dhcp_options" "first-dhcp" {
  domain_name          = "first.local"
  domain_name_servers  = [ var.PUBLIC_DNS]
  netbios_node_type    = 2

  tags = {
    Name = "First DHCP"
  }
}

# Associate our DHCP configuration with our VPC
resource "aws_vpc_dhcp_options_association" "first-dhcp-assoc" {
  vpc_id          = aws_vpc.lab-vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.first-dhcp.id
}

# First Debian Server
resource "aws_instance" "_1_server" {
  ami                         = data.aws_ami.latest-debian.image_id
  instance_type               = "t2.small"
  key_name                    = aws_key_pair.terraformkey.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.first-vpc-subnet.id
  private_ip                  = var._1_SERVER_IP
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name

  tags = {
    Workspace = "${terraform.workspace}"
    Name      = "${terraform.workspace}-1-Server"
  }

  vpc_security_group_ids = [
    aws_security_group.first-sg.id,
  ]
}

resource "null_resource" "_1_server-setup" {
  connection {
    type        = "ssh"
    host        = aws_instance._1_server.public_ip
    user        = "admin"
    port        = "22"
    private_key = file(var.PATH_TO_PRIVATE_KEY)
    agent       = false
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      
      # Install hyprspace
      "sudo mkdir -p /usr/local/bin/",
      "sudo curl -L https://github.com/hyprspace/hyprspace/releases/download/v0.2.2/hyprspace-v0.2.2-linux-amd64 -o /usr/local/bin/hyprspace",
      "sudo chmod a+x /usr/local/bin/hyprspace",
      "sudo ln -s /usr/local/bin/hyprspace /usr/bin/hyprspace",
      "sudo hyprspace init hs1",
      
    ]
  }
}

# Second Debian Server
resource "aws_instance" "_2_server" {
  ami                         = data.aws_ami.latest-debian.image_id
  instance_type               = "t2.small"
  key_name                    = aws_key_pair.terraformkey.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.first-vpc-subnet.id
  private_ip                  = var._2_SERVER_IP
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name

  tags = {
    Workspace = "${terraform.workspace}"
    Name      = "${terraform.workspace}-2-Server"
  }

  vpc_security_group_ids = [
    aws_security_group.first-sg.id,
  ]
}

resource "null_resource" "_2_server-setup" {
  connection {
    type        = "ssh"
    host        = aws_instance._2_server.public_ip
    user        = "admin"
    port        = "22"
    private_key = file(var.PATH_TO_PRIVATE_KEY)
    agent       = false
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      
      # Install hyprspace
      "sudo mkdir -p /usr/local/bin/",
      "sudo curl -L https://github.com/hyprspace/hyprspace/releases/download/v0.2.2/hyprspace-v0.2.2-linux-amd64 -o /usr/local/bin/hyprspace",
      "sudo chmod a+x /usr/local/bin/hyprspace",
      "sudo ln -s /usr/local/bin/hyprspace /usr/bin/hyprspace",
      "sudo hyprspace init hs1",
      
    ]
  }
}

# Third Debian Server
resource "aws_instance" "_3_server" {
  ami                         = data.aws_ami.latest-debian.image_id
  instance_type               = "t2.small"
  key_name                    = aws_key_pair.terraformkey.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.first-vpc-subnet.id
  private_ip                  = var._3_SERVER_IP
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name

  tags = {
    Workspace = "${terraform.workspace}"
    Name      = "${terraform.workspace}-3-Server"
  }

  vpc_security_group_ids = [
    aws_security_group.first-sg.id,
  ]
}

resource "null_resource" "_3_server-setup" {
  connection {
    type        = "ssh"
    host        = aws_instance._3_server.public_ip
    user        = "admin"
    port        = "22"
    private_key = file(var.PATH_TO_PRIVATE_KEY)
    agent       = false
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      
      # Install hyprspace
      "sudo mkdir -p /usr/local/bin/",
      "sudo curl -L https://github.com/hyprspace/hyprspace/releases/download/v0.2.2/hyprspace-v0.2.2-linux-amd64 -o /usr/local/bin/hyprspace",
      "sudo chmod a+x /usr/local/bin/hyprspace",
      "sudo ln -s /usr/local/bin/hyprspace /usr/bin/hyprspace",
      "sudo hyprspace init hs1",
      
    ]
  }
}

# Windows Server for traffic viewing
resource "aws_instance" "win-server" {
  ami                         = data.aws_ami.latest-windows-server.image_id
  instance_type               = "t2.small"
  key_name                    = aws_key_pair.terraformkey.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.first-vpc-subnet.id
  private_ip                  = var.WIN_SERVER_IP
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name

  tags = {
    Workspace = "${terraform.workspace}"
    Name      = "${terraform.workspace}-win-Server"
  }

  vpc_security_group_ids = [
    aws_security_group.first-sg.id,
  ]
}

# IAM Role required to access SSM from EC2
resource "aws_iam_role" "ssm_role" {
  name               = "${terraform.workspace}_ssm_role_default"
  count              = 1
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ssm_role_policy" {
  role       = aws_iam_role.ssm_role.0.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name  = "${terraform.workspace}_ssm_instance_profile"
  role  = aws_iam_role.ssm_role.0.name
}

# Security group for first.local
resource "aws_security_group" "first-sg" {
  vpc_id = aws_vpc.lab-vpc.id

  ingress {
    protocol    = "-1"
    cidr_blocks = [var.FIRST_SUBNET_CIDR]
    from_port   = 0
    to_port     = 0
  }

  # Allow management from our IP
  ingress {
    protocol    = "-1"
    cidr_blocks = var.MANAGEMENT_IPS
    from_port   = 0
    to_port     = 0
  }

  # Allow global outbound
  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }
}

# Add windows server MOF's to S3
resource "aws_s3_bucket_object" "win-server-mof" {
  bucket     = var.SSM_S3_BUCKET
  key        = "WinServer.mof"
  source     = "WinServer.mof"
  etag       = filemd5("WinServer.mof")
}

# SSM parameters used by DSC
resource "aws_ssm_parameter" "admin-ssm-parameter" {
  name  = "admin"
  type  = "SecureString"
  value = "{\"Username\":\"admin\", \"Password\":\"Password@1\"}"
}

output "_1_server_ip" {
  value       = "${aws_instance._1_server.public_ip}"
  description = "Public IP of First Linux Server. SSH to this using your private key and start Covenant / Cobalt and then SSH port forward to interact."
}

output "_2_server_ip" {
  value       = "${aws_instance._2_server.public_ip}"
  description = "Public IP of Second Linux Server. SSH to this using your private key and start Covenant / Cobalt and then SSH port forward to interact."
}

output "_3_server_ip" {
  value       = "${aws_instance._3_server.public_ip}"
  description = "Public IP of Third Linux Server. SSH to this using your private key and start Covenant / Cobalt and then SSH port forward to interact."
}

output "win-server_ip" {
  value       = "${aws_instance.win-server.public_ip}"
  description = "Public IP of User Server"
}

# Apply our DSC via SSM to win-server
resource "aws_ssm_association" "win-server" {
  name             = "AWS-ApplyDSCMofs"
  association_name = "${terraform.workspace}-win-Server"

  targets {
    key    = "InstanceIds"
    values = [aws_instance.win-server.id]
  }

  parameters = {
    MofsToApply    = "s3:${var.SSM_S3_BUCKET}:WinServer.mof"
    RebootBehavior = "Immediately"
  }

}



