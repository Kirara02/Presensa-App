Presensa App adalah aplikasi Flutter untuk sistem presensi dengan Appwrite sebagai backend.

## 📦 Fitur

- **Authentication**: Login (Admin & Employee)
- **State Management**: Menggunakan Riverpod
- **Appwrite Database**: Penyimpanan data user dan role
- **Localization**: Mendukung multi bahasa (l10n)
- **Struktur modular**: Siap dikembangkan untuk fitur selanjutnya

---

## 🚀 Setup Project

1. Clone repository
   ```bash
   git clone <repo-url>
   cd presensa_app
   ```
2. install dependencies
   ```bash
   flutter pub get
   ```
3. Jalankan project
   ```bash
   flutter run
   ```

## 🗂 Struktur Project

```
lib/
├── main.dart                # Entry point aplikasi
└── src/
    ├── presensa.dart        # Root widget aplikasi
    ├── constants/           # Konstanta global (warna, ukuran, enum, dsb)
    ├── core/                # Core logic: logger, provider global, mixin, exception
    ├── features/            # Fitur utama aplikasi (auth, home, dsb)
    ├── l10n/                # Localization (multi bahasa)
    ├── routes/              # Konfigurasi dan sub-routes aplikasi
    ├── utils/               # Utility/helper & extension function
    └── widgets/             # Widget reusable & komponen UI
```

## 🛠 Backend (Appwrite)

Aplikasi ini menggunakan **Appwrite Cloud** sebagai backend untuk autentikasi dan database.

### 📂 Struktur Database

- **Database**: `presensa_db`
- **Tables (Collections)**:
  - `companies`
    - `name` (string)
    - `address` (string)
    - `location` (string, optional)
  - `users`
    - `userId` (string, relasi ke Appwrite Users)
    - `role` (string: `admin` | `employee`)
    - `companyId` (string, relasi ke `companies`)
    - `department` (string, optional)
    - `phone` (string, optional)

### 🔑 User Roles

- **Admin**
  - Membuat dan mengelola perusahaan
  - Mengatur data karyawan
- **Employee**
  - Hanya bisa login & mengakses fitur presensi

---

## 🧪 Seeder Script

Seeder tersedia di folder `script/` menggunakan **Python + Appwrite SDK**.  
Fungsi:

- Membuat `Company`
- Membuat `Admin User`
- Menghubungkan Admin ke Company

### Menjalankan Seeder

1. Masuk ke folder `script/`
   ```bash
   cd script
   ```
2. Aktifkan virtual environment
   ```bash
   source venv/bin/activate
   ```
3. Jalankan seeder
   ```bash
   python seeder.py
   ```
