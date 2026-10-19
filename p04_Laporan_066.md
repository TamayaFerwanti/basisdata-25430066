# LAPORAN PRAKTIKUM BASIS DATA
## MODUL 4: NORMALISASI DAN SKEMA RELASIONAL

**Nama:** Tamaya Ferwanti  
**NIM:** 25430066  
**Kelas:** C  
**Program Studi:** Ilmu Komputer
**Mata Kuliah:** Praktikum Basis Data  
**Proyek Mandiri:** Toko Daring "TF Mart"  

---

## BAB 1: PENDAHULUAN

### 1.1 Latar Belakang
Di semester 3 ini, pada mata kuliah Basis Data, kita belajar bahwa merancang basis data tidak cuma sekadar membuat tabel dan memasukkan kolom. Saat pertama kali mendesain sistem e-commerce untuk toko daring **TF Mart**, data transaksi pesanan biasanya tersimpan dalam satu tabel besar yang menampung semua informasi sekaligus, mulai dari data pembeli, barang yang dibeli, pengiriman, sampai total pembayaran.

Tabel yang menggabungkan semua data seperti ini kelihatan praktis di awal, tapi sebenarnya menyimpan banyak masalah saat data mulai banyak. Penyimpanan data yang berulang-ulang (redundansi) membuat ukuran basis data membengkak dan memicu masalah penanganan data yang disebut anomali. Oleh karena itu, kita membutuhkan proses **Normalisasi**, yaitu teknik memecah tabel besar menjadi beberapa tabel kecil yang saling terhubung berdasarkan ketergantungan antar-kolomnya (Functional Dependency), agar basis data menjadi rapi, efisien, dan bebas dari error saat diolah.

---

### 1.2 Penjelasan Tiga Jenis Anomali Data
Jika sistem TF Mart tetap menggunakan satu tabel besar yang belum dinormalisasi, maka akan muncul 3 anomali utama:

1. **Anomali Ubah (Update Anomaly):**  
   Terjadi ketika ada perubahan data, tapi kita harus memperbaruinya di banyak baris sekaligus.  
   *Contoh pada TF Mart:* Jika pelanggan bernama "Budi" mengubah alamat pengirimannya, kita harus mengubah alamat di semua baris pesanan lama milik Budi. Jika ada satu baris yang terlewat, data alamat Budi menjadi tidak konsisten.

2. **Anomali Sisip (Insert Anomaly):**  
   Terjadi saat kita ingin memasukkan data baru, tetapi tidak bisa dilakukan karena ada data wajib lain yang belum ada.  
   *Contoh pada TF Mart:* Kita ingin menambahkan produk baru "Minyak Goreng 2L" ke sistem. Jika tabel belum dinormalisasi dan membutuhkan `id_pesanan` sebagai Primary Key, produk baru tersebut tidak bisa dimasukkan sebelum ada pembeli yang memesannya.

3. **Anomali Hapus (Delete Anomaly):**  
   Terjadi ketika kita menghapus suatu baris data, tetapi data penting lainnya yang sebenarnya masih dibutuhkan ikut terhapus secara tidak sengaja.  
   *Contoh pada TF Mart:* Jika pesanan `POS-101` dibatalkan dan kita menghapus baris transaksi tersebut, maka informasi data pelanggan baru atau data produk unik yang hanya ada di transaksi itu akan ikut terhapus dari sistem.

---

### 1.3 Tujuan Praktikum
Tujuan yang ingin dicapai dari pengerjaan Modul 4 ini adalah:
1. Memahami dan mengidentifikasi anomali ubah, sisip, dan hapus pada data tabel yang belum dinormalisasi.
2. Mampu membuat daftar Dependensi Fungsional (FD) yang diturunkan dari Aturan Bisnis (AB) sistem TF Mart.
3. Melakukan tahapan normalisasi bertahap dari UNF, 1NF, 2NF, hingga 3NF, serta memeriksa kelayakan BCNF.
4. Mengambil keputusan yang tepat mengenai penyimpanan nilai turunan (seperti subtotal dan total harga).
5. Menghasilkan skema relasional akhir yang bersih sebagai dasar pembuatan skrip SQL di modul selanjutnya.

---

## BAB 2: LANGKAH WORKFLOW & PROSES NORMALISASI

### 2.1 Bentuk Tidak Normal (UNF - Unnormalized Form)
Bentuk UNF menggambarkan kondisi data mentah pada struk atau nota pembayaran TF Mart di mana dalam satu kali pesanan terdapat grup berulang (pembelian beberapa produk sekaligus).

