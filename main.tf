provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "jenkins-ec2" {
  ami           = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  user_data = file("add_jenkins.sh")

  tags = {
    Name    = "ubuntu-jenkins"
  }
}


resource "aws_security_group" "jenkins_sg" {
  name        = "allow_http_ssh"
  description = "Allow http and ssh access"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tcp"
  }
}