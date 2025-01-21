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
  \fancyhead[C]{Adviesrapport}
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
date: Februari - Augustus 2024
output: 
  pdf_document:
    template: template.tex
lang: nl
figureTitle: "Figuur"
figPrefix: "Figuur"
secPrefix: ""
---

<!-- TODO: Verander Kans naar 2e van voorlad -->
\includepdf[pages=-]{./voorblad.pdf}

\begin{center}
\Huge Instant Rollback Feature met Docker en GitLab CI/CD, maar Traefik of Nginx?
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

\newpage
\begin{center}
\Huge Voorwoord
\end{center}

\begingroup
Dit document bevat mijn onderzoek voor de module IPSENH gevolgd aan de Hogeschool Leiden in het studiejaar 2023-2024 tijdens periode 3, 4 en 5.

Ik heb onderzoek gedaan binnen een bepaalde deployment strategie, specifiek 'green-blue deployment' wat er in het kort voor zorgt dat er een nieuwe versie van een applicatie wordt uitgerold terwijl de oude versie nog actief is. Dit wordt onder anderen gerealiseerd door gebruik te maken van verschillende reverse proxy software en CI/CD pipelines.
Dit onderzoek vergelijkt twee van deze reverse proxy toolings, namelijk Traefik en Nginx.

Deze toolings zijn getest binnen het kader van het terugrollen van een deployment, wat inhoudt dat er een nieuwe versie van een applicatie wordt uitgerold en dat er een rollback kan worden uitgevoerd naar de vorige versie. In deze context is er gekeken naar de snelheid van het uitvoeren van een rollback, de complexiteit van de configuratie, en de betrouwbaarheid van de rollback. 

Dit onderzoek is uitgevoerd in opdracht van Hemiron, een fictief bedrijf dat zich bezighoudt met het ontwikkelen van software voor hun hosting platform.

De aanleiding van dit onderzoek kwam uit een eerder opgesteld adviesrapport voor Hemiron waarbij een eerste versie van de deployment strategie werd voorgesteld.
Destijds kende ik de juist vakterm niet, maar dit bleek naderhand 'green-blue deployment' te heten. Dit oude adviesrapport is ook als bijlage terug te vinden.

Ik wil graag de Reddit user `u/segv` bedanken voor zijn reactie op het door mij geplaatste artikel survey op Reddit.
Zijn reactie heeft mij geholpen om de juiste vakterm te vinden voor de deployment strategie die ik heb onderzocht.
Dit heeft mij geholpen om mijn onderzoek's opzet te verfijnen en te specificeren.

Verder wil ik de docenten Heiko van der Heijden en Ron Arts bedanken voor hun begeleiding en feedback tijdens dit onderzoek.
\endgroup

\newpage

\begin{center}
\Huge Samenvatting
\end{center}

Dit onderzoek vergelijkt de prestaties van Traefik en Nginx, twee populaire reverse proxies, binnen het kader van een blue-green deployment strategie. Het doel was om te bepalen welke van deze tools de snelste rollback tijd biedt bij het uitrollen van nieuwe applicatieversies, een cruciale factor voor de betrouwbaarheid van de applicaties voor Hemiron’s gebruikers.

De experimenten werden uitgevoerd in een gecontroleerde omgeving met behulp van Docker containers en een GitLab CI/CD pipeline op een Virtual Private Server (VPS). De resultaten toonden aan dat Nginx, ondanks de complexere configuratie, consequent snellere rollback tijden behaalde dan Traefik. 

Hoewel Nginx superieur bleek in snelheid en consistentie, biedt Traefik voordelen zoals eenvoudiger configuratiebeheer en dynamische aanpassingsmogelijkheden. Deze kenmerken maken Traefik aantrekkelijk voor situaties waarin flexibiliteit en gebruiksgemak belangrijker zijn dan de hoogste snelheid. Het onderzoek concludeert dat Nginx de betere keuze is voor Hemiron’s gebruikers wanneer de snelheid van rollbacks essentieel is. Traefik blijft echter een waardevol alternatief voor omgevingen waar eenvoud in configuratie de prioriteit heeft.

De resultaten van dit onderzoek zullen Hemiron helpen bij het kiezen van de juiste tool voor hun hosting platform, waarbij ze de balans kunnen vinden tussen snelheid, gebruiksgemak en betrouwbaarheid.

\newpage

\tableofcontents

\newpage

# Inleiding
In de wereld van het weide web is toegang tot een correct werkende versie van een applicatie cruciaal. Om deze doelen te bereiken, worden diverse technologieën en methoden gebruikt, waaronder blue-green deployments, waarbij de nieuwe versie van een applicatie wordt uitgerold terwijl de oude versie nog actief is. Mocht er wat fout gaan, dan kan er snel worden teruggegaan naar de vorige
, nog steeds actieve, versie van de applicatie.

Blue---green deployments minimaliseren downtime en risico's tijdens of na het uitrollen van nieuwe versies. Dit wordt bereikt door nieuwe versies parallel aan de eerdere release te draaien.

De blauwe omgeving is de huidige productie omgeving, waar parallel andere, groene, versies van de applicatie worden uitgerold. Vervolgens wordt het `root domain` ofwel het hoofd domein gekoppeld aan de nieuwe groene omgeving, wat dus nu de productie omgeving en de blauwe omgeving wordt.
Hierbij wordt slechts de verwijzing naar het `root domain` aangepast. Dit betekend dat elke release een unieke URL krijgt, bijvoorbeeld `v1.example.com` en `v2.example.com`. Waarbij één van deze `subdomeinen` de URL gelinkt is aan het `root domain`.

Mocht er iets misgaan, dan kan er snel worden teruggegaan naar de oude versie door het `root domain` te koppelen aan een groene omgeving, wat nu de blauwe omgeving wordt. Hierdoor wordt de oude versie weer actief en de nieuwe versie wordt niet uitgeschakeld maar wordt niet meer gebruikt als productie omgeving.

De configuratie van het managen van het inkomend verkeer wordt gedaan door een reverse proxy.
Tegenwoordig zijn er verschillende tools beschikbaar om blue-green deployments te implementeren, waaronder Traefik[@traefik] en Nginx[@nginx].
Elk van deze tools biedt unieke voordelen en uitdagingen, en het kiezen van de juiste tool kan een significante impact hebben op de efficiëntie en betrouwbaarheid van het uitrolproces.

Dit onderzoek wordt uitgevoerd in opdracht van Hemiron, een fictief bedrijf opgezet door de Hogeschool Leiden, dat een hosting platform ontwikkelt.
Het doel van dit onderzoek is om de verschillen in rollback tijd tussen Traefik en Nginx te evalueren.

De hoofdvraag van dit onderzoek luidt als volgt:

_"Wat zijn de verschillen in rollback tijd tussen Traefik en Nginx bij het implementeren van een blue-green deployment strategie voor de gebruikers binnen Hemiron’s hosting platform?"_

Om deze vraag te beantwoorden, wordt een experiment uitgevoerd waarbij de rollback tijd van Traefik en Nginx wordt gemeten. De resultaten van dit onderzoek zullen Hemiron helpen bij het kiezen van de juiste tool voor hun hosting platform.

De volgende deelvragen zullen worden beantwoord in dit onderzoek:

_"Wat zijn de verschillen in configuratie tussen Traefik en Nginx bij het implementeren van een blue-green deployment strategie?"_

_"Wat zijn de voordelen en uitdagingen van het gebruik van Traefik en Nginx bij het implementeren van een blue-green deployment strategie"_

\newpage
# Methodiek
Dit onderzoek is uitgevoerd in de vorm van een vergelijkend onderzoek tussen Traefik en Nginx. De onderzoeksvraag is beantwoord door het uitvoeren van een experiment waarbij de rollback tijd van beide tools is gemeten.

## Onderzoeksmethode
Het onderzoek is uitgevoerd in de vorm van een experiment waarbij de rollback tijd van Traefik en Nginx is gemeten. Het experiment is uitgevoerd in een gecontroleerde omgeving met behulp van een CI/CD pipeline en Docker containers[@docker] op GitLab CI/CD[@gitlab-ci] en een VPS.
Een CI/CD pipeline staat voor Continuous Integration/Continuous Deployment en is een geautomatiseerde tool die het proces van het bouwen, testen en implementeren van software versnelt wat in dit geval op gitlab.com wordt uitgevoerd. In dit onderzoek is de CI/CD pipeline gebruikt om de uitrol en rollback van de applicatie te automatiseren en de rollback tijd te meten. Docker containers zijn kleine gevirtualiseerde omgevingen waarin applicaties kunnen worden uitgevoerd. In dit onderzoek zijn Docker containers gebruikt om de applicatie en de reverse proxy's te draaien.

## VPS 
De VPS, of Virtual Private Server, is een virtuele server die wordt gehost op een fysieke server. De VPS wordt gebruikt om de applicatie en de reverse proxy's te draaien en de rollback tijd te meten.

