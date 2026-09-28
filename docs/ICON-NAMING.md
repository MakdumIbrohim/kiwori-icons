# Kiwori Icon Naming Conventions & Mapping

Guidelines for icon file naming and desktop entry mapping under the FreeDesktop (XDG) icon specification.

---

## 1. Filename Rules

Every icon file must satisfy the following criteria:
1. **Strictly Lowercase**: `firefox.svg` (never `Firefox.svg`).
2. **Hyphen Separators**: `google-chrome.svg` (never underscores or spaces).
3. **SVG Extension**: Files must end in `.svg`.
4. **Allowed Characters**: `[a-z0-9.-]`.
5. **No Special Characters**: Prohibit `@`, `!`, `#`, `$`, `%`, etc.

---

## 2. Category Directories

Icons are organized by category subdirectories under `src/`:

| Category | Description | Examples |
| -------- | ----------- | -------- |
| `apps` | Third-party and system application launchers | `firefox.svg`, `konsole.svg`, `spotify.svg` |
| `actions` | UI buttons, toolbar controls, context menu commands | `add.svg`, `edit.svg`, `close.svg`, `settings.svg` |
| `places` | User directories, mount points, file locations | `folder.svg`, `folder-home.svg`, `trash.svg` |
| `devices` | Physical hardware, drives, peripherals | `computer.svg`, `drive-harddisk.svg`, `smartphone.svg` |
| `mimetypes` | Document, data, and binary file formats | `application-pdf.svg`, `text-html.svg` |
| `categories` | Application menu category headers | `applications-development.svg`, `applications-system.svg` |
| `status` | System status indicators and dialog icons | `dialog-warning.svg`, `battery-full.svg` |
| `emblems` | Overlay badges for files and folders | `emblem-favorite.svg`, `emblem-readonly.svg` |

---

## 3. Desktop Entry Mapping & Symlinks

Linux desktop environments resolve icons via `.desktop` files using the `Icon=` key.

### Common Mapping Examples:

| Desktop Entry | `Icon=` Key | Master Kiwori Icon | Relative Symlink |
| ------------- | ----------- | ------------------ | ---------------- |
| `org.mozilla.firefox.desktop` | `firefox` / `org.mozilla.firefox` | `apps/firefox.svg` | `apps/org.mozilla.firefox.svg -> firefox.svg` |
| `com.discordapp.Discord.desktop` | `discord` / `com.discordapp.Discord` | `apps/discord.svg` | `apps/com.discordapp.Discord.svg -> discord.svg` |
| `com.spotify.Client.desktop` | `spotify-client` / `spotify` | `apps/spotify.svg` | `apps/spotify-client.svg -> spotify.svg` |
| `org.kde.dolphin.desktop` | `system-file-manager` / `dolphin` | `apps/dolphin.svg` | `apps/org.kde.dolphin.svg -> dolphin.svg` |
| `code.desktop` | `vscode` / `code` | `apps/code.svg` | `apps/vscode.svg -> code.svg` |

### Relative Symlink Creation:
Create relative symlinks within the respective category directory:
```bash
cd src/apps/
ln -s firefox.svg org.mozilla.firefox.svg
```
The build script (`scripts/build.sh`) preserves relative symlinks when synchronizing to `theme/Kiwori/scalable/`.
