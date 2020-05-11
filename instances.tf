# Create a Security Group

resource "aws_security_group" "allow_tls" {
  name        = "netops_mgmt"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.netops_vpc.id
  tags = {
    Name = "netops_mgmt"
  }
  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["10.0.0.0/8"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

# Creating an instance

resource "aws_instance" "example" {
  ami                = "ami-0ead70c8b3aa72249"
  instance_type      = "c5.xlarge"
  key_name           = "VaNetopsUtil"
  network_interface  {
    device_index = 0
    network_interface_id = "${aws_network_interface.mgmt.id}"
  }
  tags = {
    Name = "NetopsFW_terraform"
  }
}
resource "aws_network_interface" "mgmt" {
  subnet_id       = "${aws_subnet.public_sub1.id}"
  private_ips     = ["10.93.114.10"]
  security_groups = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "va1-gtn-mgmt"
  }
}
resource "aws_network_interface" "e1" {
  subnet_id       = "${aws_subnet.public_sub1.id}"
  private_ips     = ["10.93.114.20"]
  security_groups = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "va1-gtn-eth01"
  }
}
resource "aws_eip" "pan" {
  vpc      = true
  network_interface         = "${aws_network_interface.mgmt.id}"
  associate_with_private_ip = "10.93.114.10"
  depends_on = [aws_instance.example]
  tags = {
    Name = "va1-gtn-mgmt"
  }
}
resource "aws_eip" "pan2" {
  vpc      = true
  network_interface         = "${aws_network_interface.e1.id}"
  associate_with_private_ip = "10.93.114.20"
  tags = {
    Name = "va1-gtn-eth01"
  }
}
resource "aws_network_interface_attachment" "test2" {
  instance_id          = "${aws_instance.example.id}"
  network_interface_id = "${aws_network_interface.e1.id}"
  device_index = 1
}