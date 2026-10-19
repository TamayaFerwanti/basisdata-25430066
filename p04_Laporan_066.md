# Laporan Praktikum Basis Data - Modul 4

**Nama:** Tamaya Ferwanti
**NIM:** 25430066
**Kelas:** C
**Mata Kuliah:** Basis Data
**Tanggal:** 19 Oktober 2026

---

## 1. Tujuan Praktikum
1. **Mengidentifikasi Anomali Data:** Mampu mengenali dan menganalisis dampak buruk dari anomali ubah (*update anomaly*), anomali sisip (*insert anomaly*), dan anomali hapus (*delete anomaly*) yang terjadi pada tabel basis data yang belum dinormalisasi.
2. **Formulasi Dependensi Fungsional:** Menyusun daftar ketergantungan fungsional (*Functional Dependency*) secara sistematis yang diturunkan langsung dari aturan bisnis operasional toko daring TF Mart, bukan sekadar menebak dari data sampel.
3. **Melakukan Normalisasi Bertahap:** Menerapkan proses dekomposisi relasi secara runtut mulai dari Bentuk Tidak Normal (UNF), Normal Pertama (1NF), Normal Kedua (2NF), hingga Normal Ketiga (3NF), serta melakukan verifikasi Boyce-Codd Normal Form (BCNF).
4. **Menentukan Atribut Turunan:** Mengambil keputusan arsitektural yang tepat terkait penyimpanan nilai turunan (*derived attributes*) seperti subtotal dan total harga pada skema basis data operasional.

## 2. Ringkasan Dasar Teori
Normalisasi merupakan teknik perancangan basis data yang bertujuan untuk menghilangkan redundansi (pengulangan data yang tidak perlu) serta mencegah berbagai anomali manipulasi data[cite: 3]. Pada awal perancangan sistem e-commerce seperti toko daring **TF Mart**, data transaksi biasanya menumpuk dalam satu tabel raksasa (*flat file*) yang menggabungkan informasi pelanggan, produk, kurir, dan rincian transaksi sekaligus. 

Tahapan normalisasi dibagi menjadi beberapa tingkat untuk memastikan efisiensi:
* **1NF (First Normal Form):** Memastikan setiap sel atau kolom bernilai atomik (tunggal) dan menghilangkan seluruh kelompok atribut yang berulang (*repeating group*)[cite: 3].
* **2NF (Second Normal Form):** Memastikan tabel sudah memenuhi syarat 1NF dan bebas dari ketergantungan parsial, di mana atribut bukan kunci harus bergantung penuh pada seluruh *Primary Key*, bukan hanya sebagian saja (khususnya pada *Composite Primary Key*).
* **3NF (Third Normal Form):** Memastikan tabel sudah memenuhi syarat 2NF dan bebas dari ketergantungan transitif, di mana tidak boleh ada atribut non-kunci yang bergantung pada atribut non-kunci lainnya.
* **BCNF (Boyce-Codd Normal Form):** Bentuk penyempurnaan dari 3NF di mana setiap penentu (*determiner*) pada ketergantungan fungsional harus merupakan *Candidate Key*.
* **Nilai Turunan & Integritas Historis:** Atribut kalkulasi pada sistem OLTP umumnya tidak disimpan secara permanen untuk menghindari inkonsistensi, melainkan dihitung secara dinamis melalui kueri SQL, sementara harga historis transaksi tetap dicatat agar tidak terpengaruh oleh perubahan harga katalog di masa depan.

## 3. Hasil Langkah Percobaan
* Melakukan analisis mendalam terhadap struktur spreadsheet Kopma dan mengeksekusi dekomposisi tabel secara runtut dari tahap UNF hingga 3NF.
* Menyusun daftar ketergantungan fungsional yang komprehensif (FD1 sampai FD6) yang merepresentasikan alur operasional nyata dari studi kasus Kopma.
* Mendokumentasikan seluruh hasil analisis dan dekomposisi tersebut ke dalam berkas laporan teknis `p04_normalisasi_kopma_25430066.md`.

