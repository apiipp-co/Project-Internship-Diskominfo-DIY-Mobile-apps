# Jogjis

Aplikasi platform layanan publik dan informasi terpadu untuk wilayah Yogyakarta, dibangun menggunakan Flutter.

![Jogjis App](https://raw.githubusercontent.com/apiipp-co/Project-Internship-Diskominfo-DIY-Mobile-apps/main/Blue%20and%20White%20Modern%20Mobile%20App%20Developer%20Instagram%20Post.png)







## Tentang Proyek

Proyek Jogjis adalah aplikasi mobile multi-platform yang dikembangkan menggunakan **Flutter**. Aplikasi ini dirancang untuk meningkatkan interaksi masyarakat dengan berbagai layanan dan informasi publik di area Yogyakarta. Dengan antarmuka yang ramah pengguna, aplikasi ini menyediakan akses mudah ke fitur-fitur esensial mulai dari proses autentikasi hingga layanan spesifik berbasis lokasi dan komunikasi.

## Fitur Utama

* **Alur Autentikasi Lengkap:** Mendukung pendaftaran akun baru, login, pemulihan kata sandi (lupa password), dan verifikasi akun.
* **Pengalaman Onboarding:** Layar interaktif di awal penggunaan untuk memperkenalkan fitur-fitur utama aplikasi kepada pengguna baru.
* **Dashboard dan Beranda:** Tampilan ringkasan dan titik akses cepat ke berbagai fungsi aplikasi setelah login.
* **Manajemen Profil:** Pengguna dapat melihat dan memperbarui informasi pribadi mereka.
* **Komunikasi:** Fitur pesan dan chat untuk interaksi antar pengguna atau dengan pihak terkait (misalnya, helpdesk).
* **Sistem Pengaduan:** Memungkinkan pengguna untuk mengajukan, mengedit, melihat status, dan detail pengaduan yang mereka buat.
* **Informasi dan Pemantauan CCTV:** Menampilkan lokasi CCTV dan memungkinkan pengguna untuk melihat tayangan langsung (jika diimplementasikan) atau informasi terkait.
* **Akses Informasi Publik:** Menyediakan halaman-halaman khusus untuk mengakses dokumen publik, artikel berita, dan informasi spesifik terkait wilayah Yogyakarta (IDMC, Jogja IY, JSP).
* **Komponen UI Reusable:** Pustaka widget kustom yang digunakan di seluruh aplikasi untuk memastikan konsistensi visual dan mempercepat pengembangan.

## Struktur Proyek

Proyek ini mengikuti struktur direktori standar Flutter. Kode sumber utama aplikasi berada di dalam folder `lib/`.
jogjis-main/
├── android/          # File proyek native Android
├── ios/              # File proyek native iOS
├── lib/              # Kode Sumber Aplikasi Flutter (Dart)
│   ├── Screens/      #   ├── Login-Signup/ # Layar Autentikasi
│   │   ├── On_Board/     #   ├── Layar Onboarding
│   │   └── Views/        #   └── Layar Fungsional Utama (Dashboard, Pengaduan, CCTV, dll.)
│   ├── Widgets/      #   └── Komponen UI yang dapat digunakan kembali
│   └── main.dart     #   Titik masuk aplikasi
├── linux/            # File proyek native Linux
├── macos/            # File proyek native macOS
├── web/              # File proyek web
├── windows/          # File proyek native Windows
├── test/             # Kode untuk unit dan widget testing
├── pubspec.yaml      # Konfigurasi proyek, dependensi, dan aset
├── analysis_options.yaml # Aturan static analysis kode Dart
└── README.md         # Dokumentasi proyek

## Teknologi yang Digunakan

* **Flutter:** UI toolkit open-source dari Google untuk membangun aplikasi yang terkompilasi secara native untuk mobile (Android, iOS), web, dan desktop dari satu basis kode.
* **Dart:** Bahasa pemrograman yang digunakan oleh Flutter.
* **Dependensi Eksternal:** Proyek ini memanfaatkan berbagai paket dan plugin dari Pub.dev untuk fungsionalitas tambahan (seperti `video_player`, `url_launcher`, `sqflite`, `path_provider`, dll. - detail lengkap ada di `pubspec.yaml`).

## Memulai Proyek

Untuk menjalankan proyek ini di lingkungan pengembangan lokal Anda, ikuti langkah-langkah berikut:

### Prasyarat

* Pastikan Anda telah menginstal **Flutter SDK** versi stabil terbaru. Ikuti panduan instalasi di [flutter.dev](https://flutter.dev/docs/get-started/install).
* Siapkan editor kode yang mendukung pengembangan Flutter (seperti VS Code dengan plugin Flutter atau Android Studio).
* Siapkan perangkat atau emulator/simulator (Android atau iOS) atau konfigurasikan untuk platform desktop/web jika berencana menjalankannya di sana.

### Instalasi

1.  **Clone Repositori:** Buka terminal atau command prompt, navigasikan ke direktori tempat Anda ingin menyimpan proyek, lalu jalankan perintah berikut:
    ```bash
    git clone <URL_REPOSITORI_GITHUB_ANDA>
    cd Jogjis-main
    ```
    **Penting:** Ganti `<URL_REPOSITORI_GITHUB_ANDA>` dengan URL sebenarnya dari repositori GitHub tempat Anda akan mengunggah kode ini.
2.  **Ambil Dependensi:** Di dalam direktori proyek (`Jogjis-main`), jalankan perintah untuk mengunduh semua paket dan plugin yang dibutuhkan:
    ```bash
    flutter pub get
    ```

### Menjalankan Aplikasi

Setelah semua dependensi terunduh:

1.  Pastikan perangkat, emulator, atau simulator Anda sudah berjalan dan terhubung. Anda dapat memeriksa perangkat yang tersedia dengan perintah `flutter devices`.
2.  Jalankan aplikasi dengan perintah:
    ```bash
    flutter run
    ```
    Atau gunakan opsi "Run" yang tersedia di editor kode Anda.

## Kontribusi

Kami sangat menyambut kontribusi Anda pada proyek Jogjis! Jika Anda ingin berkontribusi, silakan ikuti langkah-langkah umum berikut:

1.  Fork repositori ini.
2.  Buat branch baru untuk fitur atau perbaikan Anda (`git checkout -b feature/nama-fitur` atau `bugfix/deskripsi-singkat`).
3.  Commit perubahan Anda dengan pesan yang jelas.
4.  Push branch baru Anda ke fork repositori Anda.
5.  Buat Pull Request (PR) ke branch utama di repositori ini.

Mohon pastikan untuk menguji perubahan Anda dan usahakan agar kode Anda mengikuti gaya coding yang sudah ada dalam proyek.
