-- ============================================================================
-- Berkas : p05_ddl_25430062.sql
-- NAMA   : Tamaya Ferwanti (NIM: 25430066)
-- TEMA   : Toko Daring (TF mart / toko_066) - Modul 5
-- ============================================================================

USE toko_066;

-- Urutan DROP TABLE terbalik untuk proyek mandiri
DROP TABLE IF EXISTS detail_pesanan;
DROP TABLE IF EXISTS pesanan;
DROP TABLE IF EXISTS produk;
DROP TABLE IF EXISTS kurir;
DROP TABLE IF EXISTS pelanggan;

-- 1. Tabel Pelanggan (Master Pelanggan)
CREATE TABLE pelanggan (
    id_pelanggan INT NOT NULL AUTO_INCREMENT,
    nama_pelanggan VARCHAR(100) NOT NULL,
    email_pelanggan VARCHAR(100) NOT NULL,
    no_hp_pelanggan VARCHAR(20) NULL,
    alamat_pelanggan TEXT NOT NULL,
    PRIMARY KEY (id_pelanggan),
    CONSTRAINT uq_pelanggan_email UNIQUE KEY (email_pelanggan)
) ENGINE=InnoDB;

-- 2. Tabel Kurir (Master Kurir Ekspedisi)
CREATE TABLE kurir (
    id_kurir SMALLINT NOT NULL AUTO_INCREMENT,
    nama_kurir VARCHAR(50) NOT NULL,
    layanan_kurir VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_kurir)
) ENGINE=InnoDB;

-- 3. Tabel Produk (Master Produk Toko Daring dengan Parameter P = 9)
CREATE TABLE produk (
    id_produk INT NOT NULL AUTO_INCREMENT,
    kode_sku VARCHAR(20) NOT NULL,
    nama_produk VARCHAR(150) NOT NULL,
    kategori_produk VARCHAR(50) NOT NULL,
    harga_produk DECIMAL(12,2) NOT NULL,
    stok_produk INT NOT NULL DEFAULT 0,
    stok_min_produk INT NOT NULL DEFAULT 9, -- Batas parameter P+2 (9)
    PRIMARY KEY (id_produk),
    CONSTRAINT uq_produk_sku UNIQUE KEY (kode_sku),
    CONSTRAINT ck_produk_stok CHECK (stok_produk >= 0),
    CONSTRAINT ck_produk_harga CHECK (harga_produk >= 0)
) ENGINE=InnoDB;

-- 4. Tabel Pesanan (Kepala Transaksi Nota Online)
CREATE TABLE pesanan (
    id_pesanan INT NOT NULL AUTO_INCREMENT,
    no_pesanan VARCHAR(30) NOT NULL,
    tgl_pesanan DATETIME NOT NULL,
    id_pelanggan INT NOT NULL,
    id_kurir SMALLINT NOT NULL,
    status_pesanan ENUM('pending', 'diproses', 'dikirim', 'selesai', 'batal') NOT NULL DEFAULT 'pending',
    ongkir DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (id_pesanan),
    CONSTRAINT uq_pesanan_no UNIQUE KEY (no_pesanan),
    CONSTRAINT fk_pesanan_pelanggan FOREIGN KEY (id_pelanggan) REFERENCES pelanggan (id_pelanggan),
    CONSTRAINT fk_pesanan_kurir FOREIGN KEY (id_kurir) REFERENCES kurir (id_kurir)
) ENGINE=InnoDB;

-- 5. Tabel Detail Pesanan (Detail Transaksi / Asosiatif Item Pesanan)
CREATE TABLE detail_pesanan (
    id_pesanan INT NOT NULL,
    id_produk INT NOT NULL,
    qty_pesanan INT NOT NULL,
    harga_saat_beli DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (id_pesanan, id_produk),
    CONSTRAINT fk_detail_pesanan_kepala FOREIGN KEY (id_pesanan) REFERENCES pesanan (id_pesanan) ON DELETE CASCADE,
    CONSTRAINT fk_detail_pesanan_produk FOREIGN KEY (id_produk) REFERENCES produk (id_produk),
    CONSTRAINT ck_detail_pesanan_qty CHECK (qty_pesanan > 0) -- Menjaga batas parameter P baris tunggal
) ENGINE=InnoDB;