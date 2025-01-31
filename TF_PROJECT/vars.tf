variable "environments" {
    type = list(string)
    default = ["dev", "beta", "prod"]
    description = "Environment (aka k8s namespace)"
}

variable "app_name" {
    type = string
    default = "my-app"
    description = "Name attributed to the app"
}

variable "client_name" {
    type = string
    description = "The name of the Client"
}

variable "app_replica_amount" {
    type = number
    description = "The amount of replicas of the app"
}

variable "db_replica_amount" {
    type = number
    default = 1
    description = "The amount of replicas of the app"
}


# Postgres DB Stuff
variable "postgres_host" {
  type        = string
  default = "host"
  description = "The PostgreSQL Host"
}

variable "postgres_db" {
  type        = string
  default = "db"
  description = "The name of the PostgreSQL database"
}

variable "postgres_user" {
  type        = string
  default = "user"
  description = "The PostgreSQL user"
}

variable "postgres_password" {
  type        = string
  default = "password"
  description = "The password for the PostgreSQL user"
}

variable "app_db_name" {
    type = string
    default = "db"
    description = "The database name of the app"
}

variable "app_db_image" {
    type = string
    default = "postgres:13"
    description = "The db image for the db container of the app"
}

variable "app_db_container_port" {
    type = number
    default = 5432
    description = "The db container's exposed port number"
}

variable "app_db_container_name" {
    type = string
    default = "db-container"
    description = "The db container's name"
}


variable "app_image" {
  type        = string
  default     = "odoo:18"
  description = "The Docker image for Odoo"
}

variable "app_container_name" {
    type = string
    default = "app-container"
    description = "The app container's name"
}

variable "app_container_port" {
    type = number
    default = 8069
    description = "The exposed port on the odoo container"
}



variable "app_host_port" {
    type = number
    default = 8069
    description = "The exposed host port to be mapped to the odoo app's container port"
}




# variable "odoo_app" {
#     type = object({
#       app_name = string
#       odoo_image = string
#       odoo_container_name = string
#       container_port = number
#       odoo_app_replica_amount = number
#     })
#     default = {
#       app_name                = "default-odoo-app"
#       odoo_image              = "odoo:18"
#       odoo_container_name     = "odoo_container"
#       container_port          = 8069
#       odoo_app_replica_amount = 1
#   }
  
# }