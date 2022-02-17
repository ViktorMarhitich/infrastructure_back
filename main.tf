provider "vault" {
 address = "http://127.0.0.1:8200"
 token = "00000000-0000-0000-0000-000000000000"
}

data "vault_generic_secret" "AWS" {
  path = "secret/AWS"
}

provider "aws" {
    access_key = data.vault_generic_secret.AWS.data["AWS_ACCESS_KEY"]
    secret_key = data.vault_generic_secret.AWS.data["AWS_SECRET_KEY"]
    region = var.aws_region
}










