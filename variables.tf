variable "key_name" {
  type        = string
  description = "AWS Key Pair Name"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "file_path" {
  description = "Path to file"
}

variable "private_key_path" {
  type        = string
  description = "Path to key file"
}

variable "aws_cloudwatch_retention_in_days" {
  type        = number
  description = "AWS CloudWatch Logs Retention in Days"
  default     = 1
}

variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "app_environment" {
  type        = string
  description = "Application Environment"
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "ingress_cidr_blocks" {
  description = "Which IP can connect"
}

variable "public_subnets" {
  description = "List of public subnets"
}

variable "private_subnets" {
  description = "List of private subnets"
}
variable "jenkins_subnets" {
  description = "List of private subnets"
}
variable "availability_zones" {
  description = "List of availability zones"
}

variable "bucket_name" {
  description = "(Required) Creates a unique bucket name"
  type        = string
  default     = "what-front"
}

variable "force_destroy" {
  description = "(Optional) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error"
  type        = string
  default     = true
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the bucket"
  type        = map(any)
  default     = { "env" : "production" }
}

variable "retain_on_delete" {
  description = "Instruct CloudFront to simply disable the distribution instead of delete"
  default     = false
}

variable "price_class" {
  description = "Price classes provide you an option to lower the prices you pay to deliver content out of Amazon CloudFront"
  default     = "PriceClass_All"
}
#-----------------------------
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "DB_USERNAME" {}

variable "DB_PASSWORD" {}

variable "dev_server_instance_type" {
  default = "t2.micro"
}

variable "dev_public_key" {}

variable "task_enviornment" {
  default = [
    {
      "NET_ENV": "release",
      "name": "release"
    }
  ]
}

variable "github_token" {}
variable "aws_secretKey" {}
variable "TelegramBotToken" {}
variable "AWS_ACCOUNT" {}
variable "Telegram_Token" {}
variable "telegram_bot_name" {}
variable "telegram_channel_id" {}

variable "ingressrules" {
  type    = list(number)
  default = [9000, 8080, 22, 443, 80, 8000, 8081, 50000]
}
variable sonartoken {}