# Panduan Kontribusi Kiwori Icons

Terima kasih atas ketertarikan Anda untuk berkontribusi pada pengembangan **Kiwori Icons**!

---

## 1. Alur Kerja Git (Git Workflow)

1. **Fork** repository `kiwori-icons`.
2. Buat branch fitur baru dari branch `dev`:
   ```bash
   git checkout dev
   git pull origin dev
   git checkout -b feature/nama-fitur
   ```
   *Contoh branch: `feature/add-spotify`, `feature/folder-icons`.*
3. Lakukan perubahan pada direktori `src/`.
4. Uji validasi secara lokal:
   ```bash
   make validate
   make build
   ```
5. Commit perubahan Anda dengan pesan commit yang jelas:
   ```bash
   git commit -m "feat(apps): tambahkan icon spotify"
   ```
6. Dorong (push) ke fork Anda dan buat **Pull Request** yang menargetkan branch **`dev`** (bukan `main`).

---

## 2. Checklist Kualitas (Definition of Done)

Sebelum mengajukan PR, pastikan icon Anda memenuhi kriteria berikut:
* [ ] Format berkas adalah `.svg` murni pada kanvas `256×256` px (`viewBox="0 0 256 256"`).
* [ ] Menggunakan outline tebal gelap `#171717` dengan sudut/ujung membulat (`round`).
* [ ] Mengikuti palet warna Kiwori dan mempertahankan bentuk rounded/playful.
* [ ] Logo aplikasi tetap mudah dikenali.
* [ ] Tidak memiliki gambar raster bitmap yang disematkan (`data:image`).
* [ ] Nama berkas huruf kecil, pemisah hyphen, dan sesuai konvensi FreeDesktop.
* [ ] Lolos eksekusi `./scripts/validate.sh` tanpa error.
* [ ] Berhasil diuji tampil pada desktop environment (terutama KDE Plasma).

---

## 3. Menghubungi & Request Icon

Jika Anda bukan desainer tetapi ingin meminta dukungan icon aplikasi baru, silakan buka issue baru menggunakan template **Icon Request**.