De VPS wordt gehost op DigitalOcean[^digi], wat een cloud service provider is die virtuele servers aanbiedt. De VPS is geconfigureerd met Ubuntu 22.04.4 LTS en Docker om de applicatie en de reverse proxy's te draaien.

[^digi]: https://www.digitalocean.com/

### Low Specs
- Ubuntu 22.04.4 LTS (GNU/Linux 5.15.0-118-generic x86_64)
- Docker version 27.1.2, build d01f264
- 1 vCPU
- 1GB RAM
- 25GB Disk

Na de gemeten data te hebben geanalyseerd, en naar de resultaten te hebben gekeken kunnen er slechts 14 services tegelijkertijd draaien op de VPS met low specs. Om de metingen betrouwbaar te houden is het van belang dat deze ten minste op een VPS met hogere specificaties worden uitgevoerd.

### High Specs
- Ubuntu 22.04.4 LTS (GNU/Linux 5.15.0-118-generic x86_64)
- Docker version 27.1.2, build d01f264
- 4 vCPU
- 8GB RAM
- 25GB Disk

## Pipeline
De CI/CD pipeline is opgezet met behulp van GitLab CI/CD en bestaat uit de volgende stappen:

1. Prepare: Exporteer scripts naar de server en bereid de configuratie voor.
2. Build: Bouw de frontend en backend containers.
3. Switch Domain: Schakel over naar de nieuwe versie van de applicatie.
4. Report: Meet de rollback tijd van Traefik en Nginx.

Verder moeten de Environment Variables worden ingesteld in de GitLab CI/CD settings.
SERVER_IP, SERVER_USER

Voor een draaiende backend container is het volgende nodig wat niet strikt nodig is voor dit onderzoek dienen ook de volgende environment variables instellen:
POSTGRES_DB, POSTGRES_PASSWORD, POSTGRES_USER

## Nginx SSH Certificaat
Traefik maakt gebruik van Let's Encrypt om zelf HTTPS-certificaten te genereren, terwijl Nginx een SSH-certificaat nodig heeft om HTTPS te ondersteunen. Let's Encrypt is een gratis en open source certificaatautoriteit die HTTPS-certificaten verstrekt. Om dit onderzoek uit te voeren, is een SSH-certificaat gegenereerd en deze is geïnstalleerd en moet beschiikbaar voor de nginx container in de `docker-compose.nginx.yml` file. Docker compose is een tool die wordt gebruikt om meerdere Docker containers te beheren en te orkestreren, en moet hier juist worden geconfigureerd om de nginx container te laten werken met het SSH-certificaat.

## Wildcard DNS
Van belang is de correcte DNS-instellingen om de instant rollback-functie en HTTPS-omleidingen te ondersteunen. Specifiek moet er een wildcard DNS-record aanwezig zijn (bijv. `*.example.com`) om de dynamische verwerking van subdomeinen via Traefik en NGINX mogelijk te maken.

Er moet een DNS-record aanwezig zijn zoals `*.example.com` dat verwijst naar het IP-adres van de VPS. Dit stelt je in staat om de deployments te benaderen via subdomeinen zoals `commit-sha.example.com`.
Hier is een voorbeeld van een eenvoudige configuratie:

| Type  | Hostnaam        | Waarde       |
|-------|-----------------|--------------|
| A     | example.com     | 12.345.67.890|
| A     | *.example.com   | 12.345.67.890|
| CNAME | www.example.com | example.com  |

## Reverse Proxy's 
In dit onderzoek worden twee reverse proxy's gebruikt, Traefik en Nginx. Beide tools bieden een scala aan features en configuratie-opties die het implementeren van blue-green deployments mogelijk maken. Hieronder volgt een korte beschrijving van beide tools:

### Traefik
Traefik is een reverse proxy en load balancer die speciaal is ontworpen voor microservices en containerized applicaties. Traefik is eenvoudig te configureren en biedt een scala aan features die het implementeren van blue-green deployments eenvoudig maken. 

### Nginx
Nginx is een populaire reverse proxy en load balancer die wordt gebruikt voor veel applicaties. Nginx is krachtig en flexibel, maar kan complex zijn om te configureren.

### Het grootste verschil
Het grootste verschil tussen Traefik en Nginx is de configuratie en de manier van werking. Nginx heeft een eigen draaiende container nodig die de configuratie moet aanpassen, dit wordt gedaan door een script dat een configuratie bestand aanpast, deze configuratie op de VPS plaatst en vervolgens binnen de Nginx container de configuratie herlaad. Traefik daarentegen heeft een dynamische configuratie die wordt aangepast door labels toe te voegen aan de containers die worden uitgerold. De Traefik service herlaad automatisch de configuratie wanneer er een verandering is in de labels van de containers.

## Metingen
De metingen zijn uitgevoerd met behulp van een script dat de status van de applicatie controleert en de tijd registreert. De metingen zijn meerdere malen herhaald en met een variabel aantal andere draaiende frontend-containers uitgevoerd. De resultaten zijn geanalyseerd en geëvalueerd om de verschillen in rollback tijd tussen Traefik en Nginx te bepalen.

### Rollback Tijd gehele proces
De rollback tijd is gemeten door de tijd te noteren tussen het schakelen van het `root domain` naar de nieuwe versie van de applicatie en het volledig functioneel zijn van de nieuwe versie. De metingen zijn uitgevoerd met behulp van een script dat de status van de applicatie controleert en de tijd registreert. De metingen zijn meerdere malen herhaald en met een variabel aantal andere draaiende frontend-containers uitgevoerd. De resultaten zijn geanalyseerd en geëvalueerd om de verschillen in rollback tijd tussen Traefik en Nginx te bepalen, deze metingen zijn aan de bijlage toegevoegd als `combined_rollback_times.csv` en `combined_rollback_times.csv`. Deze zijn geanalyseerd door deze in Yamovi te importeren en de data te analyseren. Ook zijn de individuele stappen in het rollback gelogd en ook in de bijlage te vinden als `combined_rollback_times-high-spec.csv` en `combined_rollback_times-low-spec.csv`.

\newpage
# Resultaten
Hieronder volgen de resultaten van het onderzoek, waarbij de rollback tijden van Traefik en Nginx zijn gemeten en geanalyseerd.

## Low Specs
De resultaten van de metingen op de VPS met low specs zijn als volgt:

