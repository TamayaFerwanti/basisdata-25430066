# Dokumentasi Normalisasi Studi Kasus Kopma
**Nama:** Tamaya Ferwanti  
**NIM:** 25430066  
**Kelas:** C 

---

## 1. Bentuk Tidak Normal (UNF) - Kopma
NOTA_UNF (no_nota_penjualan, tgl_penjualan, kode_petugas, nama_petugas, no_anggota, nama_anggota, { kode_barang, nama_barang, qty_detail_penjualan, harga_satuan_detail_penjualan, subtotal_detail_penjualan }, jumlah_penjualan, diskon_penjualan, total_penjualan)[cite: 164]

## 2. Bentuk Normal Pertama (1NF) - Kopma
NOTA_1NF (no_nota_penjualan, kode_barang, tgl_penjualan, kode_petugas, nama_petugas, no_anggota, nama_anggota, nama_barang, qty_detail_penjualan, harga_satuan_detail_penjualan, subtotal_detail_penjualan, jumlah_penjualan, diskon_penjualan, total_penjualan)[cite: 164]

## 3. Dependensi Fungsional (FD) - Kopma
* FD1: `no_nota_penjualan -> tgl_penjualan, kode_petugas, no_anggota` (AB-01)[cite: 164]
* FD2: `kode_petugas -> nama_petugas`[cite: 164]
* FD3: `no_anggota -> nama_anggota` (AB-05)[cite: 164]
* FD4: `kode_barang -> nama_barang`[cite: 164]
* FD5: `(no_nota_penjualan, kode_barang) -> qty_detail_penjualan, harga_satuan_detail_penjualan` (AB-04)[cite: 165]
* FD6: `qty_detail_penjualan, harga_satuan_detail_penjualan -> subtotal_detail_penjualan` (turunan)[cite: 165]

## 4. Tahapan 2NF & 3NF
* **2NF:** Memisahkan atribut yang bergantung pada sebagian kunci komposit ke relasi `penjualan` dan `barang`[cite: 165].
* **3NF:** Memisahkan rantai atribut bukan kunci (`petugas` dan `anggota`) ke relasi mandiri[cite: 165].

## 5. Skema Kanonik Akhir (3NF) Kopma
1. **PETUGAS** (`id_petugas`, `kode_petugas`, nama_petugas, peran_petugas)[cite: 165]
2. **ANGGOTA** (`id_anggota`, `no_anggota`, `nim_anggota`, nama_anggota, ...)[cite: 165]
3. **BARANG** (`id_barang`, `kode_barang`, nama_barang, kategori_barang, ...)[cite: 165]
4. **PENJUALAN** (`id_penjualan`, `no_nota_penjualan`, tgl_penjualan, id_petugas*, id_anggota*, ...)[cite: 165, 166]
5. **DETAIL_PENJUALAN** (`id_penjualan`*, `id_barang`*, qty_detail_penjualan, harga_satuan_detail_penjualan)[cite: 165, 166]