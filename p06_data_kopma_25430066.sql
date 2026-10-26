-- ============================================================================
-- Berkas : p06_data_kopma_25430066.sql
-- NAMA   : Tamaya Ferwanti (NIM: 25430066)
-- TOPIK  : Pengisian Data dan DML Kopma_066 - Modul 6
-- ============================================================================

USE kopma_066;

-- 1. Mengisi Data Induk (Petugas, Anggota, Barang, Pemasok)
INSERT INTO petugas (kode_petugas, nama_petugas, peran_petugas) VALUES
('K01', 'Dimas', 'kasir'), 
('K02', 'Sari', 'kasir'),
('K03', 'Rina', 'kasir'),
('G01', 'Joko', 'gudang'), 
('P01', 'Ketua Kopma', 'ketua');

INSERT INTO anggota (no_anggota, nim_anggota, nama_anggota, prodi_anggota, no_hp_anggota, status_anggota, tgl_daftar_anggota) VALUES
('A-0457', '25430066', 'Tamaya Ferwanti', 'Ilmu Komputer', '081234567890', 'aktif', '2025-01-15'),
('A-0458', '25430067', 'Budi Santoso', 'Sistem Informasi', '081299990000', 'aktif', '2025-02-20'),
('A-0459', '25430068', 'Siti Aminah', 'Teknik Informatika', NULL, 'nonaktif', '2024-05-10');

INSERT INTO barang (kode_barang, nama_barang, kategori_barang, harga_jual_barang, stok_barang, stok_min_barang) VALUES
('ATK-001', 'Pulpen Gel 0.5', 'ATK', 4000, 120, 20),
('ATK-002', 'Buku Tulis 58', 'ATK', 6500, 80, 20),
('MNM-001', 'Air Mineral 600', 'minuman', 4000, 48, 24),
('MKN-001', 'Roti Cokelat', 'makanan', 5000, 6, 10);

INSERT INTO pemasok (nama_pemasok, telepon_pemasok, alamat_pemasok) VALUES
('PT Sumber ATK Jaya', '0725112233', 'Metro Pusat'),
('CV Makanan Berkah', '0725445566', 'Lampung Timur');

-- 2. Mencatat Nota Penjualan Contoh (PJ-2609-0142) & Mengurangi Stok
INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0142', '2026-09-24 10:15:00', 3, 1, 30000);

INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT 1, id_barang, 3, harga_jual_barang FROM barang WHERE kode_barang = 'ATK-001';

UPDATE barang SET stok_barang = stok_barang - 3 WHERE kode_barang = 'ATK-001';