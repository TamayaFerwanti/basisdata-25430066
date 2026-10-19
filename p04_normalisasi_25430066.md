# Dokumentasi Normalisasi dan Skema Relasional: Toko Daring
**Nama:** Tamaya Ferwanti  
**NIM:** 25430066  
**Kelas:** C   
**Mata Kuliah:** Praktikum Basis Data  

---

## 1. Bentuk Tidak Normal (UNF - Unnormalized Form)
Dokumen sumber transaksi pesanan dari proyek Toko Daring memuat kelompok berulang pada daftar produk yang dibeli dalam satu kali *checkout*[cite: 166]:

PESANAN_UNF (id_pesanan, tgl_pesanan, id_pelanggan, nama_pelanggan, alamat_pelanggan, id_kurir, nama_kurir, no_resi, status_pesanan, { kode_produk, nama_produk, kategori_produk, qty_pesanan, harga_satuan_produk, subtotal_item }, ongkir, total_bayar)

---

## 2. Bentuk Normal Pertama (1NF)
Menghilangkan kelompok berulang dengan memastikan setiap sel bernilai atomik (tunggal). Kunci primer menjadi kunci komposit gabungan nomor pesanan dan kode produk[cite: 164, 166]:

PESANAN_1NF (id_pesanan, kode_produk, tgl_pesanan, id_pelanggan, nama_pelanggan, alamat_pelanggan, id_kurir, nama_kurir, no_resi, status_pesanan, nama_produk, kategori_produk, qty_pesanan, harga_satuan_produk, subtotal_item, ongkir, total_bayar)

---

## 3. Dependensi Fungsional (Functional Dependency)
Dependensi diturunkan langsung dari aturan bisnis (AB) proyek Toko Daring[cite: 160, 166]:
* **FD1:** `id_pesanan -> tgl_pesanan, id_pelanggan, id_kurir, no_resi, status_pesanan, ongkir` (Berdasarkan AB Pesanan)
* **FD2:** `id_pelanggan -> nama_pelanggan, alamat_pelanggan` (Berdasarkan AB Pelanggan)
* **FD3:** `id_kurir -> nama_kurir` (Berdasarkan AB Kurir)
* **FD4:** `kode_produk -> nama_produk, kategori_produk, harga_satuan_produk` (Berdasarkan AB Produk)
* **FD5:** `(id_pesanan, kode_produk) -> qty_pesanan, harga_satuan_produk, subtotal_item` (Atribut detail transaksi per item)

---

## 4. Bentuk Normal Kedua (2NF) & Ketiga (3NF)
* **2NF:** Memisahkan atribut yang bergantung secara parsial pada sebagian kunci komposit ke tabel terpisah (`pelanggan`, `kurir`, `produk`, dan `penjualan`)[cite: 165].
* **3NF:** Menghilangkan ketergantungan transitif (rantai antar atribut bukan kunci). Relasi akhir dipecah menjadi entitas mandiri yang bersih dari anomali[cite: 165, 166].

---

## 5. Keputusan Nilai Turunan
* **Atribut `subtotal_item` dan `total_bayar`:** Diputuskan untuk **tidak disimpan** di dalam tabel operasional utama untuk mencegah inkonsistensi data jika terjadi perubahan harga atau kuantitas, melainkan dihitung secara dinamis saat kueri atau aplikasi berjalan[cite: 165].

---

## 6. Skema Relasional Akhir (3NF)
Berikut adalah daftar tabel hasil normalisasi akhir (garis bawah = *Primary Key*, tanda bintang = *Foreign Key*)[cite: 165]:
1. **PELANGGAN** (`id_pelanggan`, nama_pelanggan, alamat_pelanggan, no_hp_pelanggan)
2. **KURIR** (`id_kurir`, nama_kurir, layanan_kurir)
3. **PRODUK** (`id_produk`, `kode_produk`, nama_produk, kategori_produk, harga_produk, stok_produk)
4. **PESANAN** (`id_pesanan`, no_pesanan, tgl_pesanan, `id_pelanggan`*, `id_kurir`*, status_pesanan, ongkir)
5. **DETAIL_PESANAN** (`id_pesanan`*, `id_produk`*, qty_pesanan, harga_saat_beli)

---

## 7. Pembaruan ERD
ERD proyek Toko Daring telah disesuaikan dengan struktur relasi 3NF di atas, di mana tabel transaksi dipecah menjadi relasi master-detail (`pesanan` dan `detail_pesanan`) dengan relasi *One-to-Many* terhadap entitas `pelanggan`, `kurir`, dan `produk`[cite: 166].