# Laporan Praktikum Basis Data - Modul 5

**Nama:** Tamaya Ferwanti  
**NIM:** 25430066  
**Kelas:** C / S1 Ilmu Komputer  
**Mata Kuliah:** Basis Data  
**Tanggal:** 19 Oktober 2026  

---

## 1. Tujuan Praktikum
1. Menerjemahkan skema relasional 3NF menjadi perintah `CREATE TABLE` dengan tipe data yang akurat dan efisien di MariaDB[cite: 3].
2. Menerapkan *constraint* secara presisi (`PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `NOT NULL`, `DEFAULT`, dan `CHECK`) untuk mengalihkan aturan bisnis dari disiplin pengguna ke jaminan server[cite: 3, 4].
3. Mengubah dan menghapus struktur tabel menggunakan `ALTER TABLE` dan `DROP TABLE` dengan urutan hierarki anak-ke-induk yang benar[cite: 3].
4. Membuktikan bahwa *constraint* aktif menolak data yang melanggar aturan integritas serta menyamakan hasil desain fisik dengan ERD[cite: 3].

## 2. Ringkasan Dasar Teori
Data Definition Language (DDL) digunakan untuk membangun dan memodifikasi kerangka kerja basis data[cite: 3]. Pemilihan tipe data sangat krusial agar memori tidak boros namun tetap menampung data valid[cite: 3]. Penerapan *constraint* seperti `CHECK` (sejak MariaDB 10.2) memastikan aturan bisnis seperti stok tidak boleh negatif (`AB-03`) dijaga langsung oleh server[cite: 4]. Selain itu, urutan pembuatan tabel harus mendahulukan tabel induk (*master*) sebelum tabel anak (*transaksi*), dan sebaliknya urutan penghapusan harus dimulai dari tabel anak ke induk[cite: 4].

## 3. Hasil Langkah Percobaan
- Berhasil membuat berkas skrip DDL lengkap `p05_ddl_kopma_25430066.sql` dan skrip proyek mandiri `p05_ddl_25430066.sql` untuk toko daring **TF Mart**.
- Melakukan verifikasi struktur tabel menggunakan perintah `SHOW TABLES;` dan `SHOW CREATE TABLE penjualan;`.
- Menguji ketahanan *constraint* server terhadap data salah, yang terbukti menolak input tidak valid dengan kode galat resmi MariaDB.

### Bukti Tangkapan Layar Pengujian Constraint
![Struktur Tabel Utama (SHOW CREATE TABLE)](image/p05_show_create.png)
![Server Menolak Data Salah (Constraint Error 1452 & 4025)](image/p05_constraint_error.png)

## 4. Jawaban Titik Analisis
1. **Titik Analisis 1:** `fk_detail_penjualan` memakai `ON DELETE CASCADE` agar rincian nota terhapus otomatis jika nota dibatalkan, sementara `fk_detail_barang` tidak memakai cascade demi melindungi data historis laporan penjualan lama dari penghapusan produk secara sembarangan[cite: 6].
2. **Titik Analisis 2:** Kode galat `1452` memetakan pelanggaran integritas Kunci Tamu (Foreign Key), kode `4025` memetakan pelanggaran aturan bisnis stok negatif (`AB-03`), dan kode `1062` memetakan pelanggaran nilai unik (`AB-05`)[cite: 6, 7].
3. **Titik Analisis 3:** Perintah `DROP TABLE IF EXISTS` wajib dimulai dari tabel anak (`detail_pembelian`, `detail_penjualan`) karena tabel induk masih terikat oleh relasi referensial; jika dibalik, server akan menolak dengan galat Error 3730[cite: 7, 26].

## 5. Hasil Latihan dan Modifikasi
1. Menambahkan constraint `CHECK` pada kolom `stok_min_barang` agar nilainya selalu non-negatif[cite: 12].
2. Mengonfigurasi aksi `ON DELETE SET NULL` pada relasi anggota ke penjualan untuk menjaga kepatuhan terhadap aturan bisnis diskon dan prinsip minimalkan data pribadi (UU PDP)[cite: 12].

## 6. Tugas Mandiri: Milestone Proyek 5 (TF Mart)
- **Tema Proyek:** Toko Daring / Minimarket (**TF Mart**, `toko_066`)[cite: 12].
- **Parameter Batas P ($P = 66 \pmod 9 + 1 = 4$):** Mengimplementasikan batas stok minimum produk senilai `4` ($P$) atau batas cadangan minimum[cite: 12].
- **Hasil Berkas DDL:** Menyusun berkas `p05_ddl_25430066.sql` yang merangkum tabel relasional utama proyek **TF Mart** lengkap dengan seluruh *constraint* dan komentar kode aturan bisnis (`AB-xx`)[cite: 12].

## 7. Kesimpulan
Modul 5 berhasil diselesaikan dengan membangun seluruh arsitektur fisik tabel basis data Kopma dan proyek mandiri **TF Mart** secara terstruktur, di mana aturan bisnis kini dijaga secara mutlak oleh server melalui mekanisme *constraint* dan tipe data yang ketat[cite: 3, 4].

## 8. Pernyataan Penggunaan AI
Penggunaan AI (Gemini) dimanfaatkan untuk membantu menyusun sintaks DDL MariaDB yang valid, pemetaan kode galat *constraint*, serta perapian laporan ke dalam format Markdown.

## 9. Bukti Git
- **Tautan Repositori:** `https://github.com/TamayaFerwanti/basisdata-25430066`
- **Commit Hash Pertemuan 5:** `p05_hash`

---

## Checklist
- [x] Berkas `p05_ddl_kopma_25430066.sql` & `p05_ddl_25430066.sql` Terbuat
- [x] Berkas Laporan `Laporan/p05_laporan_25430066.md` Terbuat[cite: 13]
- [x] Tangkapan Layar `p05_show_create.png` & `p05_constraint_error.png` Terlampir.