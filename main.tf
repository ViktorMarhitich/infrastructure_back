# provider "vault" {
#  address = "http://127.0.0.1:8200"
#  token = "00000000-0000-0000-0000-000000000000"
# }

# data "vault_generic_secret" "AWS" {
#   path = "secret/AWS"
# }

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}










