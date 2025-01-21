---
title: "Instant Rollback Feature met Docker en GitLab CI/CD: Traefik of Nginx?"
author: "Benjamin Shawki"
institute: "Hogeschool Leiden"
date: "Februari - Augustus 2024"
theme: "metropolis"
colortheme: "beaver"
header-includes:
  - \usecolortheme{dove}
  - \setbeamercolor{background canvas}{bg=black}
  - \setbeamercolor{normal text}{fg=white}
  - \usefonttheme{serif}
  - \usepackage{xcolor}
---

Instant Rollback Feature met Docker en GitLab CI/CD:

Traefik of Nginx?

---

# Inleiding
\vspace{-2em}
- Wat is Blue-Green Deployment?

-

- Waarom is een rollback essentieel?

-

- Hoe kan een instant rollback feature worden geïmplementeerd?

<!--
Script:
Vandaag presenteer ik mijn onderzoek naar het implementeren van een instant rollback feature binnen een Blue-Green Deployment strategie. Blue-Green Deployment is een techniek waarbij twee identieke productieomgevingen parallel draaien om nieuwe versies van een applicatie naadloos te implementeren. Als er iets misgaat, kan snel worden teruggeschakeld naar de vorige versie, zonder dat gebruikers hinder ondervinden.
-->
---

# Hoofdvraag
\vspace{-2em}

_"Wat zijn de verschillen in rollback tijd tussen Traefik en Nginx bij het implementeren van een blue-green deployment strategie voor de gebruikers binnen Hemiron’s hosting platform?"_

<!--
Script:
De centrale vraag van mijn onderzoek was: "Wat zijn de verschillen in rollback tijd tussen Traefik en Nginx bij het implementeren van een Blue-Green Deployment strategie voor Hemiron’s hosting platform?" Deze vraag is belangrijk omdat de snelheid van een rollback direct invloed heeft op de beschikbaarheid en betrouwbaarheid van het platform.
-->

---

# Deelvragen
\vspace{-2em}
_"Wat zijn de verschillen in configuratie tussen Traefik en Nginx bij het implementeren van een blue-green deployment strategie?"_

- 

_"Wat zijn de voordelen en uitdagingen van het gebruik van Traefik en Nginx bij het implementeren van een blue-green deployment strategie?"_

<!--
Script:
Naast de hoofdvraag heb ik ook gekeken naar de configuratieverschillen en de voor- en nadelen van Traefik en Nginx. Deze factoren zijn cruciaal om te bepalen welke tool het meest geschikt is voor de specifieke behoeften van Hemiron.
-->

---

# Methodiek
\vspace{-2em}

- Opzet van het experiment met Docker en GitLab CI/CD

-

- Uitrol op VPS met verschillende specificaties

-

- Rollback tijd als primaire performance metric

# Onderzoeksmethode
\vspace{-2em}

- Gebruik van Docker containers voor het draaien van applicaties en reverse proxies.

-

- GitLab CI/CD pipeline voor het automatiseren van de uitrol en rollback.

-

- Metingen uitgevoerd op VPS-servers met verschillende specificaties om variabiliteit in prestaties te onderzoeken.

# Set-up Details
\vspace{-2em}
- **Low Specs VPS:**
  - 1 vCPU, 1GB RAM, 25GB Disk
  - Beperkte prestaties, simuleert een productieomgeving met minimale middelen.

-

- **"High Specs VPS":**
  - 4 vCPU's, 8GB RAM, 25GB Disk
  - Hogere prestaties, bedoeld om de impact van betere hardware te evalueren.

# Pipeline Stappen
\vspace{-2em}
1. **Prepare:** Configuratie en scripts voorbereiden.

2. **Build:** Docker containers bouwen voor frontend en backend.

3. **Switch Domain:** Domeinomschakeling naar nieuwe versie.

4. **Report:** Rollback tijden meten en resultaten verzamelen.

<!--
Script:
Voor mijn onderzoek heb ik een experiment uitgevoerd met Docker containers en een GitLab CI/CD pipeline. Het experiment werd uitgevoerd op VPS-servers met verschillende specificaties, namelijk low-spec en high-spec VPS-omgevingen. Het doel was om de rollback tijden van Traefik en Nginx te meten onder verschillende omstandigheden en hardwareconfiguraties. De resultaten geven inzicht in de prestatieverschillen en helpen bij het kiezen van de juiste tool voor Hemiron’s hosting platform.
-->

--- 

# Inzomen op Switch Domain

**Traefik**
  - Labels aanpassen
  - Desbetreffende service herladen
  - Traefik container herconfigureert bij container updates

-

**Nginx**
  - Configuratiebestand aanpassen
  - Configuratiebestand bewaren
  - nginx binnen de Nginx container herladen

---

# Resultaten
\vspace{-2em}
**Low Specs**

- Nginx: 15.383 ms gemiddelde rollback tijd
- Traefik: 24.857 ms gemiddelde rollback tijd
- Significante prestatieverschillen

**High Specs**

- Nginx: 3.779 ms gemiddelde rollback tijd
- Traefik: 4.938 ms gemiddelde rollback tijd
- Betere prestaties bij beide, maar Nginx blijft sneller

<!--
Script:
De metingen op de low-spec VPS toonden aan dat Nginx gemiddeld sneller was dan Traefik, met een verschil van ongeveer 9,5 seconden in rollback tijd. Op een high-spec VPS werd dit verschil kleiner, maar Nginx bleef de snellere en meer consistente optie. Deze resultaten suggereren dat Nginx beter presteert in omgevingen waar snelheid en betrouwbaarheid cruciaal zijn.
-->

---

# Evaluatie van een Experiment
\vspace{-2em}

- **Nginx**: Complexe configuratie, maar sneller

-

- **Traefik**: Eenvoudige configuratie, maar iets langzamer

<!--
Script:
Uit de experimenten bleek dat Nginx, ondanks de complexere configuratie, robuuster en sneller presteert. Traefik scoorde echter punten op gebruiksgemak en flexibiliteit, wat het een aantrekkelijke optie maakt voor minder kritische omgevingen of waar snel schakelen tussen configuraties belangrijk is.
-->

---

# Conclusie
\vspace{-2em}

- **Nginx**: Beste keuze voor omgevingen waar snelheid essentieel is

- 

- **Traefik**: Eenvoudiger te configureren en geschikt voor microservices

-

- **Aanbeveling**: Klanten van Hemiron zouden Nginx moeten overwegen als rollbacksnelheid prioriteit heeft


<!--
Script:
Mijn onderzoek concludeert dat Nginx de voorkeur heeft in situaties waar de snelheid van rollbacks essentieel is. Voor omgevingen waar eenvoud in configuratie belangrijker is, blijft Traefik een solide keuze.
-->

---

# Afronding
\vspace{-2em}
- Dankwoord aan begeleiders en community

-

- Vragen?

<!--
Script:
Tot slot wil ik mijn begeleiders en de online community bedanken voor hun bijdrage aan dit onderzoek. Zijn er nog vragen?
-->

