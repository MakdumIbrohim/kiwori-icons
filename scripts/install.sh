#!/usr/bin/env bash
set -euo pipefail

THEME_NAME="Kiwori"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$ROOT_DIR/theme/$THEME_NAME"

SYSTEM_INSTALL=false
INSTALL_MODE="copy" # options: "copy", "link", "git-update"
PROMPTED=false

# Kiwori Palette ANSI Colors
PURPLE="\033[38;2;185;130;255m"
CYAN="\033[38;2;94;216;210m"
YELLOW="\033[38;2;255;228;119m"
ORANGE="\033[38;2;255;160;38m"
GREEN="\033[38;2;115;214;154m"
PEACH="\033[38;2;255;230;168m"
RED="\033[38;2;255;107;107m"
BOLD="\033[1m"
DIM="\033[2m"
RESET="\033[0m"

log_info() {
    printf " ${BOLD}${CYAN}[INFO]${RESET} %s\n" "$1"
}

log_ok() {
    printf " ${BOLD}${GREEN}[OK]${RESET}   %s\n" "$1"
}

log_warn() {
    printf " ${BOLD}${YELLOW}[WARN]${RESET} %s\n" "$1"
}

log_err() {
    printf " ${BOLD}${RED}[ERR]${RESET}  %s\n" "$1"
}

# Argument parsing
while [[ $# -gt 0 ]]; do
    case "$1" in
        --system|-s)
            SYSTEM_INSTALL=true
            shift
            ;;
        --local|-l)
            INSTALL_MODE="copy"
            PROMPTED=true
            shift
            ;;
        --link)
            INSTALL_MODE="link"
            PROMPTED=true
            shift
            ;;
        --git-update|-u)
            INSTALL_MODE="git-update"
            PROMPTED=true
            shift
            ;;
        -h|--help)
            echo "Usage: ./scripts/install.sh [OPTIONS]"
            echo
            echo "Options:"
            echo "  --local, -l       Install as local copy from this folder (static, offline)"
            echo "  --link            Install as live symlink (auto-reflects updates on git pull)"
            echo "  --git-update, -u  Pull latest commits from GitHub before installing"
            echo "  --system, -s      Install system-wide into /usr/share/icons/ (requires root)"
            echo "  --help, -h        Display this help dialog"
            exit 0
            ;;
        *)
            log_err "Unknown option: $1"
            echo "Run './scripts/install.sh --help' for usage."
            exit 1
            ;;
    esac
done

