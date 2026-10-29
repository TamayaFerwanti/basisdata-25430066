-- ============================================================================
-- Berkas : p07_kueri_toko_066_25430066.sql
-- NAMA   : Tamaya Ferwanti (NPM: 25430066)
-- TEMA   : Toko Daring / Minimarket TF Mart (toko_066) - Modul 7
-- ============================================================================

USE toko_066;

-- ----------------------------------------------------------------------------
-- KI-01: Pencarian produk berdasarkan kategori menggunakan operator IN
-- Pertanyaan: Produk apa saja yang masuk dalam kategori Sembako atau Minuman?
-- Harapan: Menampilkan daftar produk sembako dan minuman beserta stoknya.
-- ----------------------------------------------------------------------------
SELECT kode_sku, nama_produk, kategori_produk, stok_produk 
FROM produk 
WHERE kategori_produk IN ('Sembako', 'Minuman');

-- ----------------------------------------------------------------------------
-- KI-02: Penyaringan produk dengan stok kritis menggunakan operator pembanding
-- Pertanyaan: Produk apa saja yang stoknya kurang dari atau sama dengan 10?
-- Harapan: Menampilkan produk yang memerlukan restock mendesak.
-- ----------------------------------------------------------------------------
SELECT kode_sku, nama_produk, stok_produk, stok_min_produk 
FROM produk 
WHERE stok_produk <= 10 
ORDER BY stok_produk ASC;

-- ----------------------------------------------------------------------------
-- KI-03: Pencarian nama produk dengan pola teks (LIKE)
-- Pertanyaan: Produk apa saja yang namanya mengandung kata 'Goreng'?
-- Harapan: Menampilkan produk seperti Minyak Goreng.
-- ----------------------------------------------------------------------------
SELECT kode_sku, nama_produk, harga_produk 
FROM produk 
WHERE nama_produk LIKE '%Goreng%';

-- ----------------------------------------------------------------------------
-- KI-04: Filter transaksi berdasarkan rentang tanggal (BETWEEN)
-- Pertanyaan: Pesanan apa saja yang masuk pada rentang tanggal 20 September 2026?
-- Harapan: Menampilkan daftar pesanan di tanggal tersebut.
-- ----------------------------------------------------------------------------
SELECT no_pesanan, tgl_pesanan, id_pelanggan, status_pesanan 
FROM pesanan 
WHERE tgl_pesanan BETWEEN '2026-09-20 00:00:00' AND '2026-09-20 23:59:59';

-- ----------------------------------------------------------------------------
-- KI-05: Pemeriksaan data kosong pada pelanggan (IS NULL)
-- Pertanyaan: Apakah ada pelanggan yang alamatnya belum tercatat/kosong?
-- Harapan: Menampilkan pelanggan dengan alamat NULL (jika ada).
-- ----------------------------------------------------------------------------
SELECT id_pelanggan, nama_pelanggan, email_pelanggan 
FROM pelanggan 
WHERE alamat_pelanggan IS NULL;

-- ----------------------------------------------------------------------------
-- KI-06: Penggunaan Fungsi String (CONCAT & UPPER)
-- Pertanyaan: Bagaimana format label identitas pelanggan dalam huruf kapital?
-- Harapan: Menampilkan nama dan email yang digabung dengan format khusus.
-- ----------------------------------------------------------------------------
SELECT UPPER(nama_pelanggan) AS nama_kapital, 
       CONCAT(email_pelanggan, ' - HP: ', no_hp_pelanggan) AS kontak_info 
FROM pelanggan;

-- ----------------------------------------------------------------------------
-- KI-07: Penggunaan Fungsi Tanggal (DATE_FORMAT & YEAR)
-- Pertanyaan: Kapan saja tanggal pesanan dilakukan dalam format lokal Indonesia?
-- Harapan: Menampilkan tanggal pesanan dengan format DD-MM-YYYY.
-- ----------------------------------------------------------------------------
SELECT no_pesanan, 
       DATE_FORMAT(tgl_pesanan, '%d-%m-%Y %H:%i') AS waktu_pesan_indo 
FROM pesanan 
LIMIT 10;

-- ----------------------------------------------------------------------------
-- KI-08: Penggunaan Kondisional CASE untuk Klasifikasi Harga Produk
-- Pertanyaan: Bagaimana pengelompokan produk berdasarkan kelas harganya?
-- Harapan: Menampilkan label 'Premium' atau 'Ekonomis' berdasarkan harga.
-- ----------------------------------------------------------------------------
SELECT nama_produk, harga_produk,
       CASE 
           WHEN harga_produk >= 50000 THEN 'Kelas Premium'
           ELSE 'Kelas Ekonomis'
       END AS kelas_harga
FROM produk;

-- ----------------------------------------------------------------------------
-- KI-09: Pembatasan hasil kueri dengan ORDER BY dan LIMIT
-- Pertanyaan: Apa 5 produk dengan harga termahal di TF Mart?
-- Harapan: Menampilkan 5 produk berharga tertinggi secara berurutan.
-- ----------------------------------------------------------------------------
SELECT nama_produk, kategori_produk, harga_produk 
FROM produk 
ORDER BY harga_produk DESC 
LIMIT 5;

-- ----------------------------------------------------------------------------
-- KI-10: Penggunaan DISTINCT untuk menyaring duplikasi kategori produk
-- Pertanyaan: Apa saja kategori unik produk yang tersedia di toko?
-- Harapan: Menampilkan daftar kategori tanpa ada nama kategori yang berulang.
-- ----------------------------------------------------------------------------
SELECT DISTINCT kategori_produk 
FROM produk;