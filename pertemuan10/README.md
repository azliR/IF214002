# Pertemuan 10
## Tugas
- Buat infografik / cheatsheet dari perintah-perintah MySQL [di atas](https://github.com/insanalamin/IF214002/tree/main/pertemuan10) (boleh yang mau pake PostgreSQL)
- Buat query untuk mencari penduduk berusia diatas 25 tahun yang berada di kabupaten 3204 dari [data ini](https://github.com/insanalamin/IF214002/blob/main/pertemuan10/penduduk.sql)
- Nilai tambah, untuk yang menambahkan perintah-perintah MySQL lainnya

## Jawaban
- In progress
- Query untuk mencari penduduk berusia diatas 25 tahun yang berada di kabupaten 3204
```sql
SELECT * FROM penduduk WHERE TIMESTAMPDIFF(YEAR, tanggal_lahir, now()) > 25 AND kode_kabupaten = '3204'
```
