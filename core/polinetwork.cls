%% polinetwork.cls
%% PoliNetwork APS — Document Class
%% 
%% Modular LaTeX class inspired by Awesome-CV structure.
%% Supports XeLaTeX and LuaLaTeX via fontspec.
%%
%% Usage:
%%   \documentclass[legal]{polinetwork}    % for legal documents (privacy, T&C)
%%   \documentclass[letter]{polinetwork}   % for letters
%%   \documentclass[report]{polinetwork}   % for reports with title page
%%   \documentclass[numbered]{polinetwork} % force numbered headings
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{polinetwork}[2026/04/01 PoliNetwork APS Document Class v1.0]

% Overleaf can end up loading the class more than once when the main file and
% class/package paths are resolved through different relative paths. Guard
% against a second load to avoid duplicate command errors.
\expandafter\ifx\csname pn@classloaded\endcsname\relax
  \expandafter\gdef\csname pn@classloaded\endcsname{}
\else
  \endinput
\fi

%% ========================================================================
%% CLASS OPTIONS
%% ========================================================================

\newif\if@pnletter   \@pnletterfalse
\newif\if@pnreport   \@pnreportfalse
\newif\if@pnlegal    \@pnlegalfalse
\newif\if@pnnumbered \@pnnumberedfalse
\newif\if@pnunnumbered \@pnunnumberedfalse

\DeclareOption{letter}{\@pnlettertrue}
\DeclareOption{report}{\@pnreporttrue}
\DeclareOption{legal}{\@pnlegaltrue}
\DeclareOption{numbered}{\@pnnumberedtrue}
\DeclareOption{unnumbered}{\@pnunnumberedtrue}

% Pass all unknown options to article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% Base class
\LoadClass[a4paper, 11pt]{article}

%% ========================================================================
%% REQUIRED PACKAGES
%% ========================================================================

% Page geometry
\RequirePackage[
  a4paper,
  top=2.5cm,
  bottom=3.0cm,
  left=2.5cm,
  right=2.5cm,
  headheight=1.5cm,
  headsep=0.8cm,
  footskip=1.45cm
]{geometry}

% Font support (XeLaTeX / LuaLaTeX)
\RequirePackage{fontspec}
\RequirePackage{eurosym}
\RequirePackage{unicode-math}

% Typography
% With XeLaTeX and TU-encoded OpenType fonts, protrusion triggers a large
% amount of harmless warnings on Overleaf. Keep microtype enabled for spacing
% and kerning, but disable protrusion for a cleaner build log.
\RequirePackage[protrusion=false]{microtype}
\RequirePackage{setspace}
\RequirePackage{parskip}

% Graphics
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{eso-pic}
\usetikzlibrary{calc}

% Tables
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{array}

% Lists
\RequirePackage{enumitem}

% Links
\RequirePackage[
  colorlinks=true,
  linkcolor=pn-link,
  urlcolor=pn-link,
  citecolor=pn-primary,
  bookmarks=true,
  bookmarksnumbered=false
]{hyperref}
\RequirePackage{bookmark}

% Header/Footer
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}

% Conditionals
\RequirePackage{ifthen}
\RequirePackage{xifthen}

%% ========================================================================
%% LOAD POLINETWORK PACKAGES
%% ========================================================================

\RequirePackage{polinetwork-colors}
\RequirePackage{polinetwork-commands}

%% ========================================================================
%% PAGE BACKGROUND
%% ========================================================================

\newcommand{\pnPageBackground}{%
  \begin{tikzpicture}[remember picture,overlay]
    \fill[white] (current page.south west) rectangle (current page.north east);
  \end{tikzpicture}%
}

%% ========================================================================
%% FONT CONFIGURATION
%% ========================================================================

% DM Sans — primary body/display font
\newfontfamily\dmsansfont{DMSans}[
  Path           = fonts/,
  Extension      = .ttf,
  UprightFont    = *-Variable,
  BoldFont       = *-Variable,
  ItalicFont     = *-Variable-Italic,
  BoldItalicFont = *-Variable-Italic,
  UprightFeatures= {NamedInstance=Regular},
  BoldFeatures   = {NamedInstance=Bold},
  ItalicFeatures = {NamedInstance=Italic},
  BoldItalicFeatures = {NamedInstance=Bold Italic},
]

% Poppins — headlines & wordmark
\newfontfamily\poppinsfont{Poppins}[
  Path           = fonts/,
  Extension      = .ttf,
  UprightFont    = *-Regular,
  BoldFont       = *-Bold,
  ItalicFont     = *-Italic,
  BoldItalicFont = *-MediumItalic,
  FontFace       = {m}{n}{*-Medium},
  FontFace       = {sb}{n}{*-SemiBold},
]

\newfontfamily\poppinsmedium{Poppins-Medium}[
  Path           = fonts/,
  Extension      = .ttf,
]

% Red Hat Text — labels, captions, small text
\newfontfamily\redhattextfont{RedHatText}[
  Path           = fonts/,
  Extension      = .ttf,
  UprightFont    = *-Variable,
  BoldFont       = *-Variable,
  ItalicFont     = *-Variable-Italic,
  BoldItalicFont = *-Variable-Italic,
  UprightFeatures= {NamedInstance=Regular},
  BoldFeatures   = {NamedInstance=Bold},
  ItalicFeatures = {NamedInstance=Italic},
  BoldItalicFeatures = {NamedInstance=Bold Italic},
]

