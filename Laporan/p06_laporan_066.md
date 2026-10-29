# Laporan Praktikum Basis Data - Modul 6

**Nama:** Tamaya Ferwanti  
**NIM:** 25430066  
**Kelas:** C / S1 Ilmu Komputer  
**Pertemuan:** 6  
**Tanggal:** 26 Oktober 2026  

---

## 1. Tujuan Praktikum
1. Belajar cara nambahin data pakai perintah `INSERT` (baik satu baris, banyak baris, maupun `INSERT SELECT`).
2. Nyobain proses `UPDATE` dan `DELETE` data secara aman pakai mode pengaman `sql_safe_updates`.
3. Bikin dan nyoba skenario uji coba, baik yang sukses (positif) maupun yang ketolak server (negatif), terus nyatet hasil nyatanya.
4. Nyiapin data sampel buat proyek mandiri **TF Mart** ($P=4$) yang bisa dibikin ulang lewat skrip SQL.

## 2. Ringkasan Dasar Teori
Secara garis besar, DML (*Data Manipulation Language*) itu dipakai buat ngelola isi data di dalam tabel, contohnya pakai `INSERT`, `UPDATE`, `DELETE`, dan `SELECT`. Karena di database kita pakai relasi *foreign key* (kunci tamu), urutan ngisi datanya nggak boleh ngasal—harus isi tabel induk (*master*) dulu baru bisa ngisi tabel anak (*transaksi*). Selain itu, variabel `sql_safe_updates` ngebantu banget buat ngejaga database dari kesalahan fatal, kayak nggak sengaja nge-update atau nge-delete data se-tabel penuh tanpa klausa `WHERE`.

## 3. Hasil Langkah Percobaan
- Berhasil nge-run skrip DML buat data master dan transaksi Kopma (`p06_data_kopma_25430066.sql`).
- Berhasil nyoba berbagai skenario uji coba, mulai dari yang datanya masuk dengan mulus sampai yang ditolak sama server gara-gara nabrak *constraint* (kayak *Error 4025, 1062, 1452, 1175*).
- Berhasil nyusun data sampel buat proyek **TF Mart** dengan parameter $P=4$ (total transaksi udah tembus $\ge 40$ baris yang nyebar di 3 tanggal berbeda).

### Bukti Tangkapan Layar Pengujian DML & Skenario Uji
![Hasil Skenario Uji Positif dan Negatif](image/p06_skenario_uji.png)
![Jumlah Baris Per Tabel Proyek](image/p06_jumlah_baris.png)

## 4. Jawaban Titik Analisis
1. **Titik Analisis 1:** Kenapa `INSERT SELECT` itu praktis? Karena harganya langsung ditarik otomatis dari tabel barang, jadi kita nggak perlu ngetik manual dan bisa ngehindari *human error*. Plus, kalau nanti harga barang naik di masa depan, nota transaksi yang lama nggak bakal ikut berubah karena harganya udah kesimpen jadi arsip snapshot historis.
2. **Titik Analisis 2:** Kalau nota dihapus, data detailnya bakal ikut kehapus otomatis gara-gara ada aturan `ON DELETE CASCADE`. Sebaliknya, kalau kita mau ngehapus data master yang masih nyangkut di transaksi, bakal langsung ditolak sama server (`ERROR 1451`) demi keamanan data historis. Solusi yang bener kalau kasir/petugas berhenti bukan dihapus baris datanya, tapi akunnya di-lock atau di-revoke aja aksesnya.
3. **Titik Analisis 3:** Nah, buat uji coba yang kemungkinannya bakal gagal (ini sebagai utang desain buat Modul 14 nanti), itu kasus pas kita mau jual barang tapi jumlah kuantitasnya melebihi stok yang ada di gudang. Constraint `CHECK` biasa ternyata nggak sanggup nahan ini karena pengecekannya butuh lintas tabel (*cross-table*), makanya nanti kita butuh bantuan *Trigger* atau *Stored Procedure*.

## 5. Hasil Latihan dan Modifikasi
1. Bikin query SQL buat mindahin data anggota lama yang daftar sebelum tahun 2025 ke tabel arsip (`anggota_arsip`) pakai kombinasi `CREATE TABLE LIKE` dan `INSERT SELECT`, tanpa harus ngerusak riwayat transaksi mereka yang masih aktif.
2. Nulis perintah `UPDATE` buat naikin harga barang untuk kategori produk tertentu sesuai instruksi modul.

## 6. Tugas Mandiri: Milestone Proyek 6 (TF Mart)
- **Tema Proyek:** Toko Daring / Minimarket **TF Mart** (`toko_066`).
- **Parameter Batas P:** $P = 66 \pmod 9 + 1 = 4$. Total baris transaksi utama udah mencapai $\ge 40$ baris dan tersebar minimal di 3 tanggal berbeda.
- **Berkas Terkait:** `p06_data_25430066.sql` dan `p06_uji_25430066.md`.

## 7. Kesimpulan
Modul 6 ini berhasil diselesaikan dengan baik. Kita jadi tahu cara pakai perintah DML secara aman, paham cara nyusun skenario uji error, dan sukses ngebangun data sampel buat proyek **TF Mart** yang bakal dipake di modul-modul berikutnya.

## 8. Pernyataan Penggunaan AI
Dalam pengerjaan laporan ini, bantuan AI (Gemini) digunakan secara kolaboratif untuk membantu merapikan struktur skrip SQL, merumuskan format tabel skenario uji, serta menyusun draf laporan agar lebih terstruktur.

## 9. Bukti Git
- **Tautan Repositori:** `https://github.com/TamayaFerwanti/basisdata-25430066`
- **Commit Hash Pertemuan 6:** `p06_hash`

---

## Checklist
- [x] Berkas `p06_data_kopma_25430066.sql`, `p06_uji_kopma_25430066.md`, `p06_data_25430066.sql`, & `p06_uji_25430066.md` Terbuat
- [x] Berkas Laporan `Laporan/p06_laporan_25430066.md` Terbuat
- [x] Tangkapan Layar `p06_skenario_uji.png` & `p06_jumlah_baris.png` Terlampir