# Generic variables
client_name = "Meta"

# Add more environments to the array if needed
environments = ["dev", "qa", "prod"] # "staging", "analytics", "research"

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


# odoo_app = {
#     app_name = "odoo-meta-app"
#     odoo_image = "odoo:18"
#     odoo_container_name = "odoo_container"
#     container_port = 8069
#     odoo_app_replica_amount = 4
# }


# Modify the below code to setup configuration for a different app:
# appname_app = {
#     app_image = "image:version"
#     app_container_name = "app_container"
#     container_port = 1234
# }


# Atribuição das variaveis. No outro sitio é a "Declaração/Criação" da variavel. Em odoo_postgres.tf