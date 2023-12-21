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


# create pvt sub AZ - A
resource "aws_subnet" "tf-ecomm-pvt-sn-A" {
  vpc_id     = aws_vpc.tf-ecomm.id
  cidr_block = "192.168.2.0/24"
   availability_zone ="us-east-2a"
   map_public_ip_on_launch = "false"
   tags = {
    Name = "ecomm-private-subnet-A"
  }
}
# create pvt sub AZ - B
resource "aws_subnet" "tf-ecomm-pvt-sn-B" {
  vpc_id     = aws_vpc.tf-ecomm.id
  cidr_block = "192.168.3.0/24"
   availability_zone ="us-east-2b"
   map_public_ip_on_launch = "false"
   tags = {
    Name = "ecomm-private-subnet-B"
  }
}


#create internet gateway 

resource "aws_internet_gateway" "tf-ecomm-igw" {
  vpc_id = aws_vpc.tf-ecomm.id

  tags = {
    Name = "ecomm-internet-internet"
  }
}




#create public route

resource "aws_route_table" "tf-ecomm-pub-rt" {
  vpc_id = aws_vpc.tf-ecomm.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-ecomm-igw.id
  }

 
  tags = {
    Name = "ecomm-public-route-table"
  }
}




#create private  route table

resource "aws_route_table" "tf-ecomm-pvt-rt" {
  vpc_id = aws_vpc.tf-ecomm.id

  
  tags = {
    Name = "ecomm-private-route-table"
  }
}



# create public assocations 


resource "aws_route_table_association" "tf-ecomm-pub-asc-A" {
  subnet_id      = aws_subnet.tf-ecomm-pub-sn-A.id
  route_table_id = aws_route_table.tf-ecomm-pub-rt.id
}


resource "aws_route_table_association" "tf-ecomm-pub-asc-B" {
  subnet_id      = aws_subnet.tf-ecomm-pub-sn-B.id
  route_table_id = aws_route_table.tf-ecomm-pub-rt.id
}




# create private assocations


resource "aws_route_table_association" "tf-ecomm-pvt-asc-A" {
  subnet_id      = aws_subnet.tf-ecomm-pvt-sn-A.id
  route_table_id = aws_route_table.tf-ecomm-pvt-rt.id
}


resource "aws_route_table_association" "tf-ecomm-pvt-asc-B" {
  subnet_id      = aws_subnet.tf-ecomm-pvt-sn-B.id
  route_table_id = aws_route_table.tf-ecomm-pvt-rt.id
}

