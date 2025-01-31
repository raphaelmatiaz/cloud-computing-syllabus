# Generic variables
client_name = "Meta"

# Add more environments to the array if needed
environments = ["dev", "qa", "prod"] # "games", "live-operations"

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


# client_name        = "Rockstar"
# postgres_password = "rockstar-postgres-password"
# postgres_db       = "rockstar_odoo_db"
# postgres_user     = "rockstar_odoo_user"
# odoo_image        = "rockstar/odoo:latest"
# environments      = ["dev", "qa", "prod"] # Add adicional desired environments to this array

# app-name = "odoo-rockstar-app"
# app_image             = "odoo:18" 
# app_replica_amount   = 2