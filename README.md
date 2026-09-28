# Kiwori Icons

Kiwori Icons is an open-source Linux desktop icon theme featuring a **colorful, pastel, playful, cartoon-inspired, rounded, and bold black outline** visual style.

Designed with a distinct aesthetic identity, Kiwori brings modern cartoon sticker vibrancy to the Linux desktop while keeping application logos and identities instantly recognizable.

---

## Preview

![Kiwori Preview Overview](preview/overview.png)

*(Icon previews and mockups are located in the `preview/` directory)*

---

## Key Characteristics & Features

* **Pastel & Colorful**: Harmonious blend of soft pastel bases and vivid saturated accents.
* **Rounded Shapes**: Friendly, soft-cornered geometry without harsh sharp angles.
* **Bold Black Outline**: High-contrast, dark charcoal outline (`#171717`) defining each silhouette and sub-element.
* **Scalable Vector**: 100% SVG-based (`256×256` master artboard), rendering crisply across all display resolutions and HiDPI scales.
* **FreeDesktop/XDG Compliant**: Adheres to modern Linux icon theme standards with automated fallback inheritance to `hicolor`.

---

## Supported Desktop Environments

The primary development target is **KDE Plasma**, while maintaining full compatibility with all FreeDesktop-compliant desktop environments:
* **KDE Plasma** (Dolphin, Konsole, System Settings, Discover)
* **GNOME**
* **XFCE**
* **Cinnamon**
* **MATE**
* **LXQt**

---

## Installation

### Method 1: Git Installation (User-Local, Recommended)

Run the following commands in your terminal:

```bash
git clone https://github.com/makdumibrohim/kiwori-icons.git
cd kiwori-icons
./scripts/install.sh
```

Installs directly to `~/.local/share/icons/Kiwori/` without requiring `sudo` privileges.

### Method 2: Using Makefile

```bash
make install
```

### Method 3: System-Wide Installation (Optional)

To install for all users across the operating system:

```bash
sudo ./scripts/install.sh --system
```

---

## Applying the Theme

After installation, activate Kiwori in your desktop settings:

* **KDE Plasma**:
  Open **System Settings** → **Colors & Themes** → **Icons** → Select **Kiwori** → Click **Apply**.
* **GNOME**:
  Open **GNOME Tweaks** → **Appearance** → **Icons** → Select **Kiwori**.
* **XFCE**:
  Open **Settings** → **Appearance** → **Icons** → Select **Kiwori**.

---

## Uninstallation

Run the uninstall script:

```bash
./scripts/uninstall.sh
```

Or via `make`:

```bash
make uninstall
```

---

## Development

Build and validate the theme locally:

```bash
# Validate SVG integrity and index.theme configuration
make validate

# Build distribution theme to theme/Kiwori/
make build

# Clean build artifacts
make clean
```

Detailed technical and design documentation:
* [Design Guidelines (docs/DESIGN.md)](docs/DESIGN.md)
* [Icon Naming Conventions (docs/ICON-NAMING.md)](docs/ICON-NAMING.md)
* [Development Guide (docs/DEVELOPMENT.md)](docs/DEVELOPMENT.md)
* [Contributing Guide (docs/CONTRIBUTING.md)](docs/CONTRIBUTING.md)

---

## Contributing

Contributions of new application icons, bug reports, and design refinements are welcome! Please review [CONTRIBUTING.md](docs/CONTRIBUTING.md) for branch guidelines (`dev`), quality standards, and pull request procedures.

---

## License & Trademark Notice

### License
Kiwori Icons is licensed under the [GNU General Public License v3.0 (GPL-3.0)](LICENSE.md).

### Trademark & Non-Affiliation Notice
All third-party product names, logos, brands, and registered trademarks depicted or referenced within this icon theme remain the property of their respective owners. Their inclusion serves strictly for Linux desktop interoperability and integration under fair use, and does not imply sponsorship, affiliation, or endorsement.
