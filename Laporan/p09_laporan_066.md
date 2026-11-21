# Laporan Praktikum Basis Data - Modul 9

**Nama:** Tamaya Ferwanti  
**NIM:** 25430066  
**Kelas:** C / S1 Ilmu Komputer  
**Pertemuan:** 9  
**Tanggal:** 21 November 2026  

---

## 1. Tujuan Praktikum
1. Menggunakan fungsi agregat `COUNT`, `SUM`, `AVG`, `MIN`, dan `MAX` secara tepat dalam peringkasan data transaksi.
2. Mengelompokkan baris data memakai `GROUP BY` serta menyaring kelompok hasil agregasi dengan klausa `HAVING`.
3. Menyusun laporan ringkasan bertingkat menggunakan `WITH ROLLUP`.
4. Menjaga ketepatan semantik agregasi sesuai aturan `ONLY_FULL_GROUP_BY`.

## 2. Ringkasan Dasar Teori
Fungsi agregat menggabungkan banyak baris menjadi satu nilai ringkasan. Jika tidak memakai `GROUP BY`, seluruh baris diperlakukan sebagai satu kelompok tunggal; jika memakai `GROUP BY`, baris dikelompokkan berdasarkan kolom tertentu lalu diringkas per kelompok. Klausa `WHERE` menyaring baris sebelum proses pengelompokan, sedangkan `HAVING` menyaring kelompok sesudah nilai agregat dihitung.

## 3. Hasil Langkah Percobaan & Kendala Lingkungan
- Saat mencoba mengaktifkan `ONLY_FULL_GROUP_BY` pada MariaDB 10.4.32 (XAMPP), muncul `ERROR 1231 (42000)` karena nilai tersebut tidak tersedia pada variabel `sql_mode` bawaan versi MariaDB ini (`NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION`).
- Untuk mencegah kesalahan semantik agregasi, pengecekan dilakukan secara disiplin pada setiap penulisan kueri dengan memastikan seluruh kolom non-agregat di `SELECT` ikut tercantum pada `GROUP BY`.
- Kueri ringkasan omzet harian dengan `WITH ROLLUP` dan penyaringan stok dengan `HAVING` berhasil dijalankan pada basis data proyek **TF Mart** (`toko_066`).

![Hasil Laporan Ringkasan Agregasi](Image/p09_ringkasan.png)

## 4. Jawaban Titik Analisis & Latihan
1. **Titik Analisis 1 (`ERROR 1055`):** Menghapus kolom non-agregat dari `GROUP BY` saat `ONLY_FULL_GROUP_BY` aktif memicu `ERROR 1055` karena server mewajibkan setiap kolom non-agregat pada `SELECT` tercantum jelas di `GROUP BY` agar hasilnya konsisten dan tidak mengambil baris secara acak.
2. **Titik Analisis 2 (`COUNT(DISTINCT ...)` vs `COUNT(*)`):** Pada relasi satu transaksi ke banyak detail, `COUNT(*)` menghitung jumlah baris item detail, sedangkan `COUNT(DISTINCT p.id_penjualan)` atau `COUNT(DISTINCT p.id_pesanan)` menghitung jumlah nota/pesanan unik yang sebenarnya.
3. **Titik Analisis 3 (`WHERE` vs `HAVING`):** Syarat penyaringan baris seperti "anggota saja" diletakkan pada `WHERE` karena `WHERE` dijalankan sebelum `GROUP BY` dan perhitungan fungsi agregat (`AVG`) dilakukan.

## 5. Kaitan Laporan dengan KI & Pemakaian `HAVING`
- Seluruh kueri pada `p09_agregasi_25430066.sql` dipetakan ke kebutuhan informasi (KI) proyek **TF Mart** (`toko_066`) dengan mengacu pada parameter $P = 4$.
- Klausa `HAVING` dipakai untuk menyaring hasil agregasi kelompok (misalnya `SUM(stok_produk) > 4` dan `COUNT(DISTINCT p.id_pesanan) >= 5`), karena kondisi tersebut baru diketahui setelah agregasi kelompok selesai dilakukan.

## 6. Pernyataan Penggunaan AI
Bantuan AI dimanfaatkan untuk membantu menyusun struktur kueri SQL, memverifikasi kesesuaian nama kolom pada skema `toko_066`, serta merapikan susunan draf laporan praktikum.

## 7. Bukti Git
- **Tautan Repositori:** `https://github.com/TamayaFerwanti/basisdata-25430066`
- **Commit Hash Pertemuan 9:** `5a5447d`