# If no mode flag was passed and running interactively in terminal, show the banner & ask
if [[ "$PROMPTED" == false && -t 0 ]]; then
    echo
    echo -e "${PURPLE}    ╭─────╮         ${CYAN}${BOLD}_  ___                     _   ___                      ${RESET}"
    echo -e "${PURPLE}    │ ╭───╯        ${CYAN}${BOLD}| |/ (_)_      _____  _ __ (_) |_ _|___ ___  _ __  ___   ${RESET}"
    echo -e "${PURPLE}  ╭─┴─┴───╮        ${CYAN}${BOLD}| ' /| \ \ /\ / / _ \| '__|| |  | |/ __/ _ \| '_ \/ __|  ${RESET}"
    echo -e "${PURPLE} ╭╯ ${PEACH}\_/\_/ ${PURPLE}╰╮      ${CYAN}${BOLD}| . \| |\ V  V / (_) | |   | |  | | (_| (_) | | | \__ \  ${RESET}"
    echo -e "${PURPLE} │ ${PEACH}( ${BOLD}>  < ${RESET}${PEACH}) ${PURPLE}│      ${CYAN}${BOLD}|_|\_\_| \_/\_/ \___/|_|   |_| |___\___\___/|_| |_|___/  ${RESET}"
    echo -e "${PURPLE} │ ${PEACH}  (◡)   ${PURPLE}│      ${DIM}───────────────────────────────────────────────────────${RESET}"
    echo -e "${PURPLE} ╰───┬──┬───╯            ${YELLOW}Playful Cartoon Icon Theme for Linux Desktops${RESET}"
    echo -e "   ${PEACH}( ${ORANGE}[📁] ${PEACH})   ${RESET}"
    echo
    echo -e " ${BOLD}${CYAN}╭─────────────────────────────────────────────────────────────╮${RESET}"
    echo -e " ${BOLD}${CYAN}│${RESET}  ${BOLD}Choose Installation Method:${RESET}                                ${BOLD}${CYAN}│${RESET}"
    echo -e " ${BOLD}${CYAN}├─────────────────────────────────────────────────────────────┤${RESET}"
    echo -e " ${BOLD}${CYAN}│${RESET}                                                             ${BOLD}${CYAN}│${RESET}"
    echo -e " ${BOLD}${CYAN}│${RESET}  ${BOLD}${GREEN}1)${RESET} ${BOLD}Local Folder Copy${RESET} ${DIM}(Default)${RESET}                               ${BOLD}${CYAN}│${RESET}"
    echo -e " ${BOLD}${CYAN}│${RESET}     Copy files directly from this folder to your system.    ${BOLD}${CYAN}│${RESET}"
    echo -e " ${BOLD}${CYAN}│${RESET}     ${DIM}Static offline installation                             ${BOLD}${CYAN}│${RESET}"
    echo -e " ${BOLD}${CYAN}│${RESET}                                                             ${BOLD}${CYAN}│${RESET}"
    echo -e " ${BOLD}${CYAN}│${RESET}  ${BOLD}${YELLOW}2)${RESET} ${BOLD}Live Git Symlink${RESET}                                        ${BOLD}${CYAN}│${RESET}"
    echo -e " ${BOLD}${CYAN}│${RESET}     Link theme directly to this git clone via symlinks.     ${BOLD}${CYAN}│${RESET}"
    echo -e " ${BOLD}${CYAN}│${RESET}     ${DIM}Automatically updates whenever you run 'git pull'        ${BOLD}${CYAN}│${RESET}"
    echo -e " ${BOLD}${CYAN}│${RESET}                                                             ${BOLD}${CYAN}│${RESET}"
    echo -e " ${BOLD}${CYAN}│${RESET}  ${BOLD}${PURPLE}3)${RESET} ${BOLD}Pull Latest from GitHub & Install${RESET}                       ${BOLD}${CYAN}│${RESET}"
    echo -e " ${BOLD}${CYAN}│${RESET}     Fetch newest upstream commits from GitHub before install${BOLD}${CYAN}│${RESET}"
    echo -e " ${BOLD}${CYAN}│${RESET}                                                             ${BOLD}${CYAN}│${RESET}"
    echo -e " ${BOLD}${CYAN}╰─────────────────────────────────────────────────────────────╯${RESET}"
    echo
    read -r -p " Enter choice [1-3] (default: 1): " USER_CHOICE
    case "$USER_CHOICE" in
        2)
            INSTALL_MODE="link"
            ;;
        3)
            INSTALL_MODE="git-update"
            ;;
        *)
            INSTALL_MODE="copy"
            ;;
    esac
    echo
fi

# Pull latest changes if requested
if [[ "$INSTALL_MODE" == "git-update" ]]; then
    if [[ -d "$ROOT_DIR/.git" ]]; then
        log_info "Pulling latest updates from GitHub repository..."
        BRANCH="$(cd "$ROOT_DIR" && git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "main")"
        (cd "$ROOT_DIR" && git pull origin "$BRANCH") || log_warn "git pull failed, continuing with local files."
    else
        log_warn "Not a git repository, skipping git pull."
    fi
fi

if [[ "$SYSTEM_INSTALL" == true ]]; then
    if [[ $EUID -ne 0 ]]; then
        log_err "System-wide installation requires root privileges (sudo)."
        exit 1
    fi
    TARGET_DIR="/usr/share/icons/$THEME_NAME"
    TARGET_DARK_DIR="/usr/share/icons/${THEME_NAME}-Dark"
    BASE_DIR="/usr/share/icons"