% Set main document fonts
\setmainfont{DMSans}[
  Path           = fonts/,
  Extension      = .ttf,
  UprightFont    = *-Variable,
  BoldFont       = *-Variable,
  ItalicFont     = *-Variable-Italic,
  BoldItalicFont = *-Variable-Italic,
  UprightFeatures= {NamedInstance=Regular},
  BoldFeatures   = {NamedInstance=Bold},
  ItalicFeatures = {NamedInstance=Italic},
  BoldItalicFeatures = {NamedInstance=Bold Italic},
]

% Aliases for use in commands.sty
\let\headlinefont\poppinsfont
\let\labelfont\redhattextfont

%% ========================================================================
%% PARAGRAPH & SPACING
%% ========================================================================

\setlength{\parindent}{0pt}
\setlength{\parskip}{6pt plus 1pt minus 1pt}
\setstretch{1.2}
% Tolleranza per giustificazione testo (riduce Overfull \hbox)
\tolerance=1000
\emergencystretch=3em
\raggedbottom

% Line color for body text
\color{pn-text}

%% ========================================================================
%% SECTION STYLING  
%% ========================================================================

\RequirePackage{titlesec}

\titleformat{\section}
  {\Large\poppinsfont\bfseries\color{pn-primary}}
  {\ifnum\value{secnumdepth}>-1\relax\thesection\hspace{0.65em}\fi}
  {0pt}
  {}
 
\titleformat{\subsection}
  {\large\poppinsfont\fontseries{sb}\selectfont\color{pn-text}}
  {\ifnum\value{secnumdepth}>0\relax\thesubsection\hspace{0.55em}\fi}
  {0pt}
  {}

\titleformat{\subsubsection}
  {\normalsize\poppinsfont\fontseries{sb}\selectfont\color{pn-text-secondary}}
  {\ifnum\value{secnumdepth}>1\relax\thesubsubsection\hspace{0.5em}\fi}
  {0pt}
  {}

% Spacing
\titlespacing*{\section}{0pt}{30pt plus 4pt minus 2pt}{12pt}
\titlespacing*{\subsection}{0pt}{18pt plus 2pt minus 1pt}{8pt}
\titlespacing*{\subsubsection}{0pt}{12pt plus 2pt minus 1pt}{6pt}

%% ========================================================================
%% LIST STYLING
%% ========================================================================

\setlist{
  leftmargin=1.5em,
  itemsep=4pt,
  parsep=0pt,
  topsep=6pt,
}

% Awesome-CV style itemize: simple clean bullet
\setlist[itemize]{
  label={\footnotesize\textcolor{pn-primary}{\textbullet}},
  leftmargin=2em
}

\setlist[enumerate]{
  label={\textcolor{pn-text}{\arabic*.}},
}

\setlist[description]{
  font=\normalfont\color{pn-primary}\bfseries,
}

%% ========================================================================
%% HEADER / FOOTER (fancyhdr)
%% ========================================================================

\pagestyle{fancy}
\fancyhf{} % clear defaults

% Footer on all pages
\newcommand{\pnFooterIdentity}{%
  \begin{tabular}[c]{@{}l@{}}
    \raisebox{-0.5\height}{\pnInsertLogo[0.40cm]}%
    \hspace{4.5pt}%
    \raisebox{-0.5\height}{{\fontsize{8.2pt}{9.2pt}\selectfont\poppinsmedium\color{pn-primary}PoliNetwork}}\\[-1.7pt]
    {\fontsize{6.6pt}{7.6pt}\selectfont\poppinsfont\color{pn-text}%
      \href{mailto:direttivo@polinetwork.org}{\textcolor{pn-text}{direttivo@polinetwork.org}}}
  \end{tabular}%
}

\fancyfoot[L]{\pnFooterIdentity}
\fancyfoot[R]{%
  \footnotesize\poppinsmedium\color{pn-text}%
  \pn@str@page~\thepage~\pn@str@of~\pageref*{LastPage}%
}

% Rule styling
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% First page style: no running header
\fancypagestyle{firstpage}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot[L]{\pnFooterIdentity}
  \fancyfoot[R]{%
    \footnotesize\poppinsmedium\color{pn-text}%
    \pn@str@page~\thepage~\pn@str@of~\pageref*{LastPage}%
  }
  \renewcommand{\footrulewidth}{0pt}
}

% Title page style (no header/footer)
\fancypagestyle{titlepage}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

%% ========================================================================
%% HYPERREF METADATA
%% ========================================================================

\AtBeginDocument{%
  \AddToShipoutPictureBG{\pnPageBackground}%
  \hypersetup{
    pdftitle={\pn@doctitle},
    pdfauthor={\pn@associationname},
    pdfsubject={\pn@docsubject},
    pdfcreator={XeLaTeX with polinetwork.cls},
  }%
}

%% ========================================================================
%% CONVENIENCE: AUTO-SETUP BASED ON DOCUMENT TYPE
%% ========================================================================

% Default: communication-oriented documents use visual hierarchy instead of
% numbered headings. Legal/report documents opt into numbering automatically.
\setcounter{secnumdepth}{-1}

% Legal documents (privacy, T&C): use numbered sections, no title page
\if@pnlegal
  % Enable paragraph numbering for legal docs
  \setcounter{secnumdepth}{3}
\fi

% Reports: will use \pnMakeTitlePage
\if@pnreport
  \setcounter{secnumdepth}{3}
\fi

% Letters: simpler layout
\if@pnletter
  % Tighter margins for letters
  \geometry{top=2cm, bottom=3.0cm, left=2.5cm, right=2.5cm, footskip=1.45cm}
\fi

% Explicit overrides for reusable edge cases.
\if@pnnumbered
  \setcounter{secnumdepth}{3}
\fi

\if@pnunnumbered
  \setcounter{secnumdepth}{-1}
\fi

\endinput
