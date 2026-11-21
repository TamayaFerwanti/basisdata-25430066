-- ============================================================================
-- Berkas : p09_agregasi_25430066.sql
-- NAMA   : Tamaya Ferwanti (NIM: 25430066)
-- TEMA   : TF Mart (toko_066) - Milestone Proyek 9 (Parameter P = 4)
-- ============================================================================

USE toko_066;

-- KI-01: Laporan jumlah pesanan dan omzet produk per tanggal dengan WITH ROLLUP
-- Pertanyaan: Berapa jumlah pesanan dan total nilai item terjual tiap tanggal beserta totalnya?
-- Harapan: 3 kelompok tanggal (2026-09-20, 2026-09-22, 2026-09-25) + 1 baris total NULL
SELECT DATE(p.tgl_pesanan) AS tanggal_pesan,
       COUNT(DISTINCT p.id_pesanan) AS jumlah_pesanan,
       SUM(d.qty_pesanan * d.harga_saat_beli) AS omzet_item
FROM pesanan p
JOIN detail_pesanan d ON d.id_pesanan = p.id_pesanan
GROUP BY DATE(p.tgl_pesanan) WITH ROLLUP;

-- KI-02: Laporan statistik stok dan rata-rata harga per kategori produk
-- Pertanyaan: Bagaimana ringkasan jumlah produk, rata-rata harga, dan stok tertinggi tiap kategori?
-- Harapan: muncul ringkasan per kategori produk (Sembako dan Minuman)
SELECT kategori_produk,
       COUNT(*) AS jumlah_produk,
       ROUND(AVG(harga_produk), 0) AS rata_rata_harga,
       MAX(stok_produk) AS stok_terbanyak
FROM produk
GROUP BY kategori_produk;

-- KI-03: Penyaringan kategori dengan total stok di atas parameter P (HAVING)
-- Pertanyaan: Kategori produk apa saja yang total stoknya melebihi batas parameter P=4?
-- Harapan: menampilkan kategori yang SUM(stok_produk) > 4
SELECT kategori_produk,
       SUM(stok_produk) AS total_stok
FROM produk
GROUP BY kategori_produk
HAVING SUM(stok_produk) > 4;

-- KI-04: Laporan frekuensi transaksi dan nilai item per pelanggan
-- Pertanyaan: Berapa kali tiap pelanggan bertransaksi dan berapa nilai transaksi terkecil/terbesarnya?
-- Harapan: muncul daftar pelanggan beserta jumlah pesanan, MIN, dan MAX nilai item
SELECT p.id_pelanggan,
       COUNT(DISTINCT p.id_pesanan) AS total_pesanan,
       MIN(d.qty_pesanan * d.harga_saat_beli) AS nilai_terkecil,
       MAX(d.qty_pesanan * d.harga_saat_beli) AS nilai_terbesar
FROM pesanan p
JOIN detail_pesanan d ON d.id_pesanan = p.id_pesanan
GROUP BY p.id_pelanggan;

-- KI-05: Penyaringan pelanggan dengan jumlah pesanan minimal tertentu (HAVING)
-- Pertanyaan: Pelanggan mana saja yang memiliki minimal 5 pesanan dengan total nilai item di atas 0?
-- Harapan: menampilkan pelanggan yang memenuhi syarat HAVING
SELECT p.id_pelanggan,
       COUNT(DISTINCT p.id_pesanan) AS jumlah_pesanan,
       SUM(d.qty_pesanan * d.harga_saat_beli) AS total_nilai_item
FROM pesanan p
JOIN detail_pesanan d ON d.id_pesanan = p.id_pesanan
GROUP BY p.id_pelanggan
HAVING COUNT(DISTINCT p.id_pesanan) >= 5 AND SUM(d.qty_pesanan * d.harga_saat_beli) > 0;