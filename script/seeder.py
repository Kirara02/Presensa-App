from appwrite.client import Client
from appwrite.services.tables_db import TablesDB
from appwrite.services.users import Users
from appwrite.id import ID

# --- Konfigurasi Appwrite ---
PROJECT_ID = "[yourProjectId]"
PUBLIC_ENDPOINT = "[yourPublicEndpoint]"
API_KEY = "[yourApiKey]"
DATABASE_ID = "[yourDatabaseId]"
COMPANY_TABLE = "companies"
USERS_TABLE = "users"

# --- Setup Client ---
client = Client()
client.set_endpoint(PUBLIC_ENDPOINT) \
      .set_project(PROJECT_ID) \
      .set_key(API_KEY)
tables = TablesDB(client)
users = Users(client)


def main():
    # 1. Seeder untuk Company
    company = tables.create_row(
        database_id=DATABASE_ID,
        table_id=COMPANY_TABLE,
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
        email="admin@mail.com",
        password="satudua12",
        name="Kirara Bernstein"
    )
    print(f"✅ Admin user created: {admin['$id']}")

    # 3. Tambahkan ke Table `users`
    tables.create_row(
        database_id=DATABASE_ID,
        table_id=USERS_TABLE,
        row_id=ID.unique(),
        data={
            "userId": admin['$id'],
            "role": "admin",
            "companyId": company['$id'],
            "department": None,
            "phone": None
        }
    )
    print("✅ Admin linked to company!")


if __name__ == "__main__":
    main()