**Struktur UNF:**
```text
PESANAN_UNF (
    id_pesanan, tgl_pesanan, id_pelanggan, nama_pelanggan, no_hp_pelanggan, alamat_pelanggan,
    id_kurir, nama_kurir, no_resi, status_pesanan,
    { id_produk, kode_produk, nama_produk, kategori_produk, qty_pesanan, harga_satuan, subtotal_item },
    ongkir, total_bayar
)
```

---

### 2.2 Bentuk Normal Pertama (1NF - First Normal Form)
**Syarat 1NF:** Setiap sel/kolom harus bernilai atomik (tunggal) dan tidak ada lagi grup berulang.  
**Langkah:** Kelompok berulang dipecah sehingga setiap produk dalam pesanan memiliki baris tersendiri. Kunci Primer (Primary Key) yang terbentuk adalah Kunci Komposit gabungan `(id_pesanan, id_produk)`.

**Struktur 1NF:**
```text
PESANAN_1NF (
    id_pesanan*, id_produk*, tgl_pesanan, id_pelanggan, nama_pelanggan, no_hp_pelanggan, alamat_pelanggan,
    id_kurir, nama_kurir, no_resi, status_pesanan, kode_produk, nama_produk, kategori_produk,
    qty_pesanan, harga_satuan, subtotal_item, ongkir, total_bayar
)
```
*(Catatan: `*` menandakan bagian dari Composite Primary Key)*

---

### 2.3 Daftar Dependensi Fungsional (Functional Dependency / FD)
Dependensi Fungsional disusun berdasarkan Aturan Bisnis (AB) toko daring TF Mart, bukan dikira-kira dari contoh isi tabel:

* **FD1 (Aturan Bisnis Pesanan):**  
  `id_pesanan -> tgl_pesanan, id_pelanggan, id_kurir, no_resi, status_pesanan, ongkir`  
  *(Satu ID pesanan menentukan tanggal, siapa pembelinya, kurirnya, no resi, status, dan ongkir)*

* **FD2 (Aturan Bisnis Pelanggan):**  
  `id_pelanggan -> nama_pelanggan, no_hp_pelanggan, alamat_pelanggan`  
  *(Satu ID pelanggan menentukan nama, nomor HP, dan alamatnya)*

* **FD3 (Aturan Bisnis Kurir):**  
  `id_kurir -> nama_kurir`  
  *(Satu ID kurir menentukan nama jasa ekspedisinya)*

* **FD4 (Aturan Bisnis Produk):**  
  `id_produk -> kode_produk, nama_produk, kategori_produk, harga_satuan`  
  *(Satu ID produk menentukan kode, nama, kategori, dan harga produk)*

* **FD5 (Aturan Bisnis Detail Transaksi):**  
  `(id_pesanan, id_produk) -> qty_pesanan`  
  *(Gabungan ID pesanan dan ID produk menentukan berapa jumlah barang yang dibeli)*

* **FD6 (Ketergantungan Turunan):**  
  `(qty_pesanan, harga_satuan) -> subtotal_item`  
  *(Subtotal merupakan hasil perkalian kuantitas dan harga satuan)*

---

### 2.4 Bentuk Normal Kedua (2NF - Second Normal Form)
**Syarat 2NF:** Sudah memenuhi 1NF dan tidak ada lagi **Ketergantungan Parsial** (yaitu atribut bukan kunci yang hanya bergantung pada sebagian kunci komposit).

**Analisis:**  
Atribut seperti `nama_produk` hanya bergantung pada `id_produk`, bukan pada `id_pesanan`. Sementara `tgl_pesanan` hanya bergantung pada `id_pesanan`. Maka tabel dipisah berdasarkan dependensinya:

1. **TABEL_PELANGGAN_2NF** (`id_pelanggan`, nama_pelanggan, no_hp_pelanggan, alamat_pelanggan)
2. **TABEL_KURIR_2NF** (`id_kurir`, nama_kurir)
3. **TABEL_PRODUK_2NF** (`id_produk`, kode_produk, nama_produk, kategori_produk, harga_satuan)
4. **TABEL_PESANAN_2NF** (`id_pesanan`, tgl_pesanan, id_pelanggan, id_kurir, no_resi, status_pesanan, ongkir, total_bayar)
5. **TABEL_DETAIL_PESANAN_2NF** (`id_pesanan`*, `id_produk`*, qty_pesanan, harga_satuan, subtotal_item)

---

