# Create a common Transit Gateway

resource "aws_ec2_transit_gateway" "test_tgw" {
  description = "terraform object"
  amazon_side_asn = 65533
  auto_accept_shared_attachments = "enable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags = {"Name":"NetOpsTGW-Dev"}
}

# Create 3 attachments to the common TGW for all 3 customer VPC's

resource "aws_ec2_transit_gateway_vpc_attachment" "custa_sub-attach" {

  depends_on = [aws_ec2_transit_gateway.test_tgw]
  subnet_ids         = ["${aws_subnet.private_sub1.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.test_tgw.id}"
  vpc_id             = "${aws_vpc.netops_vpc.id}"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name = "netops_subnets"
  }
}

# Create a common TGW Routing Table for the Customers

resource "aws_ec2_transit_gateway_route_table" "cust_rt" {
  transit_gateway_id = "${aws_ec2_transit_gateway.test_tgw.id}"

  tags = {
    Name = "cust_rt"
  }
}
resource "aws_ec2_transit_gateway_route_table" "inter_region" {
  transit_gateway_id = "${aws_ec2_transit_gateway.test_tgw.id}"

  tags = {
    Name = "INTER_REGION"
  }
}

# Associate all 3 TGW attachments to the common Custoemr TGW Table

resource "aws_ec2_transit_gateway_route_table_association" "example1" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.custa_sub-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.cust_rt.id}"
}

/*
resource "aws_customer_gateway" "netops_cgw" {
  bgp_asn    = 53428
  ip_address = "52.47.158.26"
  type       = "ipsec.1"
}

resource "aws_vpn_connection" "example" {
  customer_gateway_id = "${aws_customer_gateway.netops_cgw.id}"
  transit_gateway_id  = "${aws_ec2_transit_gateway.test_tgw.id}"
  type                = "${aws_customer_gateway.netops_cgw.type}"
}
*/