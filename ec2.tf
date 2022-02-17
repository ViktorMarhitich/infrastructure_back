variable "ingressrules" {
  type    = list(number)
  default = [9000, 8080, 22, 443, 80, 8000, 8081]
}

resource "aws_security_group" "web_traffic" {
  name        = "Allow web traffic"
  description = "inbound ports for ssh and standard http and everything outbound"
  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["${var.ingress_cidr_blocks}"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Terraform" = "true"
  }
}

resource "aws_instance" "dev_server" {
    ami = "ami-05d34d340fb1d89e5"
    instance_type = "t2.medium"
    security_groups = [aws_security_group.web_traffic.name]
    key_name = var.key_name

  provisioner "file" {
    source      = "${var.file_path}"
    destination = "/tmp/install.sh"
  }
  
  provisioner "remote-exec"  {
    inline  = [
        "chmod +x /tmp/install.sh",
        "sudo /tmp/install.sh"
      ]
   }
 connection {
    type         = "ssh"
    host         = self.public_ip
    user         = "ec2-user"
    private_key  = file(var.private_key_path)
   }
  tags  = {
    "Name"      = "Dev"
  }
}