# Contributing to Kiwori Icons

Thank you for your interest in contributing to **Kiwori Icons**!

---

## 1. Git Workflow

1. **Fork** the `kiwori-icons` repository.
2. Create a new topic branch branching off `dev`:
   ```bash
   git checkout dev
   git pull origin dev
   git checkout -b feature/your-feature-name
   ```
   *Examples: `feature/add-spotify`, `feature/folder-icons`.*
3. Add or modify SVG assets inside `src/`.
4. Validate and build locally:
   ```bash
   make validate
   make build
   ```
5. Commit your changes with a clear, descriptive English commit message following Conventional Commits:
   ```bash
   git commit -m "feat(apps): add spotify icon"
   ```
6. Push to your fork and submit a **Pull Request** targeting the **`dev`** branch (not `main`).

---

## 2. Quality Checklist (Definition of Done)

Before opening a pull request, ensure your icons meet these requirements:
* [ ] Authored in clean SVG on a `256×256` canvas (`viewBox="0 0 256 256"`).
* [ ] Follows the Kiwori Design System: bold `#171717` outline, rounded geometry, and strict adherence to the [Official Color Palette](DESIGN.md#5-official-color-palette).
* [ ] Application logos remain immediately recognizable.
* [ ] Contains no embedded raster bitmaps (no base64 `data:image`).
* [ ] Filename is lowercase with hyphen delimiters and `.svg` extension.
* [ ] Passes `./scripts/validate.sh` with zero errors.
* [ ] Tested on a live Linux desktop environment (e.g. KDE Plasma or GNOME).

---

## 3. Submitting Issues & Requests

To keep issues organized and easy to track, please use the appropriate title prefix when opening an issue:

| Issue Type | Title Prefix | Description |
|---|---|---|
| **Icon Request** | `[ICON REQUEST] <App / Format Name>` | Request a new application, file format, or folder icon |
| **Bug Report** | `[BUG] <Short Description>` | Report a broken, cut-off, or miscolored icon |
| **Symlink Request** | `[SYMLINK REQUEST] <App Name>` | Request a missing `.desktop` or Flatpak alias for an existing icon |
| **Launcher Request** | `[LAUNCHER REQUEST] <Distro Name>` | Request a new distribution start-menu icon for `launchers/` |

### Examples:
* `[ICON REQUEST] Steam`
* `[ICON REQUEST] Krita`
* `[BUG] Volume icon cut off in KDE Plasma panel`
* `[SYMLINK REQUEST] Firefox Developer Edition (firefox-developer-edition.svg)`
* `[LAUNCHER REQUEST] Manjaro Linux`
