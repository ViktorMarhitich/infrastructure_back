#-----------
#------------
#main
aws_region = "eu-central-1"
#-
aws_access_key = "AKIA5S67HQJDSDQQLKHZ"
aws_secret_key = "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"
#vpc
app_name        = "what-backend"
app_environment = "release"
#s3
bucket_name   = "what-front-anm"
force_destroy = true
#-
DB_USERNAME = "DB_USERNAME"
DB_PASSWORD = "DB_PASSWORD"
#net
private_subnets    = ["10.10.0.0/24", "10.10.1.0/24"]
availability_zones = ["eu-central-1a", "eu-central-1b"]
public_subnets     = ["10.10.100.0/24", "10.10.101.0/24"]
jenkins_subnets     = ["10.10.50.0/24","10.10.51.0/24"]
#ec2
key_name            = "dev"
#ingress_cidr_blocks = "188.163.104.104/32"
ingress_cidr_blocks = "0.0.0.0/0"
egress_cidr_blocks = "0.0.0.0/0"
file_path           = "./install.sh"
private_key_path    = "./keys/dev.pem"
#--
dev_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDMQ048dc5fEFQx6XUgKthWiqHch97JSrE/hpJHe1EbPiCNqRhfWBjiaxhQQRf1YIJj+8yM8tog6M6spEQEc6lwqY6NaKWa15LMrxtDl3jyb8mrEeKD9EZLqLxzxcIfVpy3TfZ2ZLxA8HbwRH4PtjcEN1nta11wsf4bOChPquGmvELgDe+yw0JHAxhc4rfZjuuQ09j9QuHMgZZ1G3hszButkcRlxnVoq5iPnSN0wxCtN/sMNOJCxusmuku0nlrIZ+HQNQPHea1+WWnaYrIoWLUJGcAFCy6bYP5NYnWpLe9HHXYuduUdDZ9kzH1POgLS5jFpT8fnCsFeG8UMa5bhYT/Y7mvCPT4bju6dUOkNNypY5KQhyBe20MU20tIP1uR2cftiJ8okSD5HL8RqYFceQI56NTQtqQf9d6JrUfd7gtFJTo56hVC5MjUJlq3CjSy+S6mm+qiz020yjoTbT/KQZEg5QM6lCrQT2J3AjdhHg+fSYt/+I+4lv/XFPi+Lige4P0cB5fZiZ+vw/+/SOgb1cdQ6Q9wMumt2cmitwSpIlaen2jLJpJKYt17/+gc6+Ox3c/BWuiLDV1wz3+rGB+M0KVhD3/ir+W9FlMJolaoQTWxIwTU5nw2m4i4YY1HZJ5V7HXucZ9MulkI1rkzOJLde1YmcVr30gwPFdu8d+4nKHMkUfw== anm"

github_token = "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"
aws_secretKey = "4xx2jsyuilZt+JetJdBuKqSn/jwjwjcBjsMsddNY"
TelegramBotToken = "5057295016:AAFWX5eitw9tKyiPtLB1FWYI3iVvP5Fmt4g"

AWS_ACCOUNT = "934086672967"
Telegram_Token = "5057295016:AAFWX5eitw9tKyiPtLB1FWYI3iVvP5Fmt4g"
telegram_bot_name = "jenkins_anm_bot"
telegram_channel_id = "-1001721361023"
sonartoken = "15373bb1f498a29ede21cacd687bb105dec45d1f"
