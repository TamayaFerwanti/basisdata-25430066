-- ============================================================================
-- Berkas : install_uts_25430066.sql
-- NAMA   : Tamaya Ferwanti (NIM: 25430066)
-- KELAS  : C / S1 Ilmu Komputer
-- TEMA   : UTS Proyek Tahap 1 - TF Mart (toko_066)
-- ============================================================================

-- Hapus database lama jika ada, lalu buat baru
DROP DATABASE IF EXISTS toko_066;
CREATE DATABASE toko_066;
USE toko_066;

-- 1. Panggil Skrip DDL (Struktur Tabel & Relasi dari Modul 5)
-- Pastikan nama file menyesuaikan skrip DDL yang sudah dibuat di pertemuan sebelumnya
SOURCE p05_ddl_25430066.sql;

-- 2. Panggil Skrip DML (Data Sampel / Milestone 6)
SOURCE p06_data_25430066.sql;

-- Tampilkan informasi sukses
SELECT 'Instalasi Bersih UTS Proyek Tahap 1 Berhasil Dijalankan!' AS status_instalasi;