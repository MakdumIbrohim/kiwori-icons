.PHONY: all build install uninstall validate clean help

all: build

help:
	@echo "Kiwori Icons Build Interface"
	@echo "Usage:"
	@echo "  make build       - Sinkronkan icon src/ ke theme/Kiwori dan validasi"
	@echo "  make install     - Pasang tema ke ~/.local/share/icons/Kiwori"
	@echo "  make uninstall   - Copot tema dari ~/.local/share/icons/Kiwori"
	@echo "  make validate    - Jalankan linter dan validator aset tema"
	@echo "  make clean       - Bersihkan file build/artefak sementara"

build:
	@./scripts/build.sh

install:
	@./scripts/install.sh

uninstall:
	@./scripts/uninstall.sh

validate:
	@./scripts/validate.sh

clean:
	@find theme/Kiwori/scalable -type f -name "*.svg" -delete 2>/dev/null || true
	@find theme/Kiwori/scalable -type l -name "*.svg" -delete 2>/dev/null || true
	@rm -rf build/ dist/ *.tar.gz *.tar.xz
	@echo "Artefak build berhasil dibersihkan."
