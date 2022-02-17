data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "jenkins_casc" {
  template = file("scripts/jenkins-casc.yaml.tpl")

  vars = {
    # datacenter = "${ var.datacenter  }"
    github_token        = "${var.github_token}"
    aws_secretKey       = "${var.aws_secretKey}"
    TelegramBotToken    = "${var.TelegramBotToken}"
    AWS_ACCOUNT         = "${var.AWS_ACCOUNT}"
    AWS_REGION          = "${var.aws_region}"
    Telegram_Token      = "${var.Telegram_Token}"
    telegram_bot_name   = "${var.telegram_bot_name}"
    telegram_channel_id = "${var.telegram_channel_id}"
    jenkins_node01_ip   = aws_instance.dev_server_js1.private_ip
    sonartoken          = "${var.sonartoken}"
  }
}

# jenkins_node02_ip   = aws_instance.dev_server_js2.private_ip