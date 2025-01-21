---
link-citations: true
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
  \fancyhead[L]{\leftmark}
  \fancyhead[R]{}
  \fancyfoot[L]{Benjamin Shawki | s1096865}
  \fancyfoot[R]{Reflectie: Concepten in Programmeertalen}
  \usepackage{float}
  \usepackage{hyperref}
  \setcounter{tocdepth}{3}
  \let\origfigure\figure
  \let\endorigfigure\endfigure
  \usepackage{fvextra}
  \DefineVerbatimEnvironment{Highlighting}{Verbatim}{breaklines,commandchars=\\\{\}}
  \renewenvironment{figure}[1][2] {
      \expandafter\origfigure\expandafter[H]
  } {
      \endorigfigure
  }
date: April 2024
output: 
  pdf_document:
    template: template.tex
lang: nl
figureTitle: "Figuur"
figPrefix: "figuur"
secPrefix: ""
bibliography: ref.bib
csl: apa.csl
---

\begin{center}
\Huge Reflectie: Concepten in Programmeertalen
\end{center}

\vfill

\begin{center}
\huge ICPT Reflectie
\end{center}

\begin{center}
\LARGE Benjamin Shawki
\end{center}

\begin{center}
\Large April - Juni 2024
\end{center}

\vfill

\begin{center}
Versie 1.0 definitief - 24 Juni 2024
\end{center}

\newpage
# Reflectie ICPT
Terugkijkend op de afgelopen periode heb ik veel kennis opgedaan uit verschillende programmeertalen met verschillende programmeer concepten. Ik ben persoonlijk erg blij specifiek met de opgedane kennis uit C en C++. Deze talen zijn relatief nieuw voor mij en ik ben erg blij met de kennis die ik heb opgedaan. Aanstaande september zal ik beginnen met mijn Minor Embedded Systems, maar was hier nog een beetje huiverig voor. Echter, na het volgen van ICPT ben ik er zeker van dat ik de correcte start kennis heb om deze minor met succes af te ronden.

Het boek van Sebesta [@sebesta2019] was een goed boek voor de module. Alhoewel ik het boek niet van kaft tot kaft heb gelezen, heb ik wel veel gehad aan de hoofdstukken die ik wel heb gelezen, en zal hier in de toekomst zeker nog gebruik van maken.

Ook mijn eerste inzicht in de werking van een compiler en de toolchain was erg interessant, ik ben altijd al geïnteresseerd geweest maar heb nooit de tijd genomen om dit te onderzoeken. Graag zou ik later nog eens dieper hierop in willen gaan, en `LLVM` is bijvoorbeeld een project waar ik graag meer over zou willen leren.

Toen ik de geschiedenis van programmeertalen las, merkte ik pas hoeveel werk er in de ontwikkeling van programmeertalen zit. Ik heb respect opgedaan voor de mensen die hieraan werken, en hoop dat ik in de toekomst ook een bijdrage kan leveren aan deze complexe nog interessante wereld.

Tijdens het maken van de opdrachten ben ik tot de volgende inzichten gekomen:

- C en C++ zijn extreem flexibel maar ook echt enorm complex. Pointers zijn lastig om te begrijpen en ik heb hier nu wel een beter begrip van, maar diepgaande inzicht over hoe pointers correct complexe datastructuren kunnen representeren heb ik nog niet.
- Go vond ik een verrassend fijne taal om in te werken, ik had hier nog nooit eerder mee gewerkt maar ik wil hier binnenkort dieper in het ecosysteem duiken.
- Met C# had ik wel moeite, veel verplichte syntax en dotnet applicaties kunnen op linux draaien maar het is niet ideaal. Bij het opzetten van de omgeving had ik ook veel problemen.

Al met al weet ik nu beter wat er allemaal komt kijken bij het programmeren in verschillende talen, welke concepten invloed hebben op de werking van een programma, en heb ik met de opdrachten een goed beeld gekregen van de implementatie van deze concepten in verschillende talen.

\newpage
# Referenties {#sec:ref}
<div id="refs"></div>