## 4. Jawaban Titik Analisis
1. **Titik Analisis 1:** Atribut `harga_satuan_detail_penjualan` wajib ditempatkan pada kunci transaksi komposit agar perubahan harga katalog di masa depan tidak mengubah catatan historis omzet atau nota transaksi lama yang sudah pernah tercetak.
2. **Titik Analisis 2:** Keputusan untuk tidak menyimpan nilai total harga secara permanen pada tabel operasional OLTP melainkan menyediakannya pada arsip OLAP tetap konsisten karena data OLTP masih sangat dinamis dan berpotensi berubah, sedangkan data arsip bersifat kaku dan hanya boleh dibaca (*read-only*).
3. **Titik Analisis 3:** Informasi pemasok disimpan secara relasional melalui tabel `PEMBELIAN` dan `DETAIL_PEMBELIAN`, sehingga sistem memberikan fleksibilitas penuh di mana satu jenis barang dapat dipasok oleh banyak pemasok berbeda tanpa kendala redundansi.

## 5. Hasil Latihan dan Modifikasi
1. Menerapkan pemisahan tabel khusus `TELEPON_PEMASOK` guna menangani atribut bernilai banyak (*multivalued attribute*) agar struktur sel tetap atomik dan sesuai dengan kaidah 1NF.
2. Menganalisis contoh kasus nyata dari anomali ubah yang akan terjadi apabila atribut nama anggota (`nama_anggota`) disimpan secara tercampur di dalam tabel penjualan alih-alih merujuk pada tabel entitas pelanggan yang independen.

## 6. Tugas Mandiri: Milestone Proyek 4
* **Tema Proyek:** Perancangan Basis Data Toko Daring / Minimarket **TF Mart** dengan identitas NIM `25430066`.
* **Hasil Pengerjaan:** Menyusun dokumen teknis mandiri bernama `p04_normalisasi_25430066.md` yang memuat seluruh tahapan perancangan secara lengkap mulai dari *Unnormalized Form* (UNF), *First Normal Form* (1NF), *Second Normal Form* (2NF), hingga *Third Normal Form* (3NF) dan verifikasi BCNF untuk 5 tabel relasional utama (`PELANGGAN`, `KURIR`, `PRODUK`, `PESANAN`, dan `DETAIL_PESANAN`)[cite: 2, 3].
* **Bukti Visual:** Menyertakan arsip tangkapan layar (*screenshot*) tahapan proses normalisasi ke dalam folder direktori `Image/` yang mencakup file `p04_ss_UNF.png`, `p04_ss_1NF.png`, serta `p04_ss_2NF & 3NF.png`.

## 7. Pembahasan dan Kendala
Dalam proses pengerjaan modul ini, tantangan utama adalah memastikan bahwa penentuan ketergantungan fungsional benar-benar berakar dari aturan bisnis murni sistem toko daring TF Mart dan bukan sekadar menebak-nebak dari data sampel yang terbatas[cite: 3]. Selain itu, eliminasi ketat terhadap ketergantungan parsial dan transitif harus dilakukan secara cermat agar seluruh tabel akhir benar-benar steril dari potensi anomali data.

## 8. Kesimpulan
Berdasarkan seluruh tahapan praktikum yang telah dilakukan, skema relasional 3NF/BCNF untuk proyek toko daring **TF Mart** berhasil dirancang secara profesional[cite: 3]. Basis data akhir terbagi menjadi 5 entitas relasional terpisah yang saling terikat melalui *Foreign Key*, sehingga dijamin sepenuhnya terbebas dari anomali ubah, sisip, maupun hapus, serta sangat siap untuk dilanjutkan ke tahap implementasi skrip DDL SQL pada modul berikutnya.

## 9. Pernyataan Penggunaan AI
Penyusunan laporan dan verifikasi logika perancangan ini mendapatkan dukungan asistensi dari kecerdasan buatan (Gemini) dalam hal pemeriksaan kaidah BCNF, formulasi ketergantungan fungsional, serta penataan struktur dokumen berbasis Markdown agar lebih rapi dan komunikatif.

## 10. Bukti Git
* **Tautan Repositori:** `https://github.com/TamayaFerwanti/basisdata-25430066`
* **Pesan Commit / Hash:** `p04: update laporan dengan milestone tf mart`

---

## Checklist
- [x] Berkas `p04_normalisasi_25430066.md` Terbuat[cite: 2]
- [x] Tahapan UNF-1NF-2NF-3NF & BCNF Terisi[cite: 2]
- [x] Tangkapan Layar Direktori `Image/` Tersimpan[cite: 2]
- [x] Jawaban Titik Analisis 1 sampai 3 Lengkap Terisi[cite: 3]
- [x] Tugas Mandiri Milestone Proyek 4 Terintegrasi Penuh