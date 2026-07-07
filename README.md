# PoliNetwork Document Templates

Sistema di template LaTeX modulare per i documenti ufficiali di **PoliNetwork APS**.
Il layout e' pensato per documenti riutilizzabili e stampabili: pagina bianca,
titolo forte, gerarchia tipografica pulita e footer istituzionale discreto.

## Struttura del progetto

```text
polinetwork-document/
|-- core/                          # Stile e logica
|   |-- polinetwork.cls            # Classe documento principale
|   |-- polinetwork-colors.sty     # Palette colori del brand
|   `-- polinetwork-commands.sty   # Comandi custom
|-- fonts/                         # Font del brand
|-- assets/                        # Logo e asset grafici
|-- documents/                     # Documenti sorgente reali
|-- exported/                      # PDF esportati manualmente
|-- output/                        # PDF compilati localmente
|-- Makefile
`-- README.md
```

Il template corrente usa uno sfondo bianco puro per garantire una buona resa in
stampa. `assets/site-background-soft.png` resta nel repository come asset legacy,
ma non viene applicato ai documenti.

## Prerequisiti

- **XeLaTeX**, incluso in TeX Live o MiKTeX.
- Pacchetti LaTeX: `fontspec`, `xcolor`, `geometry`, `fancyhdr`, `titlesec`,
  `hyperref`, `enumitem`, `tikz`, `microtype`, `parskip`, `setspace`,
  `booktabs`, `longtable`, `lastpage`.

Su Arch Linux:

```bash
sudo pacman -S texlive-basic texlive-latex texlive-latexextra texlive-fontsrecommended texlive-xetex
```

Su Windows con MiKTeX puoi compilare senza `make`:

```powershell
mkdir output
xelatex -interaction=nonstopmode -halt-on-error -output-directory=output documents\PoliNetwork.tex
xelatex -interaction=nonstopmode -halt-on-error -output-directory=output documents\PoliNetwork.tex
```

La doppia esecuzione aggiorna correttamente riferimenti e numero totale di pagine.

## Come compilare i documenti

Da Linux/macOS o da un ambiente Windows con `make` disponibile:

```bash
# Compila tutti i documenti
make all

# Compila solo "Cos'e' PoliNetwork"
make polinetwork

# Compila solo l'informativa privacy recruitment
make privacy-recruitment

# Pulisci i file di log temporanei
make clean
```

Tutti i PDF vengono creati nella cartella `output/`.

## Come creare un nuovo documento

1. Crea un file `.tex` dentro `documents/`, ad esempio `documents/nuovo-progetto.tex`.
2. Usa una delle classi disponibili:

```latex
\documentclass[letter]{core/polinetwork}
\documentclass[legal]{core/polinetwork}
\documentclass[report]{core/polinetwork}
```

3. Imposta almeno `\pnTitle{...}` nel preambolo.
4. Richiama `\pnMakeHeader` dopo `\begin{document}`.
5. Aggiungi il target al `Makefile` se vuoi compilarlo con `make`.

## Comandi disponibili

### Metadati documento

| Comando | Descrizione |
|---------|-------------|
| `\pnTitle{...}` | Titolo del documento |
| `\pnSubtitle{...}` | Sottotitolo opzionale |
| `\pnDocLabel{...}` | Etichetta breve sopra il titolo |
| `\pnDate{...}` | Data |
| `\pnProtocol{...}` | Numero protocollo |
| `\pnSubject{...}` | Oggetto |
| `\pnRecipient{...}` | Destinatario |
| `\pnVersion{...}` | Versione del documento |

### Layout

| Comando | Descrizione |
|---------|-------------|
| `\pnMakeHeader` | Intestazione stampabile con titolo grande, senza data/protocollo nel titolo |
| `\pnMakeMetadata` | Blocco metadati opzionale per data, versione, protocollo, destinatario e oggetto |
| `\pnMakeTitlePage` | Pagina di copertina per report |
| `\pnClosing` | Chiusura con spazio firma |
| `\pnContactBlock` | Blocco contatti finale senza separatori grafici |

Il footer automatico mostra il marchio compatto PoliNetwork, la mail
`direttivo@polinetwork.org` e la numerazione pagina. Il nome resta in Poppins
Medium blu, senza righe orizzontali.

### Sezioni e contenuto

| Comando | Descrizione |
|---------|-------------|
| `\section{...}` | Sezione standard consigliata |
| `\subsection{...}` | Sottosezione standard consigliata |
| `\pnSection{...}` | Sezione custom compatibile con documenti legacy |
| `\pnSubsection{...}` | Sottosezione custom compatibile |
| `\pnNumberedSection{...}` | Sezione numerata custom |
| `\pnArticle{...}` | Articolo numerato per documenti legali |
| `\pnClause{...}` | Comma/clausola dentro un articolo |

### Elementi grafici

| Comando | Descrizione |
|---------|-------------|
| `\pnHighlight{...}` | Testo evidenziato in blu |
| `\pnHighlightBox{...}` | Box informativo leggero |
| `\pnLead{...}` | Paragrafo introduttivo |
| `\pnInfoCard{...}{...}` | Card informativa |
| `\pnRule` | Spaziatore legacy senza riga visibile |
| `\pnWordmark` | Logo testuale "PoliNetwork" |

### Lingua

| Comando | Descrizione |
|---------|-------------|
| `\pnSetItalian` | Stringhe in italiano (default) |
| `\pnSetEnglish` | Stringhe in inglese |

## Opzioni della classe

```latex
\documentclass[letter]{core/polinetwork}     % Documenti comunicativi, senza numeri nei titoli
\documentclass[legal]{core/polinetwork}      % Documenti legali numerati
\documentclass[report]{core/polinetwork}     % Report con copertina e titoli numerati
\documentclass[numbered]{core/polinetwork}   % Forza titoli numerati
\documentclass[unnumbered]{core/polinetwork} % Forza titoli senza numeri
```

Per default il template privilegia la gerarchia visiva: colore, peso e
dimensione distinguono titolo, sezione e sottosezione. La numerazione e'
automatica solo per `legal` e `report`, dove serve citare sezioni e articoli.

## Palette colori

Il branding usa una palette basata su blue, sky, cyan e slate:

| Alias | Uso |
|-------|-----|
| `pn-primary` | Accent principale e link |
| `pn-accent` | Accent leggero |
| `pn-text` | Testo principale |
| `pn-text-secondary` | Testo secondario |
| `pn-text-muted` | Testo di servizio |
| `pn-background` | Colore legacy; il layout stampabile usa bianco puro |

## Font

| Font | Uso | Comando LaTeX |
|------|-----|---------------|
| **DM Sans** | Corpo testo, display | `\dmsansfont` |
| **Poppins** | Titoli, wordmark | `\poppinsfont` |
| **Red Hat Text** | Label, caption, footer | `\redhattextfont` |

## Licenza

(c) PoliNetwork APS - Tutti i diritti riservati.
