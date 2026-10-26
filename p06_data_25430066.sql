-- ============================================================================
-- Berkas : p06_data_25430066.sql
-- NAMA   : Tamaya Ferwanti (NIM: 25430066)
-- TEMA   : Toko Daring / TF Mart (toko_066) - Modul 6 (Milestone DML)
-- ============================================================================

USE toko_066;

-- Nonaktifkan sementara pemeriksaan key untuk mempercepat eksekusi
SET FOREIGN_KEY_CHECKS = 0;

-- 1. Mengisi Data Master Pelanggan
INSERT INTO pelanggan (nama_pelanggan, email_pelanggan, no_hp_pelanggan, alamat_pelanggan) VALUES
('Tamaya Ferwanti', 'tamaya@gmail.com', '081234567890', 'Metro Pusat'),
('Budi Santoso', 'budi@gmail.com', '081299990000', 'Metro Timur'),
('Siti Aminah', 'siti@gmail.com', '087788990011', 'Metro Barat'),
('Andi Pratama', 'andi@gmail.com', '085211223344', 'Batanghari'),
('Dewi Lestari', 'dewi@gmail.com', '081122334455', 'Raman Fajar');

-- 2. Mengisi Data Master Kurir
INSERT INTO kurir (nama_kurir, layanan_kurir) VALUES
('JNE', 'Reguler'),
('J&T', 'Express'),
('SiCepat', 'HALU');

-- 3. Mengisi Data Master Produk
INSERT INTO produk (kode_sku, nama_produk, kategori_produk, harga_produk, stok_produk, stok_min_produk) VALUES
('SKU-001', 'Minyak Goreng 2L', 'Sembako', 35000, 50, 4),
('SKU-002', 'Beras Premium 5kg', 'Sembako', 65000, 30, 4),
('SKU-003', 'Gula Pasir 1kg', 'Sembako', 16000, 40, 4),
('SKU-004', 'Telur Ayam 1kg', 'Sembako', 28000, 25, 4),
('SKU-005', 'Teh Celup Melati', 'Minuman', 8000, 60, 4);

-- 4. Mengisi Pesanan (Tanggal 2026-09-20)
INSERT INTO pesanan (no_pesanan, tgl_pesanan, id_pelanggan, id_kurir, status_pesanan, ongkir) VALUES
('ORD-2609-001', '2026-09-20 09:00:00', 1, 1, 'selesai', 10000),
('ORD-2609-002', '2026-09-20 10:30:00', 2, 2, 'selesai', 12000),
('ORD-2609-003', '2026-09-20 13:15:00', 3, 3, 'selesai', 9000),
('ORD-2609-004', '2026-09-20 15:45:00', 4, 1, 'selesai', 10000),
('ORD-2609-005', '2026-09-20 17:00:00', 5, 2, 'selesai', 12000),
('ORD-2609-006', '2026-09-20 18:20:00', 1, 3, 'selesai', 9000),
('ORD-2609-007', '2026-09-20 19:10:00', 2, 1, 'selesai', 10000),
('ORD-2609-008', '2026-09-20 20:00:00', 3, 2, 'selesai', 12000),
('ORD-2609-009', '2026-09-20 20:45:00', 4, 3, 'selesai', 9000),
('ORD-2609-010', '2026-09-20 21:30:00', 5, 1, 'selesai', 10000);

-- Mengisi Pesanan (Tanggal 2026-09-22)
INSERT INTO pesanan (no_pesanan, tgl_pesanan, id_pelanggan, id_kurir, status_pesanan, ongkir) VALUES
('ORD-2609-011', '2026-09-22 08:30:00', 1, 2, 'selesai', 12000),
('ORD-2609-012', '2026-09-22 09:45:00', 2, 3, 'selesai', 9000),
('ORD-2609-013', '2026-09-22 11:00:00', 3, 1, 'selesai', 10000),
('ORD-2609-014', '2026-09-22 13:20:00', 4, 2, 'selesai', 12000),
('ORD-2609-015', '2026-09-22 14:50:00', 5, 3, 'selesai', 9000),
('ORD-2609-016', '2026-09-22 16:10:00', 1, 1, 'selesai', 10000),
('ORD-2609-017', '2026-09-22 17:30:00', 2, 2, 'selesai', 12000),
('ORD-2609-018', '2026-09-22 19:00:00', 3, 3, 'selesai', 9000),
('ORD-2609-019', '2026-09-22 20:15:00', 4, 1, 'selesai', 10000),
('ORD-2609-020', '2026-09-22 21:00:00', 5, 2, 'selesai', 12000);

-- Mengisi Pesanan (Tanggal 2026-09-25)
INSERT INTO pesanan (no_pesanan, tgl_pesanan, id_pelanggan, id_kurir, status_pesanan, ongkir) VALUES
('ORD-2609-021', '2026-09-25 08:00:00', 1, 3, 'selesai', 9000),
('ORD-2609-022', '2026-09-25 09:15:00', 2, 1, 'selesai', 10000),
('ORD-2609-023', '2026-09-25 10:30:00', 3, 2, 'selesai', 12000),
('ORD-2609-024', '2026-09-25 11:45:00', 4, 3, 'selesai', 9000),
('ORD-2609-025', '2026-09-25 13:00:00', 5, 1, 'selesai', 10000),
('ORD-2609-026', '2026-09-25 14:20:00', 1, 2, 'selesai', 12000),
('ORD-2609-027', '2026-09-25 15:40:00', 2, 3, 'selesai', 9000),
('ORD-2609-028', '2026-09-25 17:00:00', 3, 1, 'selesai', 10000),
('ORD-2609-029', '2026-09-25 18:30:00', 4, 2, 'selesai', 12000),
('ORD-2609-030', '2026-09-25 20:00:00', 5, 3, 'selesai', 9000),
('ORD-2609-031', '2026-09-25 20:30:00', 1, 1, 'selesai', 10000),
('ORD-2609-032', '2026-09-25 21:00:00', 2, 2, 'selesai', 12000),
('ORD-2609-033', '2026-09-25 21:15:00', 3, 3, 'selesai', 9000),
('ORD-2609-034', '2026-09-25 21:30:00', 4, 1, 'selesai', 10000),
('ORD-2609-035', '2026-09-25 21:45:00', 5, 2, 'selesai', 12000),
('ORD-2609-036', '2026-09-25 22:00:00', 1, 3, 'selesai', 9000),
('ORD-2609-037', '2026-09-25 22:15:00', 2, 1, 'selesai', 10000),
('ORD-2609-038', '2026-09-25 22:30:00', 3, 2, 'selesai', 12000),
('ORD-2609-039', '2026-09-25 22:45:00', 4, 3, 'selesai', 9000),
('ORD-2609-040', '2026-09-25 23:00:00', 5, 1, 'selesai', 10000);

-- Mengisi Detail Pesanan
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_saat_beli)
SELECT id_pesanan, 1, 2, 35000 FROM pesanan;

-- Aktifkan kembali pemeriksaan key
SET FOREIGN_KEY_CHECKS = 1;