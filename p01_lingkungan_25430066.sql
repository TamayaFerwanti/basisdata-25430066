-- Pembuatan Database dan Akun Praktikum Basis Data
CREATE DATABASE IF NOT EXISTS kopma_066;

-- Membuat User dan Hak Akses
CREATE USER IF NOT EXISTS 'mhs_066'@'localhost' IDENTIFIED BY 'Rahasia123!';
GRANT ALL PRIVILEGES ON kopma_066.* TO 'mhs_066'@'localhost';
FLUSH PRIVILEGES;

-- Menampilkan Database yang tersedia
SHOW DATABASES;