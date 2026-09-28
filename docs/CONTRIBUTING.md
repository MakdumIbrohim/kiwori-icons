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
* [ ] Follows the Kiwori Design System (`#171717` bold outline, rounded geometry, pastel colors).
* [ ] Application logos remain immediately recognizable.
* [ ] Contains no embedded raster bitmaps (no base64 `data:image`).
* [ ] Filename is lowercase with hyphen delimiters and `.svg` extension.
* [ ] Passes `./scripts/validate.sh` with zero errors.
* [ ] Tested on a live Linux desktop environment (e.g. KDE Plasma or GNOME).

---

## 3. Submitting Icon Requests

If you are not a designer but wish to request an icon, please open a GitHub issue using the **Icon Request** template.
