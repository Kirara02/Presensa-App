import os
from appwrite.client import Client
from appwrite.services.tables_db import TablesDB
from appwrite.services.users import Users
from appwrite.id import ID
from dotenv import load_dotenv 

load_dotenv() 

PROJECT_ID = os.getenv("APPWRITE_PROJECT_ID")
API_ENDPOINT = os.getenv("APPWRITE_API_ENDPOINT") 
API_KEY = os.getenv("APPWRITE_API_KEY")
DATABASE_ID = os.getenv("APPWRITE_DATABASE_ID")
COMPANY_TABLE_ID = os.getenv("APPWRITE_COMPANY_TABLE_ID")
USERS_TABLE_ID = os.getenv("APPWRITE_USERS_TABLE_ID")

required_vars = [
    "APPWRITE_PROJECT_ID", "APPWRITE_API_ENDPOINT", "APPWRITE_API_KEY", 
    "APPWRITE_DATABASE_ID", "APPWRITE_COMPANY_TABLE_ID", "APPWRITE_USERS_TABLE_ID"
]
for var in required_vars:
    if not globals()[var.replace("APPWRITE_", "")]:
        raise ValueError(f"Environment variable {var} not set. Please create a .env file or export it.")

# --- Setup Client ---
client = Client()
client.set_endpoint(API_ENDPOINT) \
      .set_project(PROJECT_ID) \
      .set_key(API_KEY)
tables = TablesDB(client)
users = Users(client)


def main():
    # 1. Seeder untuk Company
    company = tables.create_row(
        database_id=DATABASE_ID,
        table_id=COMPANY_TABLE_ID,
        row_id=ID.unique(),
        data={
            "name": "Soul Society Inc.",
            "address": "Jl. Zanpakuto No. 45, Seireitei",
            "location": None
        }
    )
    print(f"✅ Company created: {company['$id']}")

    # 2. Buat Admin User di Authentication
    admin = users.create(
        user_id=ID.unique(),
        email="admin2@mail.com",
        password="satudua12",
        name="Kirara Bernstein Admin"
    )
    print(f"✅ Admin user created: {admin['$id']}")
    users.update_email_verification(
        user_id=admin['$id'],
        email_verification=True
    )
    print(f"✅ User verified: {admin['$id']}")

    # 3. Tambahkan ke Table `users`
    tables.create_row(
        database_id=DATABASE_ID,
        table_id=USERS_TABLE_ID,
        row_id=ID.unique(),
        data={
            "userId": admin['$id'],
            "role": "super-admin",
            "companyId": company['$id'],
            "department": None,
            "phone": None
        }
    )
    print("✅ Admin linked to company!")


if __name__ == "__main__":
    main()