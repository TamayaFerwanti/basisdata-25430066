# Laporan Praktikum Basis Data - Modul 7

**Nama:** Tamaya Ferwanti  
**NIM:** 25430066  
**Kelas:** C / S1 Ilmu Komputer  
**Pertemuan:** 7  
**Tanggal:** 29 Oktober 2026  

---

## 1. Tujuan Praktikum
1. Memahami cara mengambil data pakai klausa `SELECT`, proyeksi kolom tertentu, bikin alias kolom (`AS`), dan nampilin data unik pakai `DISTINCT`.
2. Mampu menyaring data (*filtering*) pakai bermacam-macam operator, mulai dari pembanding, logika, `BETWEEN`, `IN`, `LIKE`, sampai `IS NULL`.
3. Mengatur urutan tampilan data pakai `ORDER BY` serta membatasi jumlah baris output pakai `LIMIT`.
4. Menggunakan fungsi skalar (string, tanggal, numerik, dan kondisional) buat menyajikan informasi yang lebih siap dibaca.

## 2. Ringkasan Dasar Teori
Kueri `SELECT` itu perintah utama buat ngambil data di database. Pas ditulis, urutannya emang `SELECT - FROM - WHERE - ORDER BY - LIMIT`. Tapi secara sistem (logika eksekusi MariaDB), urutannya beda banget: `FROM` berjalan dulu buat nentuin tabelnya, terus disaring di `WHERE`, baru diproses di `SELECT`, diurutkan di `ORDER BY`, dan dibatasi sama `LIMIT`.

Pentingnya paham urutan eksekusi ini biar kita nggak bingung pas dapet error. Contohnya pas kita bikin alias kolom di `SELECT`, alias itu nggak bakal dikenali di klausa `WHERE` karena `WHERE` udah jalan lebih dulu sebelum aliasnya sempet dibikin. Terus buat data kosong (`NULL`), penanganannya harus pakai operator khusus `IS NULL` atau `IS NOT NULL`, soalnya kalau dibandingin pakai operator biasa kayak `=` hasilnya bakal *unknown* atau kosong terus.

## 3. Hasil Langkah Percobaan
- Berhasil nulis dan ngetes seluruh kueri latihan Kopma (`p07_kueri_kopma_25430066.sql`), mulai dari pencarian stok minimum, filter rentang tanggal, penanganan nomor HP kosong, sampai perhitungan lama keanggotaan.
- Berhasil ngebuktikan error akibat salah paham urutan eksekusi kueri (`ERROR 1054`) dan bedanya perbandingan `= NULL` sama `IS NULL`.
- Berhasil ngebikin 10 kueri mandiri satu tabel buat proyek **TF Mart** (`toko_066`) dengan parameter $P=4$ yang udah dilengkapi komentar KI dan estimasi/prediksi hasilnya.

### Bukti Tangkapan Layar Pengujian Kueri & Fungsi Skalar
![Hasil Skenario Uji Kueri Modul 7](image/p07_skenario_uji.png)
![Hasil Eksekusi Milestone Proyek](image/p07_jumlah_baris.png)

## 4. Jawaban Titik Analisis
1. **Titik Analisis 1:** Kenapa pas `ORDER BY kurang` diganti jadi `WHERE kurang > 0` langsung dapet `ERROR 1054 Unknown column 'kurang' in 'where clause'`? Jawabannya karena urutan eksekusi logis SQL. Klausa `WHERE` diproses di langkah ke-2, sedangkan alias `kurang` baru dibikin di langkah ke-3 (`SELECT`). Karena `WHERE` jalan duluan, dia belum kenal siapa itu `kurang`. Cara nulis kueri penyaringan yang setara tanpa alias adalah nulis ulang rumus aslinya di `WHERE`, yaitu: `WHERE (stok_min_barang - stok_barang) > 0`.
2. **Titik Analisis 2:** Kenapa kueri `WHERE no_hp_anggota = NULL` nggak pernah keluarin hasil padahal ada data yang kosong? Soalnya di SQL, `NULL` itu dianggap nilai yang *unknown* (tidak diketahui/tidak ada). Operasi pembandingan pakai `=` kalau diadu sama `NULL` bakal selalu bernilai salah/unknown. Makanya kueri yang bener harus pakai operator `WHERE no_hp_anggota IS NULL`. Beda cerita kalau string kosong `''`, string kosong itu tetep ada nilainya tapi cuma ketiadaan karakter (panjangnya 0).
3. **Titik Analisis 3:** Di modul ini kita udah bisa ngitung subtotal per baris (`qty * harga_satuan`), tapi kok belum bisa ngitung total harga satu nota sekaligus? Soalnya ngitung subtotal baris itu sifatnya operasi horizontal per baris (*scalar*). Sedangkan kalau mau ngitung total satu nota, kita butuh menggabungkan banyak baris transaksi menjadi satu nilai akhir. Fitur SQL yang dibutuhkan buat kasus ini adalah **Fungsi Agregasi** (kayak `SUM()`) bareng klausa `GROUP BY`, yang nanti baru dipelajari di Pertemuan 9.

## 5. Hasil Latihan dan Modifikasi
1. Menampilkan nama barang dengan huruf kapital (`UPPER`) dan ngerubah format harga barang jadi format uang lokal pakai fungsi `FORMAT(harga_jual_barang, 0, 'id_ID')`.
2. Menganalisis kesalahan semantik akibat lupa nambahin tanda kurung pas mengombinasikan operator `AND` dan `OR`. Kuerinya tetep jalan tanpa error dari server, tapi data yang keluar jadi salah dan nggak sesuai logika yang kita maksud.

## 6. Tugas Mandiri: Milestone Proyek 7 (TF Mart)
- **Tema Proyek:** Toko Daring / Minimarket **TF Mart** (`toko_066`).
- **Parameter Batas P:** $P = 4$.
- **Berkas Terkait:** `p07_kueri_toko_066_25430066.sql` (berisi 10 kueri satu tabel yang mencakup penggunaan `LIKE`, `BETWEEN`, `IN`, `IS NULL`, `CASE`, fungsi tanggal, dan fungsi string).

## 7. Kesimpulan
Melalui Modul 7 ini, saya jadi lebih paham cara "bertanya" ke database secara efektif pakai klausa `SELECT`. Penggunaan operator penyaringan dan fungsi skalar terbukti bikin sajian data jadi jauh lebih rapi, informatif, dan siap dipakai buat kebutuhan informasi toko **TF Mart**.

## 8. Pernyataan Penggunaan AI
Dalam pengerjaan laporan modul ini, bantuan AI (Gemini) dimanfaatkan secara interaktif buat membantu menstrukturkan skrip SQL, mengecek sintaks kueri, serta membantu menyusun draf laporan Markdown agar rapi dan terstruktur.

## 9. Bukti Git
- **Tautan Repositori:** `https://github.com/TamayaFerwanti/basisdata-25430066`
- **Commit Hash Pertemuan 7:** `p07_hash`

---

## Checklist
- [x] Berkas `p07_kueri_kopma_25430066.sql` & `p07_kueri_toko_066_25430066.sql` Terbuat
- [x] Berkas Laporan `Laporan/p07_laporan_25430066.md` Terbuat
- [x] Tangkapan Layar `p07_skenario_uji.png` & `p07_jumlah_baris.png` Terlampir