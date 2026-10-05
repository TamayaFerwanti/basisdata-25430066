# Laporan Praktikum Basis Data - Pertemuan 01 

 **Nama:** Tamaya Ferwanti 
 **NIM:** 25430066 
 **Kelas:** C 
 **Tanggal:** 5 Oktober 2026 

 --- 

 ## 1. Tujuan Praktikum 
 * Mampu mengonfigurasi lingkungan kerja basis data MariaDB melalui XAMPP dan Command Prompt (CMD). 
 * Mampu membuat basis data, mengelola akun pengguna, dan mengatur hak akses secara aman. 
 * Mampu menganalisis dan membedakan kode galat hak akses basis data (ERROR 1045, ERROR 1044, dan ERROR 1142). 
 * Mampu mengubah metode autentikasi phpMyAdmin menjadi mode cookie. 
 * Mampu menerapkan version control menggunakan Git dan GitHub untuk Milestone Proyek 1. 

 --- 

 ## 2. Ringkasan Dasar Teori 
 Basis data relasional memerlukan sistem pengamanan berjenjang untuk menjaga integritas data. Pada MariaDB/MySQL, manajemen pengguna dilakukan melalui perintah DCL seperti `CREATE USER`, `GRANT`, dan `REVOKE`. Hak akses ditentukan berdasarkan kombinasi nama pengguna, host asal, dan target basis data atau tabel. 

 Pengelolaan repositori proyek menggunakan Git memerlukan berkas konfigurasi seperti `README.md` sebagai dokumentasi proyek berformat Markdown dan `.gitignore` untuk mencegah berkas sensitif seperti file konfigurasi lokal atau kredensial terunggah ke repositori publik. 

 --- 

 ## 3. Hasil Langkah Percobaan 

 ### SS 1: Login Akun Utama (mhs_066) & Cek Versi Database 
 ! [SS 1: Login Akun Utama](img/ss1_login.png) 
 Login ke MariaDB menggunakan pengguna `mhs_066`, mengeksekusi perintah `SELECT VERSION();` untuk melihat versi server MariaDB yang aktif, serta menjalankan `SHOW DATABASES;` untuk menampilkan daftar basis data. 

 ### SS 2: Pengujian Hak Akses Akun Developer (dev_066) 
 ! [SS 2: Pengujian Akun Developer](img/ss2_dev.png) 
 Login menggunakan akun `dev_066`. Pengujian menunjukkan `dev_066` berhasil mengelola basis data `toko_066`, namun memunculkan ERROR 1044 (42000) saat mencoba mengakses basis data lain (`USE kopma_066;`) karena tidak memiliki izin. 

 ### SS 3: Pengujian Pembatasan Hak Akses Akun Guest (tamu_066) 
 ! [SS 3: Pengujian Akun Guest](img/ss3_tamu.png) 
 Login menggunakan akun `tamu_066`. Saat mencoba membuat tabel baru (`CREATE TABLE`), sistem menolak dan menampilkan ERROR 1142 (42000) karena akun ini hanya diberi hak akses baca (`SELECT`). 

 ### SS 4: Konfigurasi Login phpMyAdmin Mode Cookie 
 ! [SS 4: Login phpMyAdmin Mode Cookie](img/ss4_phpmyadmin.png) 
 Tampilan halaman masuk phpMyAdmin di peramban setelah mengubah parameter `$cfg['Servers'][$i]['auth_type'] = 'cookie';` pada file `config.inc.php`. Pengguna wajib memasukkan nama pengguna dan kata sandi secara manual saat membuka phpMyAdmin. 

 --- 

 ## 4. Jawaban Titik Analisis 
 Perbedaan dari ketiga kode galat yang diuji selama praktikum: 

 * **ERROR 1045 (28000): Access denied for user... (Using password: YES/NO)** 
 Terjadi pada tahap autentikasi awal. Penyebabnya adalah nama pengguna tidak terdaftar, kata sandi salah, atau host akses tidak sesuai. 
 * **ERROR 1044 (42000): Access denied for user... to database... ** 
 Terjadi pada tingkat hak akses basis data. Akun berhasil masuk ke MariaDB, namun ditolak saat membuka atau menggunakan basis data yang bukan wewenangnya. 
 * **ERROR 1142 (42000): CREATE command denied to user... for table... ** 
 Terjadi pada tingkat perintah atau operasi. Akun berhasil masuk ke dalam basis data, tetapi ditolak saat mengeksekusi perintah spesifik karena peran akun dibatasi. 

 --- 

 ## 5. Hasil Latihan dan Modifikasi 
 Penyuntingan berkas konfigurasi phpMyAdmin (`C:\xampp\phpMyAdmin\config.inc.php`) dilakukan dengan mengganti mode autentikasi dari `config` menjadi `cookie`. Modifikasi ini meningkatkan keamanan lingkungan kerja server lokal sehingga halaman phpMyAdmin tidak langsung terbuka secara otomatis tanpa autentikasi. 

 --- 

 ## 6. Tugas Mandiri: Milestone Proyek 1 
 Identitas proyek yang telah dikonfigurasi dan diunggah ke repositori Git: 

 * **Tema Proyek:** Toko / Minimarket (Kode Tema: `toko_066`) 
 * **Nama Organisasi Fiktif:** TF Mart 
 * **Nama Basis Data:** `toko_066` 
 * **Pengguna Pengembang:** `dev_066` 
 * **Lingkup Layanan:** Minimarket fiktif penyuplai kebutuhan pokok harian, makanan ringan, dan produk rumah tangga. Sistem dirancang untuk mengelola stok gudang, pencatatan transaksi kasir, data pemasok, dan retur barang. 
 * **Berkas Konfigurasi Git:** 
 * `README.md`: Berisi dokumentasi identitas proyek dan lingkup layanan. 
 * `.gitignore`: Mengabaikan berkas `*.env` dan `kredensial*.txt` agar tidak tersimpan di repositori publik. 

 --- 

 ## 7. Pembahasan dan Kendala 
 Praktikum berjalan dengan lancar, dengan beberapa penanganan kendala teknis sebagai berikut: 

 * **Kendala Pengetikan Sintaks SQL:** Terjadi kesalahan sintaks akibat pengetikan tanda petik yang kurang presisi saat pembuatan akun pengguna via CMD. Kendala diselesaikan dengan memastikan penulisan kueri SQL dilakukan secara teliti. 
 * **Kendala Encoding Berkas README.md:** Berkas `README.md` sempat tersimpan dalam format UTF-16 LE saat menggunakan editor standar sehingga membesar menjadi 13.6 KB dan gagal ditampilkan oleh GitHub. 
 * **Solusi Kendala Encoding:** Berkas dibuka dan dibuat ulang menggunakan format *encoding* UTF-8 murni, kemudian di-*commit* ulang. Setelah dilakukan *push*, isi berkas dapat dirender dengan sempurna di halaman repositori GitHub. 

 --- 

 ## 8. Kesimpulan 
 Praktikum Pertemuan 01 dan Milestone Proyek 1 berhasil diselesaikan. Konfigurasi basis data `toko_066` beserta akun `dev_066` pada MariaDB telah berfungsi sesuai spesifikasi hak akses. Pengamanan phpMyAdmin mode *cookie* serta integrasi *version control* menggunakan Git dan GitHub telah dikonfigurasi dengan baik tanpa ada berkas sensitif yang terunggah. 

 --- 

 ## 9. Pernyataan Penggunaan AI 
 Praktikum ini memanfaatkan asisten AI sebagai media diskusi dan konsultasi mandiri. AI digunakan untuk membantu analisis *troubleshooting* saat terjadi masalah *encoding* pada berkas `README.md` di GitHub serta memperdalam pemahaman terhadap perbedaan kode galat MariaDB. Seluruh eksekusi perintah di terminal, pembuatan basis data, dan penyusunan laporan dilakukan secara mandiri oleh mahasiswa. 

 --- 

 ## 10. Bukti Git 
 * **Tautan Repositori:** https://github.com/TamayaFerwanti/basisdata-25430066 
 * **Hash Commit Terakhir:** `a8bb607` 