### One-Way ANOVA
| One-Way ANOVA (Welch's) |    |    |    |     |
|-------------------------|----|----|----|-----|
|                         | F  | df1 | df2 | p   |
| **elapsed_time**         | 38.7 | 1  | 143 | < .001 |

De resultaten van de tabel tonen significante verschillen in rollback tijden tussen Traefik en Nginx. Gemiddeld heeft Nginx een lagere rollback tijd (15.383 ms) in vergelijking met Traefik (24.857 ms). Deze verschillen werden ook bevestigd door een One-Way ANOVA, waarbij de p-waarde lager is dan 0.001, wat wijst op een statistisch significant verschil in prestaties tussen de twee tools.

### Descriptives

| Descriptives         | proxy_provider | elapsed_time |
|----------------------|----------------|--------------|
| **N**                | nginx          | 134          |
|                      | traefik        | 104          |
| **Missing**          | nginx          | 0            |
|                      | traefik        | 0            |
| **Mean**             | nginx          | 15383        |
|                      | traefik        | 24857        |
| **Median**           | nginx          | 16397        |
|                      | traefik        | 25635        |
| **Standard deviation** | nginx        | 7132         |
|                      | traefik        | 14206        |
| **Minimum**          | nginx          | 1071         |
|                      | traefik        | 6582         |
| **Maximum**          | nginx          | 77990        |
|                      | traefik        | 158382       |

-    Gemiddelde Rollback Tijd: Nginx presteert beter met een lagere gemiddelde rollback tijd dan Traefik. Dit suggereert dat Nginx efficiënter is in het herladen van de configuratie, wat de tijd die nodig is om terug te keren naar een vorige versie van de applicatie aanzienlijk vermindert.
-    Standaarddeviatie: De standaarddeviatie voor Nginx is lager (7.132 ms) dan die voor Traefik (14.206 ms), wat erop wijst dat de rollback tijden van Nginx consistenter zijn.
-    Minimum en Maximum: De minimum rollback tijd voor Nginx is veel lager (1.071 ms) dan voor Traefik (6.582 ms), en ook de maximale rollback tijd voor Nginx is lager, wat de superioriteit van Nginx onderstreept in zowel optimale als suboptimale omstandigheden.

## High Specs
Op de High Specs VPS is er een significante verbetering in de rollback tijden voor zowel Traefik als Nginx. De gemiddelde rollback tijd voor Nginx is gedaald naar 3.779 ms, terwijl die voor Traefik 4.938 ms bedraagt. Deze waarden zijn aanzienlijk lager dan de rollback tijden die zijn waargenomen op de Low Specs VPS.

### One-Way ANOVA

| One-Way ANOVA (Welch's) |    |    |    |     |
|-------------------------|----|----|----|-----|
|                         | F  | df1 | df2 | p   |
| **elapsed_time**         | 72.3 | 1  | 277 | < .001 |

Voor de High Specs VPS zien we een nog hoger significant verschil, met een F-waarde van 72.3 en een p-waarde < .001.

### Descriptives

| Descriptives          | proxy_provider | elapsed_time |
|-----------------------|----------------|--------------|
| **N**                 | nginx          | 149          |
|                       | traefik        | 141          |
| **Missing**           | nginx          | 0            |
|                       | traefik        | 0            |
| **Mean**              | nginx          | 3779         |
|                       | traefik        | 4938         |
| **Median**            | nginx          | 3673         |
|                       | traefik        | 5034         |
| **Standard deviation**| nginx          | 1071         |
|                       | traefik        | 1238         |
| **Minimum**           | nginx          | 1383         |
|                       | traefik        | 835          |
| **Maximum**           | nginx          | 8806         |
|                       | traefik        | 9098         |

-    Gemiddelde Rollback Tijd: Op zowel Low Specs als High Specs blijft Nginx sneller dan Traefik, hoewel de marge kleiner wordt bij hogere specificaties. Dit geeft aan dat beide tools profiteren van betere hardware, maar dat Nginx robuuster lijkt te presteren onder verschillende omstandigheden.
-    Standaarddeviatie: De standaarddeviatie is lager bij High Specs, wat duidt op meer consistente rollback tijden. Voor Nginx is de standaarddeviatie 1.071 ms, terwijl die voor Traefik 1.238 ms is.
-    Minimum en Maximum: De minimum rollback tijd voor Traefik is verrassend lager dan die voor Nginx op High Specs, wat aangeeft dat er situaties kunnen zijn waarin Traefik sneller is. Echter, de gemiddelde waarden blijven in het voordeel van Nginx.

\newpage
# Conclusie & Discussie
Dit onderzoek richtte zich op de vergelijking van rollback tijden tussen Traefik en Nginx in een blue-green deployment strategie. De resultaten toonden aan dat Nginx, ondanks de complexiteit in configuratie, consistent sneller presteert dan Traefik in termen van rollback tijden, zelfs op hardware met hogere specificaties. Het verschil tussen de tools werd bevestigd door een statistisch significante p-waarde, wat aangeeft dat de prestaties van Nginx stabieler en sneller zijn onder verschillende omstandigheden.

Hoewel Nginx over het algemeen superieur blijkt te zijn in snelheid, biedt Traefik andere voordelen, zoals eenvoud in configuratie en dynamische aanpassingen, die niet genegeerd mogen worden. Deze voordelen maken Traefik aantrekkelijk voor situaties waar de configuratie flexibiliteit en eenvoud belangrijker zijn dan de allerhoogste snelheid.

Er is nog ruimte voor verbetering in de prestaties van Traefik, vooral als de community het voorstel voor het dynamisch herladen van labels zonder container herstart[@label-proposal] kan implementeren. Dit zou de rollback snelheid van Traefik kunnen verbeteren, waardoor het een nog aantrekkelijker alternatief zou worden voor Nginx, vooral in omgevingen waar gebruiksgemak voorop staat.

## Conclusie:
Uit het onderzoek blijkt dat Nginx een betere keuze is voor Hemiron’s hosting platform wanneer rollback snelheid essentieel is, vooral op high-specs servers. Nginx presteert sneller en consistenter dan Traefik, wat resulteert in kortere downtime tijden tijdens rollback procedures. Traefik biedt echter voordelen in configuratiegemak en dynamische schaalbaarheid, waardoor het nog steeds een aantrekkelijke keuze kan zijn voor omgevingen waar snelheid minder kritisch is.

Beantwoording van de Hoofd- en Deelvragen:

Hoofdvraag:
_"Wat zijn de verschillen in rollback tijd tussen Traefik en Nginx bij het implementeren van een blue-green deployment strategie voor de gebruikers binnen Hemiron’s hosting platform?"_

Antwoord:
Nginx presteert beter dan Traefik wat betreft rollback tijden in een blue-green deployment strategie. Het verschil in rollback tijd is significant, waarbij Nginx consistent snellere rollback tijden biedt, vooral op servers met hogere specificaties.

Deelvraag 1:
_"Wat zijn de verschillen in configuratie tussen Traefik en Nginx bij het implementeren van een blue-green deployment strategie?"_

Antwoord:
Traefik biedt een eenvoudigere en meer dynamische configuratie door het gebruik van labels, terwijl Nginx een meer handmatige configuratie vereist met herlading van configuratiebestanden binnen de container. Traefik's eenvoud maakt het aantrekkelijk voor snelle en flexibele implementaties, terwijl Nginx robuustere prestaties levert, ten koste van meer complexe configuratie.

Deelvraag 2:
_"Wat zijn de voordelen en uitdagingen van het gebruik van Traefik en Nginx bij het implementeren van een blue-green deployment strategie?"_

Antwoord:
Traefik's belangrijkste voordelen zijn de eenvoudige configuratie en dynamische aanpassingsmogelijkheden, terwijl de uitdagingen liggen in de iets langzamere rollback tijden en afhankelijkheid van container labels. Nginx biedt snellere en meer consistente prestaties, maar vereist een complexere configuratie, wat een uitdaging kan zijn voor minder ervaren gebruikers.

Deze inzichten helpen Hemiron om een weloverwogen keuze te maken voor hun hosting platform, waarbij ze de juiste balans kunnen vinden tussen snelheid, gebruiksgemak en betrouwbaarheid.

\newpage
# Referenties {#sec:ref}

<!-- TODO: Why is this not working? -->
<div id="refs"></div>

<!-- \newpage -->
<!-- # Bijlagen -->
<!---->
<!-- De bijlagen zijn hieronder te vinden, en in de gebundelde documenten. -->
<!---->
<!-- ## Interview {#sec:interview} -->
<!-- Het interview is afgenomen voor het voorgaande adviesrapport. -->
<!---->
<!-- ### Voorbereiding {#sec:voorbereiding} -->
<!---->
<!-- --- -->
<!---->
<!-- \LARGE Interviewstructuur -->
<!-- \normalsize -->
<!---->
<!-- **Introductie** -->
<!---->
<!-- - **Context**: Doel van het interview, belang van rollback features. -->
<!-- - **Opname toestemming**: Privacy, toestemming. -->
<!---->
<!-- **Hoofdgedeelte** -->
<!---->
<!-- Achtergrond en Ervaring -->
<!---->
<!-- - **Rollback functie ervaring**: Specifieke voorbeelden, duur van de ervaring. -->
<!-- - **Projectcontext**: Type projecten, rol binnen het project. -->
<!---->
<!-- Technische Diepgang -->
<!---->
<!-- - **Methodologieën**: Voorkeuren, redenering, implementatie uitdagingen. -->
<!-- - **Tooling**: Specifieke tools of frameworks gebruikt. -->
<!---->
<!-- Best Practices en Aanbevelingen -->
<!---->
<!-- - **Implementatiegids**: Stappen, overwegingen. -->
<!-- - **Hemiron-specifiek**: Aanpassingen, organisatorische context.  -->
<!---->
<!-- --- -->
<!---->
<!-- \LARGE Topic lijst -->
<!-- \normalsize -->
<!---->
<!-- Deployment -->
<!---->
<!-- - **Immutable Deployments**: Voordelen, implementatie tips. -->
<!-- - **Snapshot-Beheer**: Strategieën, tools. -->
<!-- - **Versiegeschiedenis**: Belang, beheer. -->
<!-- - **Unieke URL's**: Implementatie, voordelen, subdomein. -->
<!---->
<!-- Deployment Identificatie -->
<!---->
<!-- - **Versie-Toegankelijkheid**: Methoden, best practices. -->
<!-- - **Omgevingen**: Scheiding, doel (prod vs staging/dev/test). -->
<!-- - **Environment Variabelen**: Beheer, veiligheid. -->
<!-- - **Instant Rollback Procedure**: Stappen, voorbereiding. -->
<!---->
<!-- Rollback Commando's (CLI) -->
<!---->
<!-- - **Triggers**: Wanneer, waarom. -->
<!-- - **Automatisering/Scripts**: Voorbeelden, effectiviteit. -->
<!-- - **CI/CD Integratie**: Best practices, uitdagingen. -->
<!---->
<!-- Pipeline Configuratie -->
<!---->
<!-- - **Automatische Rollbacks**: Wanneer, hoe. -->
<!-- - **Monitoring/Alerts**: Systemen, responsstrategieën. -->
<!-- - **Technische Uitdagingen**: Veelvoorkomend, oplossingen. -->
<!---->
<!-- Gebruikersinterface -->
<!---->
<!-- - **Dashboard Functionaliteit**: Noodzakelijke features, ontwerp overwegingen. -->
<!-- - **Gebruikerservaring**: Tijdens rollbacks, verbeterpunten. -->
<!---->
<!-- Infrastructuur Compatibiliteit -->
<!---->
<!-- - **Operationele Vereisten**: Specifieke behoeften, aanpassingen. -->
<!-- - **Beveiligingsimplicaties**: Overwegingen, maatregelen. -->
<!-- - **Best Practices**: Algemeen, specifiek voor rollback features. -->
<!---->
<!-- --- -->
<!---->
<!-- ### Transcript {#sec:transcript} -->
<!---->
<!-- Het volledige transcript van het interview is te vinden in het bijgevoegde `transcript.docx` bestand. -->

[@wat-is-onderzoek]


<!-- .gitlab-ci.yml -->
<!-- ```yml -->
<!-- # CI/CD Pipeline Configuration -->
<!---->
<!-- stages: -->
<!--   - prepare -->
<!--   - build -->
<!--   - switch-domain -->
<!--   - report -->
<!---->
<!-- # Default settings for Docker, applied globally unless specifically overridden. -->
<!-- default: -->
<!--   image: docker:24.0.5 -->
<!--   services: -->
<!--     - docker:24.0.5-dind -->
<!---->
<!-- .login_ssh: &login_ssh -->
<!--   before_script: -->
<!--     - apk add --no-cache gettext openssh-client -->
<!--     - eval $(ssh-agent) -->
<!--     - echo "$ID_RSA" | tr -d '' | ssh-add - -->
<!--     - mkdir -p ~/.ssh -->
<!--     - chmod 700 ~/.ssh -->
<!--     - ssh-keyscan -H $SERVER_IP >> ~/.ssh/known_hosts -->
<!---->
<!-- # Global variables defining Docker configurations and image naming conventions. -->
<!-- variables: -->
<!--   # Docker environment settings. -->
<!--   DOCKER_DRIVER: overlay2 -->
<!--   DOCKER_TLS_CERTDIR: "/certs" -->
<!--   COMPOSE_PROJECT_NAME: "pintandpillage" -->
<!--   ROOT_DOMAIN: bluejund.com -->
<!---->
<!--   PROXY_PROVIDER: traefik -->
<!--   # PROXY_PROVIDER: nginx -->
<!---->
<!--   TRAEFIK: traefik -->
<!--   NGINX: nginx -->
<!--   OPENRESTY: openresty -->
<!---->
<!--   # Naming for Docker images, facilitating version control and latest builds. -->
<!--   IMAGE_FRONTEND: $CI_REGISTRY_IMAGE/$CI_COMMIT_REF_NAME/frontend-$PROXY_PROVIDER:$CI_COMMIT_SHORT_SHA -->
<!--   IMAGE_BACKEND: $CI_REGISTRY_IMAGE/$CI_COMMIT_REF_NAME/backend:$CI_COMMIT_SHORT_SHA -->
<!--   IMAGE_E2E_TEST: $CI_REGISTRY_IMAGE/$CI_COMMIT_REF_NAME/e2e-test:$CI_COMMIT_SHA -->
<!---->
<!--   # Secure login to Docker registry. -->
<!--   DOCKER_LOGIN: echo $CI_REGISTRY_PASSWORD | docker login -u $CI_REGISTRY_USER --password-stdin $CI_REGISTRY -->
<!---->
<!-- export-scripts: -->
<!--   stage: prepare -->
<!--   <<: *login_ssh -->
<!--   script: -->
<!--     - echo "Exporting scripts to the server..." -->
<!--     - scp -r ./scripts $SERVER_USER@$SERVER_IP:/home/${SERVER_USER} -->
<!--     - ssh $SERVER_USER@$SERVER_IP "find /home/${SERVER_USER}/scripts -type f -name '*.sh' -exec chmod +x {} \;" -->
<!--   only: -->
<!--     - main -->
<!---->
<!-- prepare-traefik: -->
<!--   stage: prepare -->
<!--   variables: -->
<!--     PROXY_PROVIDER: "traefik" -->
<!--   image: alpine:3.14 -->
<!--   <<: *login_ssh -->
<!--   script: -->
<!--     - echo "Preparing Traefik configuration..." -->
<!--     - export SERVICE_NAME="frontend-${TRAEFIK}-${CI_COMMIT_SHORT_SHA}" -->
<!--     - export TRAEFIK_ROUTER_RULE="Host(\`${CI_COMMIT_SHORT_SHA}.${ROOT_DOMAIN}\`) || Host(\`www.${CI_COMMIT_SHORT_SHA}.${ROOT_DOMAIN}\`) || Host(\`${ROOT_DOMAIN}\`) || Host(\`www.${ROOT_DOMAIN}\`)" -->
<!--     - sed -i "s|frontend-placeholder|${SERVICE_NAME}|g" docker-compose.traefik.yml -->
<!--     - sed -i "s|\${CI_COMMIT_SHORT_SHA}|${CI_COMMIT_SHORT_SHA}|g" docker-compose.traefik.yml -->
<!--     - sed -i "s|\${ROOT_DOMAIN}|${ROOT_DOMAIN}|g" docker-compose.traefik.yml -->
<!--     - sed -i "s|\${CI_REGISTRY_IMAGE}|${CI_REGISTRY_IMAGE}|g" docker-compose.traefik.yml -->
<!--     - sed -i "s|\${PROXY_PROVIDER}|${TRAEFIK}|g" docker-compose.traefik.yml -->
<!---->
<!--     - envsubst < docker-compose.traefik.yml > docker-compose.traefik.subst.yml -->
<!--     - cat docker-compose.traefik.subst.yml -->
<!---->
<!--     - scp docker-compose.traefik.subst.yml $SERVER_USER@$SERVER_IP:/home/${SERVER_USER}/deployments/${CI_COMMIT_SHORT_SHA}-docker-compose.traefik.yml -->
<!--   artifacts: -->
<!--     paths: -->
<!--       - docker-compose.traefik.subst.yml -->
<!--   only: -->
<!--     - main -->
<!---->
<!-- prepare-nginx: -->
<!--   stage: prepare -->
<!--   variables: -->
<!--     PROXY_PROVIDER: "nginx" -->
<!--   image: alpine:3.14 -->
<!--   <<: *login_ssh -->
<!--   script: -->
<!--     - echo "Preparing NGINX configuration..." -->
<!--     - export SERVICE_NAME="frontend-${NGINX}-${CI_COMMIT_SHORT_SHA}" -->
<!--     - sed -i "s|frontend-placeholder|${SERVICE_NAME}|g" docker-compose.nginx.yml -->
<!--     - sed -i "s|\${CI_COMMIT_SHORT_SHA}|${CI_COMMIT_SHORT_SHA}|g" docker-compose.nginx.yml -->
<!--     - sed -i "s|\${ROOT_DOMAIN}|${ROOT_DOMAIN}|g" docker-compose.nginx.yml -->
<!--     - sed -i "s|\${CI_REGISTRY_IMAGE}|${CI_REGISTRY_IMAGE}|g" docker-compose.nginx.yml -->
<!--     - sed -i "s|\${PROXY_PROVIDER}|${NGINX}|g" docker-compose.nginx.yml -->
<!---->
<!--     - envsubst < docker-compose.nginx.yml > docker-compose.nginx.subst.yml -->
<!--     - cat docker-compose.nginx.subst.yml -->
<!---->
<!--     - scp docker-compose.nginx.subst.yml $SERVER_USER@$SERVER_IP:/home/${SERVER_USER}/deployments/${CI_COMMIT_SHORT_SHA}-docker-compose.nginx.yml -->
<!--   artifacts: -->
<!--     paths: -->
<!--       - docker-compose.nginx.subst.yml -->
<!--   only: -->
<!--     - main -->
<!---->
<!-- build-frontend-traefik: -->
<!--   stage: build -->
<!--   variables: -->
<!--     PROXY_PROVIDER: "traefik" -->
<!--   before_script: -->
<!--     - sh -c "$DOCKER_LOGIN" -->
<!--   script: -->
<!--     - echo "Exporting environment variables for Traefik..." -->
<!--     - export BACKEND_URL=${BACKEND_URL} -->
<!--     - export ROOT_DOMAIN=${ROOT_DOMAIN} -->
<!--     - export CI_COMMIT_SHORT_SHA=${CI_COMMIT_SHORT_SHA} -->
<!--     - export FRONTEND_URL=${FRONTEND_URL} -->
<!--     - export PROXY_PROVIDER=${TRAEFIK} -->
<!--     - echo "Setting up the environment variables for the frontend build" -->
<!--     - echo "VUE_APP_BACKEND_URL=${BACKEND_URL}" > ./PintAndPillageFrontend/.env -->
<!--     - echo "VUE_APP_ROOT_DOMAIN=${ROOT_DOMAIN}" >> ./PintAndPillageFrontend/.env -->
<!--     - echo "VUE_APP_FRONTEND_URL=${FRONTEND_URL}" >> ./PintAndPillageFrontend/.env -->
<!--     - echo "VUE_APP_CI_COMMIT_SHORT_SHA=${CI_COMMIT_SHORT_SHA}" >> ./PintAndPillageFrontend/.env -->
<!--     - echo "VUE_APP_REVERSE_PROXY_PROVISIONER=${TRAEFIK}" >> ./PintAndPillageFrontend/.env -->
<!--     - cat ./PintAndPillageFrontend/.env -->
<!--     - echo "Building frontend for Traefik..." -->
<!--     - echo "Composing 'docker-compose.traefik.subst.yml build frontend-${TRAEFIK}-${CI_COMMIT_SHORT_SHA}'" -->
<!--     - cat docker-compose.traefik.subst.yml -->
<!--     - docker compose -f docker-compose.traefik.subst.yml build frontend-${TRAEFIK}-${CI_COMMIT_SHORT_SHA} -->
<!--     - docker push $IMAGE_FRONTEND -->
<!--   needs: -->
<!--     - prepare-traefik -->
<!--   only: -->
<!--     - main -->
<!---->
<!-- build-frontend-nginx: -->
<!--   stage: build -->
<!--   variables: -->
<!--     PROXY_PROVIDER: "nginx" -->
<!--   before_script: -->
<!--     - sh -c "$DOCKER_LOGIN" -->
<!--   script: -->
<!--     - echo "Exporting environment variables for NGINX..." -->
<!--     - export BACKEND_URL=${BACKEND_URL} -->
<!--     - export ROOT_DOMAIN=${ROOT_DOMAIN} -->
<!--     - export CI_COMMIT_SHORT_SHA=${CI_COMMIT_SHORT_SHA} -->
<!--     - export FRONTEND_URL=${FRONTEND_URL} -->
<!--     - export REVERSE_PROXY_PROVISIONER=${NGINX} -->
<!--     - echo "Setting up the environment variables for the frontend build" -->
<!--     - echo "VUE_APP_BACKEND_URL=${BACKEND_URL}" > ./PintAndPillageFrontend/.env -->
<!--     - echo "VUE_APP_ROOT_DOMAIN=${ROOT_DOMAIN}" >> ./PintAndPillageFrontend/.env -->
<!--     - echo "VUE_APP_FRONTEND_URL=${FRONTEND_URL}" >> ./PintAndPillageFrontend/.env -->
<!--     - echo "VUE_APP_CI_COMMIT_SHORT_SHA=${CI_COMMIT_SHORT_SHA}" >> ./PintAndPillageFrontend/.env -->
<!--     - echo "VUE_APP_REVERSE_PROXY_PROVISIONER=${NGINX}" >> ./PintAndPillageFrontend/.env -->
<!--     - cat ./PintAndPillageFrontend/.env -->
<!--     - echo "Building frontend for NGINX..." -->
<!--     - echo "Composing 'docker-compose.nginx.subst.yml build frontend-${NGINX}-${CI_COMMIT_SHORT_SHA}'" -->
<!--     - cat docker-compose.nginx.subst.yml -->
<!--     - docker compose -f docker-compose.nginx.subst.yml build frontend-${NGINX}-${CI_COMMIT_SHORT_SHA} -->
<!--     - docker push $IMAGE_FRONTEND -->
<!--   needs: -->
<!--     - prepare-nginx -->
<!--   only: -->
<!--     - main -->
<!---->
<!-- build-backend: -->
<!--   stage: build -->
<!--   before_script: -->
<!--     - sh -c "$DOCKER_LOGIN" -->
<!--   script: -->
<!--     - echo "Building backend..." -->
<!--     - echo "Composing 'docker-compose build backend'" -->
<!--     - docker compose build backend -->
<!--     - docker push $IMAGE_BACKEND -->
<!--   only: -->
<!--     - main -->
<!---->
<!-- switch-domain: -->
<!--   stage: switch-domain -->
<!--   <<: *login_ssh -->
<!--   script: -->
<!--     - echo "Switching domain for $PROXY_PROVIDER..." -->
<!--     - scp ./scripts/make-sha-root-domain.sh $SERVER_USER@$SERVER_IP:/home/${SERVER_USER}/make-sha-root-domain.sh -->
<!--     - ssh $SERVER_USER@$SERVER_IP " -->
<!--       cd /home/$SERVER_USER; -->
<!--       chmod +x ./make-sha-root-domain.sh; -->
<!--       ./make-sha-root-domain.sh '${CI_COMMIT_SHORT_SHA}' '$ROOT_DOMAIN' '$PROXY_PROVIDER'; -->
<!--       " -->
<!--   needs: -->
<!--     - build-frontend-traefik -->
<!--     - build-frontend-nginx -->
<!--     - build-backend -->
<!--   only: -->
<!--     - main -->
<!---->
<!-- report: -->
<!--   stage: report -->
<!--   <<: *login_ssh -->
<!--   script: -->
<!--     - ssh $SERVER_USER@$SERVER_IP "mkdir -p /home/${SERVER_USER}/scripts/analysis/reports" -->
<!--     - echo "Switching each service to root domain and collecting metrics..." -->
<!--     - ssh $SERVER_USER@$SERVER_IP " -->
<!--       services=\$(docker ps --filter 'name=deployments-frontend-${PROXY_PROVIDER}-' --format '{{.Names}}'); -->
<!--       for service in \$services; do -->
<!--       sha=\$(echo \$service | sed -n 's/.*-${PROXY_PROVIDER}-\([0-9a-f]\+\)-[0-9]\+$/\1/p'); -->
<!--       ./scripts/analysis/rollback-time.sh \$sha $ROOT_DOMAIN $PROXY_PROVIDER; -->
<!--       sleep 10; -->
<!--       done; -->
<!--       /home/${SERVER_USER}/scripts/analysis/generate-report.sh; -->
<!--       " -->
<!--   only: -->
<!--     - main -->
<!--   when: on_success -->
<!--   needs: -->
<!--     - switch-domain -->
<!-- ``` -->
<!---->
<!-- docker-compose.nginx.yml -->
<!-- ```yml -->
<!-- version: "3.9" -->
<!---->
<!-- services: -->
<!--   nginx: -->
<!--     image: nginx:1.27.0 -->
<!--     restart: unless-stopped -->
<!--     volumes: -->
<!--       - /var/run/docker.sock:/var/run/docker.sock -->
<!--       - /home/deployer/data/nginx:/etc/nginx/conf.d -->
<!--       - /home/deployer/data/nginx.conf:/etc/nginx/nginx.conf -->
<!--       - /etc/letsencrypt:/etc/letsencrypt -->
<!--     ports: -->
<!--       - "80:80" -->
<!--       - "443:443" -->
<!--     command: 'nginx -g "daemon off;"' -->
<!--     user: "root" -->
<!--     group_add: -->
<!--       - "www-data" -->
<!--     networks: -->
<!--       - web -->
<!--     extra_hosts: -->
<!--       - "host.docker.internal:host-gateway" -->
<!---->
<!--   db: -->
<!--     image: postgres:14 -->
<!--     volumes: -->
<!--       - postgres_data:/var/lib/postgresql/data -->
<!--     environment: -->
<!--       POSTGRES_DB: ${POSTGRES_DB} -->
<!--       POSTGRES_USER: ${POSTGRES_USER} -->
<!--       POSTGRES_PASSWORD: ${POSTGRES_PASSWORD} -->
<!--     ports: -->
<!--       - "5433:5432" -->
<!--     networks: -->
<!--       - web -->
<!---->
<!--   backend: -->
<!--     image: ${IMAGE_BACKEND} -->
<!--     build: -->
<!--       context: ./PintAndPillageJavaBackend/ -->
<!--       dockerfile: Dockerfile -->
<!--     volumes: -->
<!--       - ./PintAndPillageJavaBackend:/app -->
<!--       - /app/target -->
<!--     expose: -->
<!--       - "8080" -->
<!--     environment: -->
<!--       SPRING_DATASOURCE_URL: jdbc:postgresql://db:5432/${POSTGRES_DB} -->
<!--       SPRING_DATASOURCE_USERNAME: ${SPRING_DATASOURCE_USERNAME} -->
<!--       SPRING_DATASOURCE_PASSWORD: ${SPRING_DATASOURCE_PASSWORD} -->
<!--       SPRING_JPA_HIBERNATE_DDL_AUTO: create-drop -->
<!--       JWT_SECRET: ${JWT_SECRET} -->
<!--       LOGGING_LEVEL_ORG_SPRINGFRAMEWORK_WEB: DEBUG -->
<!--       LOGGING_LEVEL_ORG_HIBERNATE_SQL: INFO -->
<!--     depends_on: -->
<!--       - db -->
<!--     networks: -->
<!--       - web -->
<!--     extra_hosts: -->
<!--       - "host.docker.internal:host-gateway" -->
<!---->
<!--   frontend-placeholder: -->
<!--     image: ${CI_REGISTRY_IMAGE}/$CI_COMMIT_REF_NAME/frontend-nginx:${CI_COMMIT_SHORT_SHA} -->
<!--     build: -->
<!--       context: . -->
<!--       dockerfile: PintAndPillageFrontend/Dockerfile -->
<!--     expose: -->
<!--       - "80" -->
<!--     environment: -->
<!--       VUE_APP_BACKEND_URL: ${BACKEND_URL} -->
<!--       VUE_APP_CI_COMMIT_SHORT_SHA: ${CI_COMMIT_SHORT_SHA} -->
<!--       VUE_APP_ROOT_DOMAIN: ${ROOT_DOMAIN} -->
<!--       VUE_APP_FRONTEND_URL: ${FRONTEND_URL} -->
<!--       VUE_APP_REVERSE_PROXY_PROVISIONER: ${PROXY_PROVIDER} -->
<!--     networks: -->
<!--       - web -->
<!--     extra_hosts: -->
<!--       - "host.docker.internal:host-gateway" -->
<!---->
<!-- networks: -->
<!--   web: -->
<!--     driver: bridge -->
<!---->
<!-- volumes: -->
<!--   postgres_data: -->
<!-- ``` -->
<!---->
<!-- docker-compose.traefik.yml -->
<!-- ```yml -->
<!-- version: "3.9" -->
<!---->
<!-- services: -->
<!--   traefik: -->
<!--     image: traefik:v3.0 -->
<!--     ports: -->
<!--       - 80:80 -->
<!--       - 443:443 -->
<!--     volumes: -->
<!--       - /var/run/docker.sock:/var/run/docker.sock -->
<!--       - ./letsencrypt:/letsencrypt -->
<!--     command: -->
<!--       - --api.insecure=true -->
<!--       - --api.dashboard=true -->
<!--       - --providers.docker=true -->
<!--       - --providers.docker.exposedByDefault=false -->
<!--       - --entrypoints.web.address=:80 -->
<!--       - --entrypoints.web.http.redirections.entrypoint.to=websecure -->
<!--       - --entryPoints.web.http.redirections.entrypoint.scheme=https -->
<!--       - --entrypoints.websecure.address=:443 -->
<!--       - --entrypoints.websecure.asDefault=true -->
<!--       - --certificatesresolvers.letsencrypt.acme.tlschallenge=true -->
<!--       - --certificatesresolvers.letsencrypt.acme.email=benjaminshawki@gmail.com -->
<!--       - --certificatesresolvers.letsencrypt.acme.storage=/letsencrypt/acme.json -->
<!---->
<!--     labels: -->
<!--       - traefik.enable=true -->
<!--       - traefik.http.routers.traefik.rule=Host(`traefik.${ROOT_DOMAIN}`) -->
<!--       - traefik.http.routers.traefik.service=api@internal -->
<!--       - traefik.http.routers.traefik.entrypoints=websecure -->
<!--       - traefik.http.routers.traefik.tls.certresolver=letsencrypt -->
<!--       - traefik.http.middlewares.redirect-to-https.redirectscheme.scheme=https -->
<!--       - traefik.http.routers.http-catchall.rule=HostRegexp(`{host:.+}`) -->
<!--       - traefik.http.routers.http-catchall.entrypoints=web -->
<!--       - traefik.http.routers.http-catchall.middlewares=redirect-to-https -->
<!--     restart: unless-stopped -->
<!---->
<!--   db: -->
<!--     image: postgres:14 -->
<!--     volumes: -->
<!--       - postgres_data:/var/lib/postgresql/data -->
<!--     environment: -->
<!--       POSTGRES_DB: ${POSTGRES_DB} -->
<!--       POSTGRES_USER: ${POSTGRES_USER} -->
<!--       POSTGRES_PASSWORD: ${POSTGRES_PASSWORD} -->
<!--     ports: -->
<!--       - 5433:5432 -->
<!---->
<!--   backend: -->
<!--     image: ${IMAGE_BACKEND} -->
<!--     build: -->
<!--       context: ./PintAndPillageJavaBackend/ -->
<!--       dockerfile: Dockerfile -->
<!--     volumes: -->
<!--       - ./PintAndPillageJavaBackend:/app -->
<!--       - /app/target -->
<!--     ports: -->
<!--       - 8080:8080 -->
<!--     environment: -->
<!--       SPRING_DATASOURCE_URL: jdbc:postgresql://db:5432/${POSTGRES_DB} -->
<!--       SPRING_DATASOURCE_USERNAME: ${SPRING_DATASOURCE_USERNAME} -->
<!--       SPRING_DATASOURCE_PASSWORD: ${SPRING_DATASOURCE_PASSWORD} -->
<!--       SPRING_JPA_HIBERNATE_DDL_AUTO: create-drop -->
<!--       JWT_SECRET: ${JWT_SECRET} -->
<!--       LOGGING_LEVEL_ORG_SPRINGFRAMEWORK_WEB: DEBUG -->
<!--       LOGGING_LEVEL_ORG_HIBERNATE_SQL: INFO -->
<!--     depends_on: -->
<!--       - db -->
<!---->
<!--   frontend-placeholder: -->
<!--     image: ${CI_REGISTRY_IMAGE}/${CI_COMMIT_REF_NAME}/frontend-traefik:${CI_COMMIT_SHORT_SHA} -->
<!--     build: -->
<!--       context: . -->
<!--       dockerfile: PintAndPillageFrontend/Dockerfile -->
<!--     labels: -->
<!--       - traefik.enable=true -->
<!--       - traefik.http.routers.frontend-traefik-${CI_COMMIT_SHORT_SHA}.rule=${TRAEFIK_ROUTER_RULE} -->
<!--       - traefik.http.routers.frontend-traefik-${CI_COMMIT_SHORT_SHA}.entrypoints=websecure -->
<!--       - traefik.http.routers.frontend-traefik-${CI_COMMIT_SHORT_SHA}.tls.certresolver=letsencrypt -->
<!--       - traefik.http.services.frontend-traefik-${CI_COMMIT_SHORT_SHA}.loadbalancer.server.port=80 -->
<!--       - traefik.http.middlewares.strip-www.redirectregex.regex=^https://www\.(.+) -->
<!--       - traefik.http.middlewares.strip-www.redirectregex.replacement=https://$${1} -->
<!--       - traefik.http.routers.frontend-${CI_COMMIT_SHORT_SHA}.middlewares=strip-www -->
<!--     environment: -->
<!--       VUE_APP_BACKEND_URL: ${BACKEND_URL} -->
<!--       VUE_APP_CI_COMMIT_SHORT_SHA: ${CI_COMMIT_SHORT_SHA} -->
<!--       VUE_APP_ROOT_DOMAIN: ${ROOT_DOMAIN} -->
<!--       VUE_APP_FRONTEND_URL: ${FRONTEND_URL} -->
<!--       VUE_APP_REVERSE_PROXY_PROVISIONER: ${PROXY_PROVIDER} -->
<!--     depends_on: -->
<!--       - traefik -->
<!---->
<!-- volumes: -->
<!--   letsencrypt: -->
<!--     name: letsencrypt -->
<!---->
<!--   postgres_data: -->
<!-- ``` -->
<!---->
<!-- make-sha-root-domain.sh -->
<!-- ```sh -->
<!-- #!/bin/bash -->
<!---->
<!-- start_time=$(date +%s) -->
<!-- echo "Start time: $(date)" -->
<!---->
<!-- # Ensure the script is called with exactly three arguments. -->
<!-- if [[ "$#" -ne 3 ]]; then -->
<!--     echo "Usage: $0 <short_sha_of_service> <root_domain> <proxy_provider>" -->
<!--     exit 1 -->
<!-- fi -->
<!---->
<!-- TARGET_SHA=$1 -->
<!-- ROOT_DOMAIN=$2 -->
<!-- PROXY_PROVIDER=$3 -->
<!-- DEPLOYMENT_DIR="$HOME/deployments" -->
<!-- CURRENT_PROVIDER_FILE="${DEPLOYMENT_DIR}/current_proxy_provider.txt" -->
<!-- CERT_DIR="/etc/letsencrypt/live/${ROOT_DOMAIN}" -->
<!---->
<!-- # Log the received arguments -->
<!-- echo "Script called with arguments:" -->
<!-- echo "TARGET_SHA: $TARGET_SHA" -->
<!-- echo "ROOT_DOMAIN: $ROOT_DOMAIN" -->
<!-- echo "PROXY_PROVIDER: $PROXY_PROVIDER" -->
<!---->
<!-- # Load the current proxy provider if it exists -->
<!-- if [[ -f "$CURRENT_PROVIDER_FILE" ]]; then -->
<!--     CURRENT_PROVIDER=$(cat "$CURRENT_PROVIDER_FILE") -->
<!--     echo "Loaded current proxy provider: $CURRENT_PROVIDER" -->
<!-- else -->
<!--     CURRENT_PROVIDER="" -->
<!--     echo "No current proxy provider file found. Assuming no provider is set." -->
<!-- fi -->
<!---->
<!-- # Updates the routing rule for a given service SHA. -->
<!-- update_routing_rule() { -->
<!--     local sha=$1 -->
<!--     local add_root_domain=$2 -->
<!---->
<!--     echo "Updating routing rule for SHA $sha with add_root_domain=$add_root_domain" -->
<!---->
<!--     case "$PROXY_PROVIDER" in -->
<!--         traefik) -->
<!--             local file="${DEPLOYMENT_DIR}/${sha}-docker-compose.traefik.yml" -->
<!---->
<!--             # Check if the Docker Compose file exists. -->
<!--             if [[ ! -f "$file" ]]; then -->
<!--                 echo "File not found: $file" -->
<!--                 return -->
<!--             fi -->
<!---->
<!--             echo "Updating Traefik routing rule in $file" -->
<!---->
<!--             # Determine the new rule based on whether to add or remove the root domain. -->
<!--             local new_rule="Host(\`${sha}.${ROOT_DOMAIN}\`)" -->
<!--             if [[ "$add_root_domain" == "true" ]]; then -->
<!--                 new_rule+=" || Host(\`${ROOT_DOMAIN}\`) || Host(\`www.${ROOT_DOMAIN}\`)" -->
<!--             fi -->
<!---->
<!--             echo "New Traefik rule: $new_rule" -->
<!---->
<!--             # Update the routing rule using yq. -->
<!--             yq e -i "(.services.\"frontend-${PROXY_PROVIDER}-$sha\".labels.[] | select(test(\"traefik.http.routers.frontend-${PROXY_PROVIDER}-$sha.rule=\"))) = \"traefik.http.routers.frontend-${PROXY_PROVIDER}-$sha.rule=$new_rule\"" "$file" -->
<!--             ;; -->
<!---->
<!--         nginx) -->
<!--             local nginx_conf="${DEPLOYMENT_DIR}/${TARGET_SHA}-nginx.conf" -->
<!---->
<!--             echo "Generating NGINX configuration with $sha for $TARGET_SHA" -->
<!---->
<!--             # Generate the NGINX server block -->
<!--             cat <<EOF >> "$nginx_conf" -->
<!-- server { -->
<!--     listen 80; -->
<!--     server_name ${sha}.${ROOT_DOMAIN}; -->
<!--     server_tokens off; -->
<!---->
<!--     location /.well-known/acme-challenge/ { -->
<!--         root /var/www/certbot; -->
<!--     } -->
<!---->
<!--     location / { -->
<!--         return 301 https://\$host\$request_uri; -->
<!--     } -->
<!-- } -->
<!---->
<!-- server { -->
<!--     listen 443 ssl; -->
<!--     server_name ${sha}.${ROOT_DOMAIN}; -->
<!--     server_tokens off; -->
<!---->
<!--     ssl_certificate /etc/letsencrypt/live/${ROOT_DOMAIN}/fullchain.pem; -->
<!--     ssl_certificate_key /etc/letsencrypt/live/${ROOT_DOMAIN}/privkey.pem; -->
<!--     include /etc/letsencrypt/options-ssl-nginx.conf; -->
<!--     ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; -->
<!---->
<!--     location / { -->
<!--         proxy_pass http://deployments-frontend-nginx-${sha}-1:80; -->
<!--         proxy_set_header Host \$host; -->
<!--         proxy_set_header X-Real-IP \$remote_addr; -->
<!--         proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for; -->
<!--         proxy_set_header X-Forwarded-Proto \$scheme; -->
<!--     } -->
<!-- } -->
<!---->
<!-- EOF -->
<!---->
<!--             if [[ "$add_root_domain" == "true" ]]; then -->
<!--                 cat <<EOF >> "$nginx_conf" -->
<!-- server { -->
<!--     listen 80; -->
<!--     server_name ${ROOT_DOMAIN}; -->
<!--     server_tokens off; -->
<!---->
<!--     location /.well-known/acme-challenge/ { -->
<!--         root /var/www/certbot; -->
<!--     } -->
<!---->
<!--     location / { -->
<!--         return 301 https://\$host\$request_uri; -->
<!--     } -->
<!-- } -->
<!---->
<!-- server { -->
<!--     listen 443 ssl; -->
<!--     server_name ${ROOT_DOMAIN}; -->
<!--     server_tokens off; -->
<!---->
<!--     ssl_certificate /etc/letsencrypt/live/${ROOT_DOMAIN}/fullchain.pem; -->
<!--     ssl_certificate_key /etc/letsencrypt/live/${ROOT_DOMAIN}/privkey.pem; -->
<!--     include /etc/letsencrypt/options-ssl-nginx.conf; -->
<!--     ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; -->
<!---->
<!--     location / { -->
<!--         proxy_pass http://deployments-frontend-nginx-${TARGET_SHA}-1:80; -->
<!--         proxy_set_header Host \$host; -->
<!--         proxy_set_header X-Real-IP \$remote_addr; -->
<!--         proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for; -->
<!--         proxy_set_header X-Forwarded-Proto \$scheme; -->
<!--     } -->
<!-- } -->
<!-- EOF -->
<!--             fi -->
<!---->
<!--             echo "Updated NGINX configuration:" -->
<!--             cat "$nginx_conf" -->
<!--             ;; -->
<!--         *) -->
<!--             echo "Unsupported proxy provider: $PROXY_PROVIDER" -->
<!--             return 1 -->
<!--             ;; -->
<!--     esac -->
<!-- } -->
<!---->
<!-- # Always create a new NGINX configuration file -->
<!-- > "${DEPLOYMENT_DIR}/${TARGET_SHA}-nginx.conf" -->
<!-- cat "${DEPLOYMENT_DIR}/${TARGET_SHA}-nginx.conf" -->
<!---->
<!-- # Determine if we need to redeploy all services -->
<!-- echo "Proxy provider from $CURRENT_PROVIDER to $PROXY_PROVIDER..." -->
<!---->
<!-- # Capture the list of relevant services -->
<!-- services_nginx=$(docker ps --filter "name=deployments-frontend-nginx-" --format "{{.Names}}") -->
<!-- echo "services_nginx: $services_nginx" -->
<!-- services_traefik=$(docker ps --filter "name=deployments-frontend-traefik-" --format "{{.Names}}") -->
<!-- echo "services_traefik: $services_traefik" -->
<!---->
<!-- # Extract SHA values from nginx services -->
<!-- SHA_nginx=$(echo "$services_nginx" | sed -n 's/.*nginx-\([0-9a-f]\+\)-[0-9]\+$/\1/p') -->
<!-- echo "SHA_nginx: $SHA_nginx" -->
<!---->
<!-- # Extract SHA values from traefik services -->
<!-- SHA_traefik=$(echo "$services_traefik" | sed -n 's/.*traefik-\([0-9a-f]\+\)-[0-9]\+$/\1/p') -->
<!-- echo "SHA_traefik: $SHA_traefik" -->
<!---->
<!-- # Combine both SHA lists and remove duplicates -->
<!-- all_shas=$(echo -e "$SHA_nginx -->
<!-- $SHA_traefik" | sort | uniq) -->
<!-- echo "all_shas: $all_shas" -->
<!---->
<!-- # Stop all running containers -->
<!-- if [[ "$CURRENT_PROVIDER" != "$PROXY_PROVIDER" ]]; then -->
<!--     echo "Stopping all running containers..." -->
<!--     docker stop $(docker ps -a -q) -->
<!-- fi -->
<!---->
<!-- docker compose -f "${DEPLOYMENT_DIR}/${TARGET_SHA}-docker-compose.${PROXY_PROVIDER}.yml" up -d backend db -->
<!---->
<!-- bring_up_backend_end=$(date +%s) -->
<!-- echo "Time after bringing up backend and database services: $(date)" -->
<!-- echo "Duration so far: $((bring_up_backend_end - start_time)) seconds" -->
<!---->
<!-- if [[ $PROXY_PROVIDER == "traefik" ]]; then -->
<!--     docker compose -f "${DEPLOYMENT_DIR}/${TARGET_SHA}-docker-compose.${PROXY_PROVIDER}.yml" up -d traefik -->
<!-- fi -->
<!---->
<!-- bring_up_traefik_end=$(date +%s) -->
<!--    echo "Time after bringing up traefik service: $(date)" -->
<!--    echo "Duration so far: $((bring_up_traefik_end - start_time)) seconds" -->
<!---->
<!-- echo "Redeploying each non root service..." -->
<!-- # Step 1: Run update_routing_rule in parallel for all SHAs -->
<!-- echo "$all_shas" | while read -r SHA; do -->
<!--     if [[ -n "$SHA" && "$SHA" != "$TARGET_SHA" ]]; then -->
<!--         update_routing_start=$(date +%s) -->
<!--         echo "Time before running update_routing_rule for each SHA: $(date)" -->
<!--         echo "Duration so far: $((update_routing_start - start_time)) seconds" -->
<!--         update_routing_rule "$SHA" "false" & -->
<!--     fi -->
<!-- done -->
<!---->
<!-- # Wait for all update_routing_rule processes to finish -->
<!-- wait -->
<!---->
<!-- update_routing_end=$(date +%s) -->
<!-- echo "Time after running update_routing_rule for each SHA: $(date)" -->
<!-- echo "Duration so far: $((update_routing_end - start_time)) seconds" -->
<!---->
<!-- # Step 2: Run docker compose up in parallel for all SHAs -->
<!-- echo "$all_shas" | while read -r SHA; do -->
<!--     if [[ -n "$SHA" && "$SHA" != "$TARGET_SHA" ]]; then -->
<!--         bring_up_start=$(date +%s) -->
<!--         echo "Time before running docker compose up for each SHA: $(date)" -->
<!--         echo "Duration so far: $((bring_up_start - start_time)) seconds" -->
<!---->
<!--         docker compose -f "${DEPLOYMENT_DIR}/${SHA}-docker-compose.${PROXY_PROVIDER}.yml" up -d frontend-${PROXY_PROVIDER}-$SHA & -->
<!--     fi -->
<!-- done -->
<!---->
<!-- # Wait for all docker compose up processes to finish -->
<!-- wait -->
<!---->
<!-- bring_up_end=$(date +%s) -->
<!-- echo "Time after running docker compose up for each SHA: $(date)" -->
<!-- echo "Duration so far: $((bring_up_end - start_time)) seconds" -->
<!---->
<!-- # Update the target service to include the root domain. -->
<!-- update_routing_rule "$TARGET_SHA" "true" -->
<!---->
<!-- update_routing_root_end=$(date +%s) -->
<!-- echo "Time after updating ROOT routing rule for target SHA: $(date)" -->
<!-- echo "Duration so far: $((update_routing_root_end - start_time)) seconds" -->
<!---->
<!-- docker compose -f "${DEPLOYMENT_DIR}/${TARGET_SHA}-docker-compose.${PROXY_PROVIDER}.yml" up -d frontend-${PROXY_PROVIDER}-${TARGET_SHA} -->
<!---->
<!-- bring_up_target_root_end=$(date +%s) -->
<!-- echo "Time after bringing up target service with root domain: $(date)" -->
<!-- echo "Duration so far: $((bring_up_target_root_end - start_time)) seconds" -->
<!---->
<!-- if [[ ${PROXY_PROVIDER} == "nginx" ]]; then -->
<!--     cp "${DEPLOYMENT_DIR}/${TARGET_SHA}-nginx.conf" /home/deployer/data/nginx/${TARGET_SHA}.conf -->
<!---->
<!--     cat <<EOF > /home/deployer/data/nginx.conf -->
<!-- user nginx; -->
<!-- worker_processes auto; -->
<!---->
<!-- error_log /var/log/nginx/error.log warn; -->
<!-- pid /var/run/nginx.pid; -->
<!---->
<!-- events { -->
<!--     worker_connections 1024; -->
<!-- } -->
<!---->
<!-- http { -->
<!--     resolver 127.0.0.11 ipv6=off; -->
<!---->
<!--     # Include all server configurations -->
<!--     include /etc/nginx/conf.d/${TARGET_SHA}.conf; -->
<!-- } -->
<!-- EOF -->
<!---->
<!--     time_after_copying_nginx_conf=$(date +%s) -->
<!--     echo "Time after copying nginx configuration: $(date)" -->
<!--     echo "Duration so far: $((time_after_copying_nginx_conf - start_time)) seconds" -->
<!---->
<!--     docker compose -f "${DEPLOYMENT_DIR}/${TARGET_SHA}-docker-compose.${PROXY_PROVIDER}.yml" build --no-cache nginx -->
<!--     docker compose -f "${DEPLOYMENT_DIR}/${TARGET_SHA}-docker-compose.${PROXY_PROVIDER}.yml" up -d nginx -->
<!---->
<!--     docker exec deployments-nginx-1 nginx -s reload -->
<!---->
<!--     bring_up_nginx_end=$(date +%s) -->
<!--     echo "Time after bringing up nginx service: $(date)" -->
<!--     echo "Duration so far: $((bring_up_nginx_end - start_time)) seconds" -->
<!-- fi -->
<!---->
<!-- # Save the new proxy provider as the current provider -->
<!-- echo "$PROXY_PROVIDER" > "$CURRENT_PROVIDER_FILE" -->
<!---->
<!-- end_time=$(date +%s) -->
<!-- echo "End time: $(date)" -->
<!-- echo "Total duration: $((end_time - start_time)) seconds" -->
<!---->
<!-- echo "Deployment completed." -->
<!-- ``` -->
<!---->
<!-- rollback-time.sh -->
<!-- ```sh -->
<!-- #!/bin/bash -->
<!-- SHORT_SHA=$1 -->
<!-- ROOT_DOMAIN=$2 -->
<!-- PROXY_PROVIDER=$3 -->
<!---->
<!-- SERVER_USER=deployer -->
<!---->
<!-- if [ -z "$SHORT_SHA" ] || [ -z "$ROOT_DOMAIN" ] || [ -z "$PROXY_PROVIDER" ]; then -->
<!--   echo "Usage: $0 <short_sha> <root_domain> <proxy_provider>" -->
<!--   exit 1 -->
<!-- fi -->
<!---->
<!-- # Count the number of active frontend services before the switch -->
<!-- ACTIVE_SERVICES=$(docker ps --filter "name=deployments-frontend-${PROXY_PROVIDER}-" --format "{{.Names}}" | wc -l) -->
<!---->
<!-- # Capture the start time in milliseconds -->
<!-- START_TIME=$(date +%s%3N) -->
<!---->
<!-- /home/${SERVER_USER}/make-sha-root-domain.sh $SHORT_SHA $ROOT_DOMAIN $PROXY_PROVIDER -->
<!---->
<!-- # Capture the end time in milliseconds -->
<!-- END_TIME=$(date +%s%3N) -->
<!---->
<!-- # Calculate the elapsed time in milliseconds -->
<!-- ELAPSED_TIME=$(($END_TIME - $START_TIME)) -->
<!---->
<!---->
<!-- REPORTS_DIR="/home/${SERVER_USER}/reports/rollback-times" -->
<!-- ROLLBACK_TIME_FILE="${REPORTS_DIR}/${START_TIME}_${SHORT_SHA}_${ROOT_DOMAIN}_${PROXY_PROVIDER}_rollback_time.csv" -->
<!---->
<!-- # Write the result to the appropriate file -->
<!-- echo "timestamp,sha,proxy_provider,elapsed_time,total_active_frontend_services" > ${ROLLBACK_TIME_FILE} -->
<!-- echo "$(date +%Y-%m-%d:%H:%M:%S),${SHORT_SHA},${PROXY_PROVIDER},${ELAPSED_TIME},${ACTIVE_SERVICES}" >> ${ROLLBACK_TIME_FILE} -->
<!-- ``` -->
<!---->
<!-- generate-report.sh -->
<!-- ```sh -->
<!-- #!/bin/bash -->
<!-- SERVER_USER=deployer -->
<!---->
<!-- mkdir -p /home/${SERVER_USER}/reports/rollback-times -->
<!---->
<!-- # Directory where the CSV files are stored -->
<!-- REPORTS_DIR="/home/${SERVER_USER}/reports/rollback-times" -->
<!---->
<!-- # Output file that will contain all the data -->
<!-- OUTPUT_FILE="/home/${SERVER_USER}/reports/combined_rollback_times.csv" -->
<!---->
<!-- # Check if the output file already exists and remove it to avoid appending to an old file -->
<!-- if [ -f "$OUTPUT_FILE" ]; then -->
<!--   rm "$OUTPUT_FILE" -->
<!-- fi -->
<!---->
<!-- # Loop through all the rollback time CSV files in the reports directory -->
<!-- for FILE in ${REPORTS_DIR}/*_rollback_time.csv; do -->
<!--   if [ -f "$FILE" ]; then -->
<!--     # If the output file doesn't exist yet, copy the header from the first CSV file -->
<!--     if [ ! -f "$OUTPUT_FILE" ]; then -->
<!--       head -n 1 "$FILE" > "$OUTPUT_FILE" -->
<!--     fi -->
<!--     # Append all the lines except the header to the output file -->
<!--     tail -n +2 "$FILE" >> "$OUTPUT_FILE" -->
<!--   fi -->
<!-- done -->
<!---->
<!-- echo "All CSV files have been combined into $OUTPUT_FILE" -->
<!-- ``` -->
<!---->
<!---->
