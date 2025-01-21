---
numbersections: true
autoSectionLabels: true
geometry:
  - top=30mm
  - left=20mm
  - right=20mm
  - bottom=30mm
header-includes: |
  \usepackage{pdfpages}
  \usepackage{fancyhdr}
  \pagestyle{fancy}
  \fancyhead[L]{Benjamin Shawki | s1096865 }
  \fancyhead[C]{Onderzoeksrapport}
  \fancyhead[R]{\leftmark}
  \fancyfoot[C]{Page \thepage}
  \usepackage{float}
  \usepackage{hyperref}
  \setcounter{tocdepth}{4}
  \let\origfigure\figure
  \let\endorigfigure\endfigure
  \usepackage{fvextra}
  \DefineVerbatimEnvironment{Highlighting}{Verbatim}{breaklines,commandchars=\\\{\}}
  \renewenvironment{figure}[1][2] {
      \expandafter\origfigure\expandafter[H]
  } {
      \endorigfigure
  }
date: Mei - Juni 2024
output: 
  pdf_document:
    template: template.tex
lang: nl
figureTitle: "Figuur"
figPrefix: "Figuur"
secPrefix: ""
---

\includepdf[pages=-]{./voorblad.pdf}

\begin{center}
\Huge Onderzoek naar de doorontwikkeling van de Instant Rollback Feature
\end{center}

\vfill

\begin{center}
\huge Adviesrapport en artikel voor Hemiron
\end{center}

\begin{center}
\LARGE Benjamin Shawki
\end{center}

\begin{center}
\Large Februari - Augustus 2024
\end{center}

\vfill


\begin{center}
Versie 1.0 definitief - 3 April 2024
\end{center}

\vfill

\begin{center}
\Huge Abstract
\end{center}

\begingroup

<!-- Het eerder ontwikkelde rollback feature moet met Docker, Traefik, en GitLab CI/CD -->

\newpage

\tableofcontents

\newpage

# Inleiding
Hemiron is een door de Hogeschool Leiden opgezette organisatie die hosting en deployment diensten wilt aanbieden. De door Hemiron ontwikkelde applicaties zijn gerealiseerd door door de samenwerking van studenten en docenten.
Één van de oplossingen die Hemiron aanbiedt is documentatie van de Instant Rollback Feature.
Deze stelt klanten in staat om snel en eenvoudig terug te keren naar een vorige versie van hun applicatie.

Dit onderzoek wordt uitgevoerd om de door ontwikkelingsmogelijkheden van de Instant Rollback Feature te verkennen.
Er wordt onderzocht wat de alternatieven zijn van de huidige oplossing en wat de voor- en nadelen zijn van deze alternatieven.


