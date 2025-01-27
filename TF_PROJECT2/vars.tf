# variable "environment" {
#     type = list(string)
#     default = ["dev", "beta", "prod"]
#     description = "Environment (aka k8s namespace)"
# }

# Aqui estamos a definir variaveis para dizer ao terraform 'usa estas variaveis' quando fazemos um apply: terraform plan apply
# Isto são 'input variables'. 
# Também existe 'output variables'.
# Também existe 'local variables'. Não vamos usar aqui na aula.

variable "clients" {
  type = map(object({
    image       = string
    replicas    = object({
      dev  = number
      qa   = number
      prod = number
    })
    domain_prod = string
    tls_secret  = string
  }))
  default = {
    netflix = {
      image       = "odoo:14"
      replicas    = { dev = 1, qa = 2, prod = 3 }
      domain_prod = "netflix.example.com"
      tls_secret  = "netflix-tls-secret"
    }
    meta = {
      image       = "odoo:14"
      replicas    = { dev = 1, qa = 2, prod = 3 }
      domain_prod = "meta.example.com"
      tls_secret  = "meta-tls-secret"
    }
    rockstar = {
      image       = "odoo:14"
      replicas    = { dev = 1, qa = 2, prod = 3 }
      domain_prod = "rockstar.example.com"
      tls_secret  = "rockstar-tls-secret"
    }
  }
}

variable "environment" {
  type = list(string)
  default = ["dev", "qa", "prod"]
  description = "Environment (aka k8s namespace)"
}
