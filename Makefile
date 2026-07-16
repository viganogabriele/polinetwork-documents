# =====================================================================
# Makefile — PoliNetwork Document Templates
# =====================================================================
#
# Prerequisiti: XeLaTeX (da TeX Live)
#   sudo apt install texlive-xetex texlive-fonts-recommended texlive-latex-extra
#
# Uso:
#   make help                 Mostra tutti i target disponibili
#   make privacy-recruitment  Compila la privacy policy del recruitment
#   make about                Compila il documento "Cos'è PoliNetwork"
#   make all                  Compila tutti i documenti
#   make clean                Pulisce i file ausiliari
#
# =====================================================================

XELATEX = xelatex
XELATEX_FLAGS = -interaction=nonstopmode -halt-on-error

# Root directory (per TEXINPUTS)
ROOT_DIR := $(shell pwd)
OUT_DIR := $(ROOT_DIR)/output

# TEXINPUTS permette a XeLaTeX di trovare i file .cls, .sty, font e assets
# ovunque si compili — è la "magia" che tiene tutto collegato
TEXINPUTS_VAL = $(ROOT_DIR)/core:$(ROOT_DIR):

# Macro per compilare un documento (2 passate per riferimenti corretti)
# Uso: $(call compile,<directory>,<filename senza .tex>)
define compile
	@mkdir -p $(OUT_DIR)
	TEXINPUTS="$(TEXINPUTS_VAL)" $(XELATEX) $(XELATEX_FLAGS) -output-directory="$(OUT_DIR)" $(1)/$(2).tex
	TEXINPUTS="$(TEXINPUTS_VAL)" $(XELATEX) $(XELATEX_FLAGS) -output-directory="$(OUT_DIR)" $(1)/$(2).tex
	@echo "✓ Generato: output/$(2).pdf"
endef

# =====================================================================
# TARGET PRINCIPALI
# =====================================================================

.PHONY: all clean clean-pdf help

help: ## Mostra questo aiuto
	@echo ""
	@echo "  PoliNetwork Document Templates — Build System"
	@echo "  =============================================="
	@echo ""
	@echo "  Documenti:"
	@echo "    make privacy-recruitment    Privacy policy recruitment"
	@echo "    make polinetwork            Cos'è PoliNetwork (versione pubblica)"
	@echo ""
	@echo "  Utility:"
	@echo "    make all                    Compila tutti i documenti"
	@echo "    make clean                  Pulisce file ausiliari (.aux, .log, ecc.)"
	@echo "    make clean-pdf              Pulisce anche i PDF generati"
	@echo ""
	@echo "  Prerequisiti (Arch Linux): sudo pacman -S texlive-basic texlive-latex texlive-latexextra texlive-fontsrecommended texlive-xetex"
	@echo ""

# =====================================================================
# DOCUMENTI
# =====================================================================

privacy-recruitment: ## Privacy policy per il recruitment
	$(call compile,documents,informativa-privacy-recruitment)

guida: # Guida della matricola
	$(call compile,documents,guida-della-matricola)

pubblica: polinetwork # alias
polinetwork: ## Cos'è PoliNetwork
	$(call compile,documents,PoliNetwork)

# --- Aggiungi qui nuovi documenti ---
# esempio:
# privacy-sito: ## Privacy policy del sito web
# 	$(call compile,documents,privacy-policy-sito)

all: privacy-recruitment polinetwork ## Compila tutti i documenti

# =====================================================================
# PULIZIA
# =====================================================================

clean: ## Rimuovi file ausiliari
	find . \( -name '*.aux' -o -name '*.log' -o -name '*.out' -o -name '*.toc' \
	       -o -name '*.fls' -o -name '*.fdb_latexmk' -o -name '*.synctex.gz' \) \
	       -delete 2>/dev/null || true
	@echo "✓ File ausiliari rimossi"

clean-pdf: clean ## Rimuovi anche i PDF generati
	rm -rf $(OUT_DIR)/*.pdf 2>/dev/null || true
	@echo "✓ PDF rimossi dalla cartella output"