### 2.5 Bentuk Normal Ketiga (3NF) & BCNF (Boyce-Codd Normal Form)
**Syarat 3NF:** Sudah memenuhi 2NF dan tidak ada lagi **Ketergantungan Transitif** (rantai antar-kolom yang bukan merupakan kunci primer).

**Syarat BCNF:** Setiap penentu (*determinant*) pada ketergantungan fungsional harus merupakan Super Key / Candidate Key.

**Hasil Normalisasi Akhir (3NF / BCNF):**

1. **PELANGGAN** (`id_pelanggan`, nama_pelanggan, no_hp_pelanggan, alamat_pelanggan)
2. **KURIR** (`id_kurir`, nama_kurir)
3. **PRODUK** (`id_produk`, kode_produk, nama_produk, kategori_produk, harga_produk, stok_produk)
4. **PESANAN** (`id_pesanan`, no_pesanan, tgl_pesanan, `id_pelanggan`*, `id_kurir`*, no_resi, status_pesanan, ongkir)
5. **DETAIL_PESANAN** (`id_pesanan`*, `id_produk`*, qty_pesanan, harga_saat_beli)

*(Keterangan: Garis bawah = Primary Key, `*` = Foreign Key)*

---

## BAB 3: ANALISIS DAN KEPUTUSAN NILAI TURUNAN

### 3.1 Keputusan Penanganan Nilai Turunan (Derived Attributes)
Pada dokumen transaksi awal, terdapat atribut turunan seperti `subtotal_item` ($qty \times harga$) dan `total_bayar` ($\sum subtotal + ongkir$).

**Keputusan untuk TF Mart:**
Atribut `subtotal_item` dan `total_bayar` **TIDAK DISIMPAN** secara permanen di dalam tabel operasional utama basis data.

**Alasan / Analisis Logis:**
1. **Mencegah Anomali Ubah:** Jika harga barang atau kuantitas diubah, nilai total akan berisiko salah jika tidak ikut ter-update secara otomatis.
2. **Prinsip Efisiensi Storage:** Memulai desain yang baik berarti menghindari penyimpanan data yang redundan. Nilai turunan dapat dengan mudah dihitung secara langsung (*on-the-fly*) saat aplikasi running menggunakan perintah SQL seperti `SUM(qty_pesanan * harga_saat_beli)`.
3. **Menjaga Integritas Historis:** Kita tetap menyimpan kolom `harga_saat_beli` pada tabel `DETAIL_PESANAN` untuk mencatat harga riil saat transaksi terjadi, sehingga jika harga produk di tabel `PRODUK` naik di masa depan, perhitungan historis pesanan lama tidak ikut berubah.

---

## BAB 4: KESIMPULAN & CHECKLIST

### 4.1 Kesimpulan
Melalui pengerjaan Modul 4 ini, rancangan basis data untuk Toko Daring **TF Mart** yang tadinya berupa satu tabel besar tidak teratur telah berhasil dinormalisasi hingga tahap 3NF/BCNF. Hasilnya terdiri dari 5 tabel terpisah yang saling terhubung melalui Foreign Key. Dengan struktur ini, basis data TF Mart dijamin bebas dari anomali ubah, sisip, maupun hapus, serta siap untuk dibuatkan skrip DDL SQL pada praktikum berikutnya.

### 4.2 Checklist Kelengkapan Laporan

| No | Komponen Checklist | Status | Keterangan |
|---|---|---|---|
| 1 | Berkas `p04_normalisasi_25430066.md` | Ada | Dokumentasi teknis proyek mandiri |
| 2 | Tahapan Normalisasi (UNF - 3NF) | Lengkap | Runtut dari UNF, 1NF, 2NF, hingga 3NF |
| 3 | Daftar Dependensi Fungsional (FD) | Ada | Berdasarkan Aturan Bisnis (AB) TF Mart |
| 4 | Keputusan Nilai Turunan | Ada | Disertai alasan logis tidak menyimpan total |
| 5 | Pemeriksaan BCNF | Selesai | Seluruh determinant adalah Candidate Key |

---

### 4.3 Eksekusi Perintah Git Commit
Setelah berkas laporan ini disimpan di dalam folder `laporan/p04_laporan_25430066.md`, langkah terakhir adalah melakukan commit dan push ke repositori GitHub dengan menjalankan perintah berikut di terminal VS Code:


```bash
git add .
git commit -m "p04: normalisasi toko daring tf mart"
git push origin main

Link GitHub https://github.com/TamayaFerwanti/basisdata-25430066/edit/main/p04_Laporan_066.md
Commit ba8d4a7

```
