resource "aws_vpc" "tf-ecomm" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ecomm-vpc"
  }
}
# create pub sub AZ - A

resource "aws_subnet" "tf-ecomm-pub-sn-A" {
  vpc_id     = aws_vpc.tf-ecomm.id
  cidr_block = "192.168.0.0/24"
   availability_zone ="us-east-2a"
   map_public_ip_on_launch = "true" 
   tags = {
    Name = "ecomm-public-subnet-A"
  }
}

# create pub sub AZ - B
resource "aws_subnet" "tf-ecomm-pub-sn-B" {
  vpc_id     = aws_vpc.tf-ecomm.id
  cidr_block = "192.168.1.0/24"
   availability_zone ="us-east-2b"
   map_public_ip_on_launch = "true"
   tags = {
    Name = "ecomm-public-subnet-B"
  }
}

