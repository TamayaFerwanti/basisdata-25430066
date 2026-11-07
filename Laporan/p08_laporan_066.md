# Laporan Praktikum Basis Data - Pertemuan 8 (UTS Proyek Tahap 1)

**Nama:** Tamaya Ferwanti  
**NIM:** 25430066  
**Kelas:** C / S1 Ilmu Komputer  
**Tanggal Ujian:** 07 November 2026  

---

## 1. Tujuan Praktikum / UTS
Menguji kemampuan mengintegrasikan seluruh tahapan perancangan basis data mulai dari Milestone 1 sampai 7 menjadi satu kesatuan sistem proyek **TF Mart** (`toko_066`) yang utuh, otomatis, dapat dipasang ulang dari skrip tunggal, serta dapat dipertanggungjawabkan dalam sesi demo dan *viva*.

## 2. Ringkasan Arsitektur Proyek
Basis data proyek **TF Mart** dirancang secara terstruktur mulai dari analisis kebutuhan fungsional, normalisasi 3NF, pembuatan skrip DDL, pengisian data berbasis parameter $P=4$, hingga penerapan kueri analitik dan fungsi skalar tingkat lanjut pada Modul 7. Seluruh skrip diintegrasikan melalui prosedur *install script* (`install_uts_25430066.sql`).

## 3. Bukti Tangkapan Layar Instalasi Bersih
Berikut adalah bukti tangkapan layar saat basis data berhasil dipasang dari nol secara otomatis menggunakan skrip instalasi bersih:

![Bukti Instalasi Bersih Basis Data TF Mart](image/p08_ss_installasi_bersih.png)

## 4. Catatan Modifikasi & Refleksi Desain
- **Catatan Modifikasi Langsung:** Selama sesi uji coba dan simulasi demo, struktur relasi dan tipe data terbukti stabil menghadapi berbagai skenario manipulasi data.
- **Refleksi Desain:** Ke depannya, penambahan indeks pada kolom pencarian frekuensi tinggi (seperti nama produk dan tanggal pesanan) akan dioptimalkan guna meningkatkan kinerja kueri (*query performance*).

## 5. Pernyataan Penggunaan AI
Dalam persiapan dokumen dan pengorganisasian skrip instalasi UTS ini, bantuan AI (Gemini) digunakan secara kolaboratif untuk membantu menyelaraskan format skrip SQL dan menyusun struktur laporan formal.

## 6. Bukti Git
- **Tautan Repositori:** `https://github.com/TamayaFerwanti/basisdata-25430066`
- **Commit Hash UTS:** `a7da35d`

---

## Checklist UTS
- [x] Berkas `install_uts_25430066.sql` Berhasil Dibuat dan Diuji
- [x] Berkas Laporan `Laporan/p08_laporan_25430066.md` Lengkap
- [x] Bukti Tangkapan Layar `p08_instalasi_bersih.png` Terlampir di `Laporan/image/`
- [x] Ringkasan Milestone `p08_uts_25430066.md` Terbuat
