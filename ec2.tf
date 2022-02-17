resource "aws_security_group" "web_traffic" {
  vpc_id = aws_vpc.aws-vpc.id
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


# resource "aws_network_interface" "jm" {
#   subnet_id   = aws_subnet.jenkins_subnet[0].id
#   private_ips = ["10.10.50.10"]
# security_groups = [aws_security_group.web_traffic.id]
#   tags = {
#     Name = "primary_network_interface"
#   }
# }
# resource "aws_network_interface" "jn1" {
#   subnet_id   = aws_subnet.jenkins_subnet[0].id
#   private_ips = ["10.10.50.20"]
# security_groups = [aws_security_group.web_traffic.id]
#   tags = {
#     Name = "primary_network_interface"
#   }
# }

##<
resource "aws_key_pair" "deployer" {
  key_name   = "dev"
  public_key = var.dev_public_key
}

# data "template_file" "jenkins_casc" {
#   template = "${file("jenkins-casc.yaml.tpl")}"

#   vars = {
#     # datacenter = "${ var.datacenter  }"
#     github_token  = "${ var.github_token  }"
#     aws_secretKey = "${ var.aws_secretKey  }"
#     TelegramBotToken = "${ var.TelegramBotToken  }"
#     AWS_ACCOUNT = "${ var.AWS_ACCOUNT  }"
#     AWS_REGION = "${ var.aws_region  }"
#     Telegram_Token = "${var.Telegram_Token}"
#     telegram_bot_name = "${var.telegram_bot_name}"
#     telegram_channel_id = "${var.telegram_channel_id}"
#   }
# }

##>
resource "aws_instance" "jenkins_main" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type   = var.dev_server_instance_type
  vpc_security_group_ids = [aws_security_group.web_traffic.id]
  # security_groups = [aws_security_group.web_traffic.name]
  #vpc_security_group_ids = [aws_security_group.web_traffic.id]
  # security_groups = [aws_security_group.web_traffic.id]
  key_name        = var.key_name
  # network_interface {
  #   network_interface_id = aws_network_interface.jm.id
  #   device_index         = 0
  # }
  # private_ip = "10.10.50.10"
  subnet_id  = aws_subnet.jenkins_subnet[0].id
  # triggers = {
  #   template = "${data.template_file.jenkins_casc.rendered}"
  # }

##<
  depends_on = [aws_instance.dev_server_js1]
###>
  provisioner "file" {
    source      = "scripts/install_jenkins.sh"
    destination = "/tmp/install1.sh"
  }

  provisioner "file" {
    source      = "scripts/plugins.txt"
    destination = "/tmp/plugins.txt"
  }

  provisioner "file" {
    content     = data.template_file.jenkins_casc.rendered
    destination = "/tmp/jenkins-casc.yaml"
  }

  provisioner "file" {
    source      = "scripts/seedjob_multipipeline_front.groovy"
    destination = "/tmp/seedjob_multipipeline_front.groovy"
  }

  provisioner "file" {
    source      = "scripts/seedjob_multipipeline_back.groovy"
    destination = "/tmp/seedjob_multipipeline_back.groovy"
  }

  provisioner "file" {
    source      = "scripts/docker-compose.yml"
    destination = "/tmp/docker-compose.yml"
  }

  provisioner "file" {
    source      = "scripts/Dockerfile"
    destination = "/tmp/Dockerfile"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install1.sh",
      "sudo /tmp/install1.sh"
    ]
  }
  
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }
  tags = {
    "Name" = "Jenkins_Main"
  }
}

resource "aws_instance" "dev_server_js1" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.dev_server_instance_type
  vpc_security_group_ids = [aws_security_group.web_traffic.id]
  # security_groups = [aws_security_group.web_traffic.name]
  #vpc_security_group_ids = [aws_security_group.web_traffic.id]
  # security_groups = [aws_security_group.web_traffic.id]
  key_name        = var.key_name
  # network_interface {
  #   network_interface_id = aws_network_interface.jn1.id
  #   device_index         = 0
  # }
  # private_ip = "10.10.50.20"
  # subnet_id  = aws_subnet.jenkins_subnet[0].id
  subnet_id  = aws_subnet.jenkins_subnet[0].id
##<
 depends_on = [aws_security_group.web_traffic]
###>
  provisioner "file" {
    source      = "scripts/install2.sh"
    destination = "/tmp/install2.sh"
  }

  provisioner "file" {
    source      = "scripts/id_rsa_jenkinsmain.pub"
    destination = "/tmp/id_rsa_jenkinsmain.pub"
  }


  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install2.sh",
      "sudo /tmp/install2.sh"
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }
  tags = {
    "Name" = "Jenkins_Node_01"
  }
}

# resource "aws_instance" "dev_server_js2" {
#   ami             = data.aws_ami.ubuntu.id
#   instance_type   = var.dev_server_instance_type
#   vpc_security_group_ids = [aws_security_group.web_traffic.id]
#   # security_groups = [aws_security_group.web_traffic.name]
#   #vpc_security_group_ids = [aws_security_group.web_traffic.id]
#   # security_groups = [aws_security_group.web_traffic.id]
#   key_name        = var.key_name
#   # network_interface {
#   #   network_interface_id = aws_network_interface.jn1.id
#   #   device_index         = 0
#   # }
#   # private_ip = "10.10.50.20"
#   # subnet_id  = aws_subnet.jenkins_subnet[0].id
#   subnet_id  = aws_subnet.jenkins_subnet[0].id
# ##<
#  depends_on = [aws_security_group.web_traffic]
# ###>
#   provisioner "file" {
#     source      = "scripts/install2.sh"
#     destination = "/tmp/install2.sh"
#   }

#   provisioner "file" {
#     source      = "scripts/id_rsa_jenkinsmain.pub"
#     destination = "/tmp/id_rsa_jenkinsmain.pub"
#   }


#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/install2.sh",
#       "sudo /tmp/install2.sh"
#     ]
#   }
#   connection {
#     type        = "ssh"
#     host        = self.public_ip
#     user        = "ubuntu"
#     agent       = false
#     private_key = file(var.private_key_path)
#   }
#   tags = {
#     "Name" = "Jenkins_Node_02"
#   }
# }