<div align="center">

<img src="preview/mascot.svg" width="180" alt="Kiwori-chan mascot" />

# Kiwori Icons

[![License](https://img.shields.io/badge/license-GPL--3.0-blue.svg?logo=gnu&logoColor=white)](LICENSE.md)
[![Linux](https://img.shields.io/badge/platform-Linux-1793D1.svg?logo=linux&logoColor=white)]()
[![SVG](https://img.shields.io/badge/format-SVG-FF8FB1.svg?logo=svg&logoColor=white)]()
[![Repo Size](https://img.shields.io/github/repo-size/MakdumIbrohim/kiwori-icons.svg?logo=github&logoColor=white)]()

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

Run the interactive installer:

```bash
git clone https://github.com/MakdumIbrohim/kiwori-icons.git
cd kiwori-icons
./scripts/install.sh
```

Installation modes:

```bash
./scripts/install.sh --local        # 1) Static offline copy from local folder (default)
./scripts/install.sh --link         # 2) Live git symlink (auto-reflects updates on git pull)
./scripts/install.sh --git-update   # 3) Pull latest commits from GitHub before installing
./scripts/install.sh --system       # System-wide install to /usr/share/icons (needs sudo)
```

Update to latest version anytime:

```bash
./scripts/update.sh   # or 'make update'
```

Switch the start-menu launcher icon (ubuntu, kubuntu, arch, debian, kde, fedora, kiwori):

```bash
./scripts/set-launcher.sh arch
```

Uninstall:

```bash
./scripts/uninstall.sh
```

Activate:
* Light desktop: **System Settings → Colors & Themes → Icons → Kiwori → Apply**.
* Dark desktop: **System Settings → Colors & Themes → Icons → Kiwori Dark → Apply**.

---

## Docs

* [Design Guidelines](docs/DESIGN.md)
* [Icon Naming](docs/ICON-NAMING.md)
* [Development](docs/DEVELOPMENT.md)
* [Contributing](docs/CONTRIBUTING.md)

---

## Requests & Issues

Open an issue on GitHub using the matching prefix:

* `[ICON REQUEST] <App Name>` — Request a new icon
* `[BUG] <Short Description>` — Report visual or theme issues
* `[SYMLINK REQUEST] <App Name>` — Add missing desktop launcher alias
* `[LAUNCHER REQUEST] <Distro Name>` — Request start-menu distro icon

## License

[GPL-3.0](LICENSE.md). Third-party logos belong to their respective owners, used for desktop interoperability under fair use.
