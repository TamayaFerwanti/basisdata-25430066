-- ============================================================================
-- Berkas : p09_agregasi_kopma_25430066.sql
-- NAMA   : Tamaya Ferwanti (NIM: 25430066)
-- KELAS  : C / S1 Ilmu Komputer
-- MODUL  : 9 (Fungsi Agregat dan GROUP BY)
-- ============================================================================

-- 1. Cek jumlah nota dan rentang tanggal pada data lanjutan Kopma
-- Harapan: 75 nota, dari 2026-09-02 sampai 2026-10-31
SELECT COUNT(*) AS nota,
       MIN(tgl_penjualan) AS awal,
       MAX(tgl_penjualan) AS akhir
FROM penjualan;

-- 2. Total satu nota (menjawab pertanyaan tertunda dari Modul 7)
-- Harapan: menampilkan total nilai satu nota berdasarkan penjumlahan detailnya
SELECT p.no_nota_penjualan,
       SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS jumlah
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
WHERE p.no_nota_penjualan = 'PJ-2609-0001'
GROUP BY p.id_penjualan, p.no_nota_penjualan;

-- 3. KI-01: Laporan omzet harian minggu pertama September dengan WITH ROLLUP
-- Harapan: rincian per tanggal pada 2026-09-01 s.d. 2026-09-07 + baris total NULL
SELECT DATE(p.tgl_penjualan) AS tanggal,
       COUNT(DISTINCT p.id_penjualan) AS nota,
       SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS omzet
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
WHERE p.tgl_penjualan >= '2026-09-01' AND p.tgl_penjualan < '2026-09-08'
GROUP BY DATE(p.tgl_penjualan) WITH ROLLUP;

-- 4. KI-01: Laporan omzet bulanan dengan WITH ROLLUP
-- Harapan: September (39 nota, Rp691.000) dan Oktober (36 nota, Rp507.500) + total
SELECT DATE_FORMAT(p.tgl_penjualan, '%Y-%m') AS bulan,
       COUNT(DISTINCT p.id_penjualan) AS nota,
       SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS omzet
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
GROUP BY DATE_FORMAT(p.tgl_penjualan, '%Y-%m') WITH ROLLUP;

-- 5. Menyaring kelompok dengan HAVING: petugas yang melayani > 20 nota
-- Harapan: hanya menampilkan petugas dengan jumlah nota lebih dari 20
SELECT pt.kode_petugas,
       pt.nama_petugas,
       COUNT(*) AS nota
FROM penjualan p
JOIN petugas pt ON pt.id_petugas = p.id_petugas
GROUP BY pt.id_petugas, pt.kode_petugas, pt.nama_petugas
HAVING COUNT(*) > 20;

-- 6. Menyaring kelompok barang yang total qty terjualnya < 10
-- Harapan: hanya menampilkan barang dengan total kuantitas terjual kurang dari 10
SELECT b.kode_barang,
       b.nama_barang,
       SUM(d.qty_detail_penjualan) AS total_qty
FROM detail_penjualan d
JOIN barang b ON b.id_barang = d.id_barang
GROUP BY b.id_barang, b.kode_barang, b.nama_barang
HAVING SUM(d.qty_detail_penjualan) < 10;