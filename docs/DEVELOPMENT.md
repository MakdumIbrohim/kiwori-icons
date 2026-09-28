# Panduan Pengembangan (Development Guide)

Dokumen ini ditujukan untuk developer dan maintainer tema Kiwori Icons.

---

## 1. Alat Kerja yang Disarankan

* **Editor Vektor**: Inkscape, Figma, atau Adobe Illustrator (pastikan export berupa SVG standar tanpa proprietary metadata).
* **Optimizer SVG**: `scour` atau `svgo` (opsional untuk membersihkan path SVG sebelum rilis).
* **Terminal & Shell**: Bash atau Zsh dengan utilitas standar Linux (`find`, `grep`, `coreutils`).
* **Desktop Uji**: KDE Plasma 5/6, GNOME 40+, XFCE, atau distribusi Linux berbasis XDG.

---

## 2. Siklus Pengembangan Lokal

1. **Membuat atau memodifikasi icon di `src/`**:
   Letakkan file master SVG di `src/<kategori>/<nama-icon>.svg`.
2. **Menjalankan Validasi & Build**:
   ```bash
   make build
   ```
   Perintah ini akan menyinkronkan aset dari `src/` ke `theme/Kiwori/scalable/` serta menjalankan `scripts/validate.sh`.
3. **Memasang ke Desktop Lokal**:
   ```bash
   make install
   ```
   Tema akan dipasang di `~/.local/share/icons/Kiwori/` dan cache desktop akan disegarkan otomatis.
4. **Mengaktifkan Tema**:
   * **KDE Plasma**: Buka *System Settings* → *Colors & Themes* → *Icons* → Pilih **Kiwori**.
   * **GNOME**: Gunakan *GNOME Tweaks* → *Appearance* → *Icons* → Pilih **Kiwori**.
   * **XFCE**: Buka *Settings* → *Appearance* → *Icons* → Pilih **Kiwori**.
5. **Memeriksa Perubahan**:
   Jika perubahan icon tidak langsung terlihat, bersihkan cache icon secara paksa:
   ```bash
   gtk-update-icon-cache -f -t ~/.local/share/icons/Kiwori
   kbuildsycoca6 --noincremental
   ```

---

## 3. Strategi Rilis (Release Process)

1. Pastikan seluruh pengujian validasi lolos:
   ```bash
   make validate
   ```
2. Gabungkan (merge) branch `dev` ke branch `main`.
3. Buat Git Tag mengikuti Semantic Versioning:
   ```bash
   git tag -a v1.0.0 -m "Release Kiwori Icons v1.0.0"
   git push origin v1.0.0
   ```
4. Buat arsip rilis tarball:
   ```bash
   tar -czvf Kiwori-v1.0.0.tar.gz -C theme Kiwori
   ```
