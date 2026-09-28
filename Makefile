.PHONY: all build install uninstall update validate clean set-launcher help

all: build

help:
	@echo "Kiwori Icons Build Interface"
	@echo "Usage:"
	@echo "  make build               - Synchronize src/ icons to theme/Kiwori and validate"
	@echo "  make install             - Install theme to ~/.local/share/icons/Kiwori"
	@echo "  make update              - Pull latest commits from GitHub and reinstall"
	@echo "  make uninstall           - Remove theme from ~/.local/share/icons/Kiwori"
	@echo "  make validate            - Run static linter and validation checks"
	@echo "  make set-launcher NAME=  - Switch start menu icon (e.g. NAME=ubuntu, arch, kde, kiwori)"
	@echo "  make clean               - Remove build artifacts and temporary files"

build:
	@./scripts/build.sh

install:
	@./scripts/install.sh

update:
	@./scripts/update.sh

uninstall:
	@./scripts/uninstall.sh

validate:
	@./scripts/validate.sh

set-launcher:
	@./scripts/set-launcher.sh $(NAME)

clean:
	@find theme/Kiwori/scalable -type f -name "*.svg" -delete 2>/dev/null || true
	@find theme/Kiwori/scalable -type l -name "*.svg" -delete 2>/dev/null || true
	@rm -rf build/ dist/ *.tar.gz *.tar.xz
	@echo "Build artifacts successfully cleaned."
