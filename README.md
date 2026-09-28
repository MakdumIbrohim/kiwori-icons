<div align="center">

<img src="preview/mascot.svg" width="180" alt="Kiwori-chan mascot" />

# Kiwori Icons

[![License](https://img.shields.io/badge/license-GPL--3.0-blue.svg)](LICENSE.md)
[![Linux](https://img.shields.io/badge/platform-Linux-1793D1.svg)]()
[![SVG](https://img.shields.io/badge/format-SVG-FF8FB1.svg)]()
[![Repo Size](https://img.shields.io/github/repo-size/MakdumIbrohim/kiwori-icons.svg)]()

Pastel cartoon icon theme for Linux.

</div>

---

<div align="center">

## Applications

<img src="preview/applications.png" width="552" alt="Application icons" />

## Folders

<img src="preview/folders.png" width="560" alt="Folder icons" />

## File Types

<img src="preview/mimetypes.png" width="700" alt="File type icons" />

## Launchers

<img src="preview/launchers.png" width="550" alt="Distro launcher icons" />

</div>

---

## Install

User-local install (no root needed):

```bash
git clone https://github.com/MakdumIbrohim/kiwori-icons.git
cd kiwori-icons
./scripts/install.sh
```

Options:

```bash
./scripts/install.sh --system   # system-wide to /usr/share/icons (needs sudo)
./scripts/install.sh --help     # show usage
```

Switch the start-menu launcher icon (ubuntu, kubuntu, arch, debian, kde, fedora, kiwori):

```bash
./scripts/set-launcher.sh arch
```

Uninstall:

```bash
./scripts/uninstall.sh
```

Activate: **System Settings → Colors & Themes → Icons → Kiwori → Apply**.

---

## Docs

* [Design Guidelines](docs/DESIGN.md)
* [Icon Naming](docs/ICON-NAMING.md)
* [Development](docs/DEVELOPMENT.md)
* [Contributing](docs/CONTRIBUTING.md)

## License

[GPL-3.0](LICENSE.md). Third-party logos belong to their respective owners, used for desktop interoperability under fair use.
