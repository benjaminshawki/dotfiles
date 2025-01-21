---
title: "Ontwikkeling van een Instant Rollback Feature"
subtitle: "Onderzoeksvoorstel"
author: "Benjamin Shawki"
numbersections: true
autoSectionLabels: true
geometry:
  - top=30mm
  - left=20mm
  - right=20mm
  - bottom=30mm
header-includes: |
  \usepackage{fancyhdr}
  \pagestyle{fancy}
  \fancyhead[L]{Benjamin Shawki | s1096865 }
  \fancyhead[C]{Onderzoeksvoorstel}
  \fancyhead[R]{\leftmark}
  \fancyfoot[C]{Page \thepage}
  \usepackage{float}
  \usepackage{hyperref}
  \setcounter{tocdepth}{4}
  \let\origfigure\figure
  \let\endorigfigure\endfigure
  \renewenvironment{figure}[1][2] {
      \expandafter\origfigure\expandafter[H]
  } {
      \endorigfigure
  }
date: Februari 2024
output: 
  pdf_document:
    template: template.tex
lang: nl
figureTitle: "Figuur"
figPrefix: "Figuur"
secPrefix: ""
---

\newpage

# Instant Rollback
## Inleiding
In de huidige digitale omgeving is een uptime van 99.9% van cruciaal belang voor veel bedrijven.
Dit wordt onder anderen gerealiseerd door het vermogen om snel terug te kunnen keren naar een eerdere, stabiele versie van een systeem of applicatie in het geval van een storing of een kritieke fout.

In opdracht van Hemiron, worden de mogelijkheden voor het ontwikkelen van een instant rollback feature, geïnspireerd op de functionaliteit zoals aangeboden door Vercel (een web deployment provider) onderzocht.
Deployment immutability, unieke URLs, een geautomatiseerd rollback proces en geen downtime zijn enkele van de belangrijkste kenmerken van Vercel's instant rollback feature.
 
## Doelstelling
In dit onderzoek staat het het ontwikkelen van een gedetailleerd plan  voor het ontwerpen en implementeren van een instant rollback feature centraal.
Een instant rollback feature verzekert dat een webapplicatie of service snel kan terugkeren naar een foutloze staat, waarmee onderbrekingen in de service geminimaliseerd worden en de constante beschikbaarheid voor gebruikers behouden blijft. Dit proces voorkomt dat kritieke fouten na een update de gebruikerservaring schaden of data integriteit compromitteren, en zorgt ervoor dat teams efficiënt kunnen reageren op onvoorziene problemen, wat bijdraagt aan een hogere operationele zekerheid en gebruikerstevredenheid.
Dit plan bevat de richtlijnen voor de technische uitvoering, integratie met bestaande infrastructuren, en aanbevelingen voor het testen en waarborgen van de effectiviteit van de feature.

## Probleemstelling
Hoe kan er voor hemiron een instant rollback feature ontwikkeld worden die naadloos integreert met het huidige systeem, om zo direct terug te kunnen schakelen naar een vorige, stabiele versie van de software bij een fout, met minimale onderbreking voor gebruikers en zonder afbreuk te doen aan de veiligheid en integriteit van gegevens? Dit proces moet specifiek richten op snelle detectie en correctie van fouten na updates, waarbij de operationele continuïteit en de gebruikerstevredenheid vooropstaan.

## Theoretisch Kader
Vercel's instant rollback functie maakt gebruik van een uniek deployment en hosting model dat ontworpen is om ontwikkelaars te helpen snel en veilig websites en webapplicaties uit te rollen en werkt als volgt:

Deployment Immutability
: Wanneer een nieuwe versie van de gebruikers applicatie beschikbaar komt, creëert Vercel een nieuwe, "onveranderlijke"(immutable) deployment. Dit betekent dat elke deployment een snapshot is van de applicatie op het moment van deployen, inclusief alle bestanden en afhankelijkheden die nodig zijn om het te laten draaien. Deze snapshots worden bewaard en kunnen onafhankelijk van elkaar worden benaderd. &nbsp;

