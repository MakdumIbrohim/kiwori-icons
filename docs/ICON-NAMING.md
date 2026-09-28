# Kiwori Icon Naming Conventions & Mapping

Dokumen ini menjelaskan konvensi penamaan berkas icon dan pemetaan ke desktop entry Linux.

---

## 1. Aturan Penamaan Berkas

Setiap icon harus mematuhi aturan berikut:
1. **Hanya huruf kecil (lowercase)**: `firefox.svg` (bukan `Firefox.svg`).
2. **Pemisah menggunakan tanda hubung (hyphen)**: `google-chrome.svg` (bukan `google_chrome.svg` atau spasi).
3. **Ekstensi wajib `.svg`**.
4. **Karakter diperbolehkan**: `[a-z0-9.-]`.
5. **Dilarang spasi dan karakter khusus** (`_`, `@`, `!`, `#`, dll).

---

## 2. Kategori Direktori

Icon ditempatkan di subdirektori kategori yang sesuai di dalam `src/`:

| Kategori | Deskripsi | Contoh |
| -------- | --------- | ------ |
| `apps` | Peluncur aplikasi pihak ketiga dan sistem | `firefox.svg`, `konsole.svg`, `spotify.svg` |
| `actions` | Tombol aksi UI, toolbar, menu konteks | `add.svg`, `edit.svg`, `close.svg`, `settings.svg` |
| `places` | Direktori pengguna dan mountpoint | `folder.svg`, `folder-home.svg`, `trash.svg` |
| `devices` | Perangkat keras fisik dan media | `computer.svg`, `drive-harddisk.svg`, `smartphone.svg` |
| `mimetypes` | Format file dokumen dan data | `application-pdf.svg`, `text-html.svg` |
| `categories` | Kelompok menu kategori aplikasi | `applications-development.svg`, `applications-system.svg` |
| `status` | Indikator status sistem dan dialog | `dialog-warning.svg`, `battery-full.svg` |
| `emblems` | Simbol overlay status file/folder | `emblem-favorite.svg`, `emblem-readonly.svg` |

---

## 3. Pemetaan Desktop Entry & Symlink

Desktop Linux menggunakan file `.desktop` yang menentukan icon melalui kunci `Icon=...`.

### Contoh Pemetaan:

| Nama Desktop Entry | Kunci `Icon=` | Nama File Master Kiwori | Symlink Tambahan |
| ------------------ | ------------- | ----------------------- | ---------------- |
| `org.mozilla.firefox.desktop` | `firefox` / `org.mozilla.firefox` | `apps/firefox.svg` | `apps/org.mozilla.firefox.svg -> firefox.svg` |
| `com.discordapp.Discord.desktop` | `discord` / `com.discordapp.Discord` | `apps/discord.svg` | `apps/com.discordapp.Discord.svg -> discord.svg` |
| `com.spotify.Client.desktop` | `spotify-client` / `spotify` | `apps/spotify.svg` | `apps/spotify-client.svg -> spotify.svg` |
| `org.kde.dolphin.desktop` | `system-file-manager` / `dolphin` | `apps/dolphin.svg` | `apps/org.kde.dolphin.svg -> dolphin.svg` |
| `code.desktop` | `vscode` / `code` | `apps/code.svg` | `apps/vscode.svg -> code.svg` |

### Pembuatan Symlink Relatif:
Gunakan symlink relatif di dalam direktori kategori:
```bash
cd src/apps/
ln -s firefox.svg org.mozilla.firefox.svg
```
Skrip `scripts/build.sh` akan menyalin symlink secara utuh ke `theme/Kiwori/scalable/`.
