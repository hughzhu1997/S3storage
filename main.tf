provider "aws" {
  region = "ap-southeast-2"
 
}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name: "development"
  }
 }

 data "aws_vpc" "selected" {
    filter {
        name = "tag:Name"
        values = ["development"]
    }

 }


variable "subnet_cidr_block" {
    description = "subnet cidr block"
  
}

variable "vpc_cidr_block" {
    description = "vpc cidr block"
  
}



output "vpc_id" {
    value = data.aws_vpc.selected.id
  
}


resource "aws_subnet" "development-public-01" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.subnet_cidr_block[0]
    availability_zone = "ap-southeast-2a"
    tags = {
    Name: "development-public-01"
  }
}


resource "aws_subnet" "development-public-02" {
    vpc_id = data.aws_vpc.selected.id
    cidr_block = var.subnet_cidr_block[1]
    availability_zone = "ap-southeast-2b"
    tags = {
    Name: "development-public-02"
  }
}

resource "aws_subnet" "development-private-01" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.subnet_cidr_block[2]
    availability_zone = "ap-southeast-2a"
    tags = {
    Name:  "development-private-01"
  }
}


resource "aws_subnet" "development-private-02" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.subnet_cidr_block[3]
    availability_zone = "ap-southeast-2b"
    tags = {
    Name: "development-private-02"
  }
}

