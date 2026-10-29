-- ============================================================================
-- Berkas : p07_kueri_kopma_25430066.sql
-- NAMA   : Tamaya Ferwanti (NIM: 25430066)
-- KELAS  : C / S1 Ilmu Komputer
-- MODUL  : 7 (SELECT dan Fungsi Skalar)
-- ============================================================================

USE kopma_066;

-- 1. KI-03: Barang di bawah stok minimum (Proyeksi, Alias, ORDER BY)
SELECT kode_barang, nama_barang, stok_barang, stok_min_barang, 
       (stok_min_barang - stok_barang) AS kurang
FROM barang 
WHERE stok_barang < stok_min_barang 
ORDER BY kurang DESC;

-- 2. Penyaringan dengan IN, BETWEEN, dan IS NULL
-- A. Barang kategori ATK atau Minuman (IN)
SELECT kode_barang, nama_barang, kategori_barang 
FROM barang 
WHERE kategori_barang IN ('ATK', 'Minuman');

-- B. Anggota yang mendaftar pada rentang tanggal tertentu (BETWEEN)
SELECT id_anggota, nama_anggota, tgl_daftar_anggota 
FROM anggota 
WHERE tgl_daftar_anggota BETWEEN '2026-01-01' AND '2026-09-30';

-- C. Anggota tanpa nomor HP (IS NULL)
SELECT id_anggota, nama_anggota, no_hp_anggota 
FROM anggota 
WHERE no_hp_anggota IS NULL;

-- 3. Fungsi Skalar String, Tanggal, dan Kondisional (CASE & IFNULL)
SELECT CONCAT(nama_anggota, ' (', no_anggota, ')') AS anggota,
       DATE_FORMAT(tgl_daftar_anggota, '%d-%m-%Y') AS tgl_daftar,
       IFNULL(no_hp_anggota, '-') AS hp,
       CASE status_anggota 
            WHEN 'aktif' THEN 'Diskon 5%'
            ELSE 'Tanpa diskon' 
       END AS keterangan
FROM anggota
WHERE nama_anggota LIKE '%a%'
ORDER BY tgl_daftar_anggota DESC
LIMIT 5;

-- 4. Perhitungan Tanggal per Baris (Lama Keanggotaan)
SELECT nama_anggota, 
       DATEDIFF(CURDATE(), tgl_daftar_anggota) AS umur_hari,
       IF(DATEDIFF(CURDATE(), tgl_daftar_anggota) < 180, 'baru', 'lama') AS kategori_keanggotaan
FROM anggota;

-- 5. Perhitungan Subtotal per Baris Detail Penjualan (Contoh Nota PJ-2609-0142)
-- Catatan: Sesuaikan ID/No nota dengan data riil di database Anda
SELECT id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan,
       (qty_detail_penjualan * harga_satuan_detail_penjualan) AS subtotal
FROM detail_penjualan
WHERE id_penjualan = 1;