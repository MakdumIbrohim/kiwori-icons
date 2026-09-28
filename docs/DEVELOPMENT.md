# Development Guide

Reference guide for developers, maintainers, and packaging contributors.

---

## 1. Tooling & Environment

* **Vector Editors**: Inkscape, Figma, or Adobe Illustrator (export as clean standard SVG without proprietary tags).
* **SVG Optimizers**: `scour` or `svgo` (optional for path compression prior to release).
* **Terminal Environment**: Bash or Zsh with standard Linux utilities (`find`, `grep`, `coreutils`).
* **Test Environments**: KDE Plasma 5/6, GNOME 40+, XFCE, or any FreeDesktop/XDG-compliant window manager.

---

## 2. Local Development Cycle

1. **Author icons in `src/`**:
   Place master SVG files in `src/<category>/<icon-name>.svg`.
2. **Build and Validate**:
   ```bash
   make build
   ```
   Synchronizes assets to `theme/Kiwori/scalable/` and runs static validation.
3. **Install Locally**:
   ```bash
   make install
   ```
   Deploys to `~/.local/share/icons/Kiwori/` and refreshes the desktop icon cache.
4. **Activate Theme**:
   * **KDE Plasma**: **System Settings** → **Colors & Themes** → **Icons** → Select **Kiwori**.
   * **GNOME**: **GNOME Tweaks** → **Appearance** → **Icons** → Select **Kiwori**.
   * **XFCE**: **Settings** → **Appearance** → **Icons** → Select **Kiwori**.
5. **Forced Cache Invalidation**:
   If changes do not render immediately:
   ```bash
   gtk-update-icon-cache -f -t ~/.local/share/icons/Kiwori
   kbuildsycoca6 --noincremental
   ```

---

## 3. Release Process

1. Ensure the validation suite passes:
   ```bash
   make validate
   ```
2. Merge the `dev` branch into `main`.
3. Create a Git tag adhering to Semantic Versioning:
   ```bash
   git tag -a v1.0.0 -m "Release Kiwori Icons v1.0.0"
   git push origin v1.0.0
   ```
4. Package the release tarball:
   ```bash
   tar -czvf Kiwori-v1.0.0.tar.gz -C theme Kiwori
   ```