else
    TARGET_DIR="$HOME/.local/share/icons/$THEME_NAME"
    TARGET_DARK_DIR="$HOME/.local/share/icons/${THEME_NAME}-Dark"
    BASE_DIR="$HOME/.local/share/icons"
fi

log_info "Preparing installation for $THEME_NAME & ${THEME_NAME}-Dark..."
log_info "Selected mode: $INSTALL_MODE"

if [[ ! -d "$SOURCE_DIR" || ! -f "$SOURCE_DIR/index.theme" ]]; then
    log_info "Theme build artifacts missing. Building now..."
    "$ROOT_DIR/scripts/build.sh"
fi

mkdir -p "$BASE_DIR"

log_info "Removing previous installations..."
rm -rf "$TARGET_DIR" "$TARGET_DARK_DIR"

if [[ "$INSTALL_MODE" == "link" ]]; then
    log_info "Linking theme directories directly to repository..."
    ln -sf "$ROOT_DIR/theme/Kiwori" "$TARGET_DIR"
    if [[ -d "$ROOT_DIR/theme/Kiwori-Dark" ]]; then
        ln -sf "$ROOT_DIR/theme/Kiwori-Dark" "$TARGET_DARK_DIR"
    fi
    log_ok "Live symlinks created."
else
    log_info "Copying theme files to $BASE_DIR..."
    cp -dr "$ROOT_DIR/theme/Kiwori" "$BASE_DIR/"
    if [[ -d "$ROOT_DIR/theme/Kiwori-Dark" ]]; then
        cp -dr "$ROOT_DIR/theme/Kiwori-Dark" "$BASE_DIR/"
    fi
    log_ok "Files copied successfully."
fi

log_info "Updating desktop icon caches..."
for dir in "$TARGET_DIR" "$TARGET_DARK_DIR"; do
    if [[ -e "$dir" ]]; then
        if command -v gtk-update-icon-cache >/dev/null 2>&1; then
            gtk-update-icon-cache -q -t -f "$dir" || true
        fi
    fi
done

if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 --noincremental >/dev/null 2>&1 || true
elif command -v kbuildsycoca5 >/dev/null 2>&1; then
    kbuildsycoca5 --noincremental >/dev/null 2>&1 || true
fi
log_ok "Desktop icon cache updated."

echo
echo -e " ${BOLD}${GREEN}╭─────────────────────────────────────────────────────────────╮${RESET}"
echo -e " ${BOLD}${GREEN}│${RESET}  ${BOLD}${GREEN}✨ Kiwori & Kiwori Dark Installed Successfully!${RESET}            ${BOLD}${GREEN}│${RESET}"
echo -e " ${BOLD}${GREEN}├─────────────────────────────────────────────────────────────┤${RESET}"
echo -e " ${BOLD}${GREEN}│${RESET}  ${BOLD}Locations:${RESET}                                                 ${BOLD}${GREEN}│${RESET}"
echo -e " ${BOLD}${GREEN}│${RESET}    • Standard (Light): ${CYAN}$TARGET_DIR${RESET}"
echo -e " ${BOLD}${GREEN}│${RESET}    • Dark Mode:        ${CYAN}$TARGET_DARK_DIR${RESET}"
echo -e " ${BOLD}${GREEN}│${RESET}                                                             ${BOLD}${GREEN}│${RESET}"
echo -e " ${BOLD}${GREEN}│${RESET}  ${BOLD}How to Activate:${RESET}                                           ${BOLD}${GREEN}│${RESET}"
echo -e " ${BOLD}${GREEN}│${RESET}    • Light desktop: ${YELLOW}System Settings → Icons → Kiwori${RESET}        ${BOLD}${GREEN}│${RESET}"
echo -e " ${BOLD}${GREEN}│${RESET}    • Dark desktop:  ${YELLOW}System Settings → Icons → Kiwori Dark${RESET}   ${BOLD}${GREEN}│${RESET}"
echo -e " ${BOLD}${GREEN}╰─────────────────────────────────────────────────────────────╯${RESET}"
echo
