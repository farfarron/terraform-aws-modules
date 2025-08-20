########################################
# PROVIDER INHERITADO
# El módulo espera que se le pase el provider desde el root.
########################################

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
