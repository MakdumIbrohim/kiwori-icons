# Kiwori Icons

Kiwori Icons adalah icon theme open-source untuk desktop Linux dengan gaya visual **colorful, pastel, playful, cartoon-inspired, rounded, dan bold black outline**.

Tema ini dirancang dengan identitas visual yang khas, menghadirkan estetika stiker/kartun modern yang cerah tanpa menghilangkan ciri khas atau pengenalan dari logo aplikasi aslinya.

---

## Pratinjau (Preview)

![Kiwori Preview Overview](preview/overview.png)

*(Aset pratinjau visual lengkap tersedia di direktori `preview/`)*

---

## Karakteristik & Fitur Utama

* **Pastel & Colorful**: Menggabungkan warna pastel lembut dengan aksen cerah berkarakter.
* **Rounded Shapes**: Bentuk sudut membulat yang bersahabat dan ramah mata.
* **Bold Black Outline**: Siluet bergaris tepi gelap pekat (`#171717`) yang tegas dan kontras tinggi.
* **Scalable Vector**: Dibuat 100% berbasis SVG standar (`256×256`) yang tajam pada semua skala resolusi (HiDPI ready).
* **FreeDesktop/XDG Compliant**: Mengikuti standar direktori icon Linux modern dengan fallback inheritance ke `hicolor`.

---

## Desktop Environment yang Didukung

Prioritas utama pengembangan adalah **KDE Plasma**, serta kompatibel penuh dengan desktop Linux lainnya:
* **KDE Plasma** (Dolphin, Konsole, System Settings, Discover)
* **GNOME**
* **XFCE**
* **Cinnamon**
* **MATE**
* **LXQt**

---

## Cara Instalasi

### Metode 1: Instalasi Cepat via Git (Pengguna Lokal)

Buka terminal dan jalankan:

```bash
git clone https://github.com/makdumibrohim/kiwori-icons.git
cd kiwori-icons
./scripts/install.sh
```

Tema akan dipasang ke `~/.local/share/icons/Kiwori/` tanpa memerlukan akses `sudo`.

### Metode 2: Menggunakan Makefile

```bash
make install
```

### Metode 3: Instalasi System-wide (Opsional)

Untuk memasang tema bagi semua pengguna sistem:

```bash
sudo ./scripts/install.sh --system
```

---

## Cara Mengaktifkan Tema

Setelah instalasi selesai:

* **KDE Plasma**:
  Buka **System Settings** → **Colors & Themes** → **Icons** → Pilih **Kiwori** → Klik **Apply**.
* **GNOME**:
  Buka **GNOME Tweaks** → **Appearance** → **Icons** → Pilih **Kiwori**.
* **XFCE**:
  Buka **Settings** → **Appearance** → **Icons** → Pilih **Kiwori**.

---

## Cara Mencopot Tema (Uninstallation)

Jalankan skrip pencopotan:

```bash
./scripts/uninstall.sh
```

atau menggunakan `make`:

```bash
make uninstall
```

---

## Pengembangan (Development)

Untuk membangun dan memvalidasi tema secara lokal:

```bash
# Validasi integritas SVG dan index.theme
make validate

# Bangun distribusi tema ke theme/Kiwori/
make build

# Bersihkan artefak build
make clean
```

Dokumentasi arsitektur dan panduan teknis lebih lanjut:
* [Panduan Desain (docs/DESIGN.md)](docs/DESIGN.md)
* [Konvensi Penamaan Icon (docs/ICON-NAMING.md)](docs/ICON-NAMING.md)
* [Panduan Pengembangan (docs/DEVELOPMENT.md)](docs/DEVELOPMENT.md)
* [Panduan Kontribusi (docs/CONTRIBUTING.md)](docs/CONTRIBUTING.md)

---

## Kontribusi

Kontribusi berupa penambahan icon baru, perbaikan bug, atau penyempurnaan desain sangat disambut! Silakan baca [CONTRIBUTING.md](docs/CONTRIBUTING.md) untuk detail alur branch (`dev`), standar kualitas, dan checklist pull request.

---

## Lisensi & Trademark Notice

### Lisensi
Kiwori Icons dilisensikan di bawah [GNU General Public License v3.0 (GPL-3.0)](LICENSE).

### Trademark & Non-Affiliation Notice
Seluruh nama produk pihak ketiga, logo, brand, dan merek dagang terdaftar yang digambarkan dalam icon theme ini adalah milik masing-masing pemegang hak cipta/merek. Penggunaan nama dan logo tersebut semata-mata ditujukan untuk integrasi interoperabilitas antarmuka desktop Linux di bawah prinsip penggunaan wajar (*fair use*) dan tidak mengindikasikan afiliasi atau dukungan resmi dari pihak terkait.
