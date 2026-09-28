# Kiwori Design System

Panduan standar desain untuk menjaga konsistensi visual seluruh icon dalam tema **Kiwori**.

---

## 1. Prinsip Utama

> **Recognizable, Playful, Colorful, Consistent.**

* **Recognizable**: Logo atau aplikasi harus tetap mempertahankan karakter aslinya (Firefox tetap Firefox, Spotify tetap Spotify).
* **Playful**: Nuansa ringan, sedikit sentuhan kartun dan stiker.
* **Colorful**: Kombinasi warna pastel berpadu dengan aksen cerah.
* **Consistent**: Memiliki bahasa bentuk, outline, radius sudut, dan bobot visual yang seragam di seluruh kategori.

---

## 2. Canvas & Grid

* **Format**: SVG murni (Scalable Vector Graphics).
* **Artboard Master**: `256 × 256` px.
* **ViewBox Wajib**: `viewBox="0 0 256 256"`.
* **Safe Zone / Padding**: 16 px dari tepi kanvas (area aktif 224 × 224 px).

---

## 3. Sistem Garis Tepi (Outline System)

Outline gelap pekat adalah ciri khas utama identitas Kiwori.

* **Warna Outline**: `#171717` (Kiwori Black).
* **Tebal Garis Siluet Utama (Outer Stroke)**: `14px` (atau `16px` untuk siluet luar masif).
* **Tebal Garis Detail Internal (Inner Stroke)**: `8px`.
* **Ujung Garis**: `stroke-linecap="round"`.
* **Sudut Garis**: `stroke-linejoin="round"`.
* **Ketentuan Stroke**: Gunakan stroke proporsional (jangan gunakan `vector-effect: non-scaling-stroke` agar garis ikut mengecil saat discale ke ukuran kecil).

---

## 4. Bentuk (Shape Language)

Gunakan bentuk geometris yang ramah dan membulat:
* Rounded rectangle (Corner Radius referensi: `32px` - `48px` pada kanvas 256).
* Rounded square / squircle.
* Circle / ellipse.
* Bentuk organik sederhana dengan kurva halus.

**Hindari**:
* Sudut lancip tajam (< 90° tanpa bevel/radius).
* Detail mikro berlebih yang akan hilang saat dirender pada ukuran 16px.
* Tekstur realistis atau efek skeuomorphism berlebihan.

---

## 5. Sistem Warna (Color Palette)

Palette awal resmi Kiwori:

| Nama Warna    | Hex Code  | Fungsi Utama |
| ------------- | --------- | ------------ |
| Kiwori Black  | `#171717` | Outline siluet dan detail simbol |
| Soft White    | `#FFFFFF` | Highlight, kilau stiker, latar kontras |
| Pastel Pink   | `#FF8FB1` | Aksen aplikasi hiburan / sosial |
| Pastel Purple | `#B982FF` | Aksen media, kreativitas, utilitas |
| Pastel Blue   | `#65C7FF` | Warna primer sistem, browser, folder |
| Pastel Cyan   | `#5ED8D2` | Aksen komunikasi dan transfer data |
| Pastel Green  | `#73D69A` | Status sukses, audio, productivity |
| Pastel Yellow | `#FFE477` | Folder default, peringatan, arsip |
| Pastel Orange | `#FFAA6B` | Aksen grafis, peringatan sedang |
| Pastel Red    | `#FF6B6B` | Status error, media rekam, aksi hapus |

*Warna aplikasi pihak ketiga dapat menyesuaikan identitas brand dengan tetap menjaga keseimbangan tone pastel & outline Kiwori.*

---

## 6. Konstruksi SVG Teknis

Struktur SVG harus bersih dan valid:
1. Tidak menyertakan metadata editor (seperti namespace `sodipodi` atau `inkscape` yang tidak diperlukan).
2. Dilarang menyematkan gambar raster base64 (`data:image/png...`).
3. Dilarang mereferensikan aset berkas eksternal (`href="file://..."`).
4. Atribut root minimal:
   ```xml
   <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 256" width="256" height="256">
     <!-- Path & bentuk vector -->
   </svg>
   ```
