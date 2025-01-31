# Generic variables
client_name = "Netflix"

# Add more environments to the array if needed
environments = ["dev", "qa", "prod"] # "staging", "test", "streaming", "sandbox" 

# Odoo App variables
app_name = "odoo-app"
app_container_name = "odoo-container"
app_image = "odoo:18" 
app_replica_amount = 1
app_container_port = 8069
app_host_port = 8069

# Odoo db variables
app_db_name = "postgres-db"
app_db_container_name = "postgres-container"
app_db_image = "postgres:13"
app_db_container_port = 5432
db_replica_amount = 1

postgres_host = "host" #odoo-postgres
postgres_db = "meta-odoo-db"
postgres_user = "meta-odoo-user"
postgres_password = "password"




# client_name        = "Netflix"
# postgres_password = "netflix-postgres-password"
# postgres_db       = "netflix_odoo_db"
# postgres_user     = "netflix_odoo_user"
# odoo_image        = "odoo:latest"
# environments      = ["dev", "qa", "prod"] # Add adicional desired environments to this array

# app-name = "odoo-netflix-app"
# app_image             = "odoo:18" 
# app_replica_amount   = 3


# clientName = "Netflix"
# cluster = {
#     name = "ntfx"
#     nodes = 1
#     addons = [ ingress ]
# }
# environments = [ "dev", "qa", "prod" ]
# odoo = {
#     containerName = "odoo"
#     ports = [{
#         "web" = 8069
#         "websockets" = 8072
#     }]
#     image = "odoo:18"
# }