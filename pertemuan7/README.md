# Quiz

- Berikan contoh pemanfaatan data historis
- Rancang ERD untuk penyimpanan data karyawan dari sebuah perusahaan, lengkap dengan data historis gaji, data historis
  tempat tinggal, dan data historis jabatan. Selanjutnya, implementasikan ERD tersebut pada basis data relasional (MySQL
  / PostgreSQL / SQL Server / dll) menggunakan perintah

Jawab:

## Contoh Pemanfaatan Data Historis

- Google Trends
- Histroris tempat tinggal

## ERD

![ERD](ERD%20Data%20Karyawan.drawio.svg)

- Karyawan

| Karyawan      |
|:--------------|
| ID            |
| NIP           |
| NIK           |
| Nama          |
| Jenis Kelamin |
| Tempat Lahir  |
| Tanggal Lahir |
| Telepon       |
| Agama         |
| Status Nikah  |
| Alamat        |
| Foto          |

```sql
CREATE TABLE `karyawan` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nip` varchar(12) NOT NULL,
  `nik` varchar(12) NOT NULL,
  `nama` varchar(64) NOT NULL,
  `jenis_kelamin` enum('pria','wanita') NOT NULL,
  `tempat_lahir` varchar(100) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `telepon` varchar(15) NOT NULL,
  `agama` varchar(15) NOT NULL,
  `status_nikah` enum('belum nikah','nikah') NOT NULL,
  `alamat` text NOT NULL,
  `foto` text NOT NULL,
  PRIMARY KEY (`id`)
);
```

- Histori Gaji

| Histori Gaji       |
|:-------------------|
| Tanggal Mulai Gaji |
| Karyawan ID        |
| Gaji               |
| Keterangan         |

```sql
CREATE TABLE `histori_gaji` (
  `tanggal_mulai_gaji` date NOT NULL,
  `id_karyawan` int(10) unsigned NOT NULL,
  `gaji_bulanan` int(10) unsigned NOT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_karyawan`,`tanggal_mulai_gaji`)
);
```

- Histori Tempat Tinggal

| Histori Tempat Tinggal |
|:-----------------------|
| Tanggal Mulai Menetap  |
| Karyawan ID            |
| Alamat                 |
| Keterangan             |

```sql
CREATE TABLE `histori_tempat_tinggal` (
  `tanggal_mulai_menetap` date NOT NULL,
  `id_karyawan` int(10) unsigned NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`tanggal_mulai_menetap`,`id_karyawan`)
);
```

- Histori Jabatan

| Histori Jabatan       |
|:----------------------|
| Tanggal Mulai Jabatan |
| Karyawan ID           |
| Jabatan               |
| Keterangan            |

```sql
CREATE TABLE `histori_jabatan` (
  `tanggal_mulai_jabatan` date NOT NULL,
  `id_karyawan` int(10) unsigned NOT NULL,
  `jabatan` varchar(20) unsigned NOT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`tanggal_mulai_jabatan`,`id_karyawan`)
);
```