Unieke URLs
: Vercel wijst automatisch een unieke URL toe aan elke deployment. Dit betekent dat elke versie van de applicatie bereikbaar is via een eigen URL, wat het testen en delen van nieuwe features of versies vereenvoudigt zonder de hoofdversie van de applicatie te beïnvloeden die live is voor gebruikers. &nbsp;

Rollback Proces
: Dankzij de onveranderlijkheid van deployments en de unieke URLs, maakt Vercel het mogelijk om 'instant' rollbacks uit te voeren naar een eerdere versie van de applicatie. Als een nieuwe deployment problemen veroorzaakt of niet naar wens functioneert, dan kan een eerdere, stabiele versie onmiddellijk worden gebruikt door simpelweg de URL van die versie als de 'live' versie aan te wijzen. Dit proces is vrijwel direct, aangezien de oudere versie al opgeslagen is op Vercel's servers en klaar is om te worden geserveerd aan gebruikers. &nbsp

Gebruikersinterface en CLI
: Vercel biedt zowel een webgebruikersinterface als een command line interface (CLI) die het eenvoudig maken om deployments te beheren en rollbacks uit te voeren. Deze interface is een overzicht van alle deployments, inclusief de status en de URL's, en met een paar clicks of commando's kan de eerdere versie live worden gezet. &nbsp;

Geen Downtime
: Omdat de oudere versies van de applicatie opgeslagen blijven op Vercel's infrastructuur, resulteert het uitvoeren van een rollback niet in downtime. Gebruikers ervaren geen onderbreking omdat Vercel de aanvragen gewoon doorstuurt naar de versie van de applicatie die is gemarkeerd als de huidige 'live' versie. &nbsp;

Automatisering
: Hoewel het rollback proces handmatig kan worden geïnitieerd via de Vercel dashboard of CLI, kunnen ontwikkelaars ook automatiseringsstrategieën implementeren die gebruik maken van webhooks of CI/CD pipelines om rollbacks automatisch te triggeren onder bepaalde voorwaarden, zoals het falen van tests of monitoring alerts. &nbsp;

## Onderzoeksontwerp en Verantwoording

### Methodologie
Dit onderzoek zal primair gebruikmaken van een kwalitatieve benadering om inzicht en praktische kennis te verkrijgen over de ontwikkeling en integratie van een effectieve instant rollback feature. 
Door middel van casestudy-analyse en deskundige interviews worden de best practices verzameld, worden de complexe technische implementatie onderzocht en de operationele nuances verkend.

### Dataverzamelingsmethode
Literatuurstudie
: Grondige review van wetenschappelijke publicaties, technische handleidingen, en case studies over instant rollback implementaties en gerelateerde technologieën. Deze literatuurstudie zal kritische inzichten geven in succesvolle aanpakken, veelvoorkomende obstakels, en innovatieve praktijken binnen het veld van softwareontwikkeling, deployment strategieën, en fout herstelmechanismen. &nbsp;

Expertinterviews
: Uitvoeren van semi-gestructureerde interviews met deskundigen uit de industrie, waaronder softwareontwikkelaars, DevOps professionals, en technologieleiders met ervaring in de implementatie of het operationeel beheer van rollback systemen. Deze interviews zijn bedoeld om diepgaande inzichten te verzamelen over de praktische toepassing, technische uitdagingen, en de organisatorische impact van rollback features. &nbsp;

Technische Analyse
: Een gedetailleerde beoordeling van de huidige IT-infrastructuur en systemen van Hemiron om te bepalen hoe een instant rollback feature het beste kan worden geïntegreerd. Deze fase omvat het evalueren van de compatibiliteit met bestaande technologieën, het identificeren van technische vereisten, en het in kaart brengen van eventuele aanpassingen die nodig zijn voor de implementatie. Dit helpt bij het opstellen van een technisch uitvoerbaar plan dat rekening houdt met specifieke eisen en beperkingen van het huidige systeem.

## Conclusie
Dit onderzoeksvoorstel schetst een systematische aanpak voor het ontwikkelen van een instant rollback feature.
