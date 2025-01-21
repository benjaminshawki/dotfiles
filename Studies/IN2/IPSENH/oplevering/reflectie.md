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
  \fancyhead[C]{Reflectie document IPSENH}
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
date: P4 2024
output: 
  pdf_document:
    template: template.tex
lang: nl
figureTitle: "Figuur"
figPrefix: "Figuur"
secPrefix: ""
---

\includepdf[pages=-]{./reflectie-voorblad-bewerkt.pdf}


# Reflectie document
Dit document bevat de reflectie van Benjamin Shawki over het project IPSENH.

## Eigen functioneren
Tijdens het project heb ik mij vooral bezig gehouden met het opzetten van de proxmox infrastructuur en het maken van de vps backend.

De voorgaand infrastructuur was opgezet met behulp van VMWare en deze moest worden overgezet naar Proxmox. Deze proxmox omgeving werd opgezet door de samenwerking tussen Matthijs Smets, Ron Arts, en Prashant Lalkoe. Mijn rol als teamlid infra was om een initiële Proxmox omgeving op te zetten en de bestaande VMWare omgeving over te zetten naar Proxmox. Ik wilde hiermee ervaring opdoen met het beheren van een hypervisor in een productie omgeving. Ik verwachte hierbij veel te leren over het opzetten van een server en er werd van mij verwacht dat ik mijn kennis die ik heb opgedaan tijdens het experimenten met Proxmox kon toepassen in een productie omgeving. Dit heb ik gedaan door lokaal een Proxmox omgeving op te zetten en te experimenteren met de verschillende functies die Proxmox biedt. Dit heb ik gedaan omdat ik slechts een beperkte ervaring had met Proxmox en concepten als clustering door het verbinden van nodes, het opzetten van shared storage en het verbinden van de Proxmox Backup Server. Dit verliep niet altijd even soepel, en tijdens het project gingen er een aantal dingen niet volledig volgens plan zoals het verliezen van de oude data, en het niet kunnen configureren van de Proxmox Backup Server vanwege ontbrekende hardware.

Verder heb ik mij bezig gehouden met het opzetten van de VPS backend. Dit was een grote uitdaging en heeft veel tijd gekost.
Voorgaande aan dit project had ik beperkte ervaring met spring-boot. Ik heb de verbinding gemaakt tussen de auth service, billing service binnen de vps service. Verschillende endpoints zijn gemaakt en de logica is neergezet voor het aanmaken van een VPS.

Ik heb veel geleerd over het opzetten van een VPS en het beheren van een server. Ook heb ik door dit project veel ervaring ondervonden over wat het betekend om in een team te werken en hoe je moet samenwerken met andere teams. Ook vond ik het erg fijn om over de schouder van Ron mee te kijken en te leren van zijn ervaringen. Ik hem erg dankbaar voor zijn expertise en hulp.

Ook heb ik door dit project veel ervaring ondervonden over wat het betekend om in een team te werken en hoe je moet samenwerken met andere teams. Naast het samenwerken met Matthijs heb ik ook veel samengewerkt met Sven Kortekaas om verbinding te maken met de auth repository. Verder heb ik ook nader samengewerkt met het billingteam om de VPS backend te koppelen aan de billing service. Deze samenwerking was erg fijn en verliep soepel.

## Gegeven feedback teamlid
Gedurende het project heb ik een fijne samenwerking ondervonden met Matthijs Smets. We konden het goed vinden en zijn samen tot oplossingen gekomen voor lastige problemen. We hebben elkaar goed aangevuld en konden goed samenwerken. We hebben veel van elkaar geleerd en hebben elkaar geholpen waar nodig.
Tijdens de initiële opzet van Proxmox in onze testomgeving hebben we goed samengewerkt en hebben we samen naar oplossingen gezocht voor problemen die we tegenkwamen. Later in het project hebben we samen de VPS backend opgezet waarvan Matthijs de initele opzet gemaakt heeft om verbinding te maken met de Proxmox API. Samen zijn wij deze backend gaan uitbreiden. 
Tijdens het uitbreiden van de vps backend heb ik erg veel geleerd van Matthijs, voornamelijk binnen Java en Spring Boot waar hij zelf veel meer ervaring in heeft. Ik ben Matthijs dan ook erg dankbaar voor de hulp die hij mij geboden heeft en de kennis die hij met mij gedeeld heeft. Dit heeft er voor mij gezorgd dat ik zelfverzekerder ben geworden in het werken met Java en Spring Boot.

Matthijs heeft het als Teamlead erg goed gedaan. Na alle Teamlead meetings heeft hij mij altijd goed op de hoogte gebracht van de stand van zaken en heeft hij mij altijd goed geïnformeerd over de taken die we moesten uitvoeren.

Het enige kleine puntje van kritiek is dat ik graag had willen zien dat Matthijs na de Teamlead meetings voor alle punten die besproken waren en die relevant waren voor ons team, een issue had aangemaakt in Gitlab met de benodigde informatie. Dit had het voor mij makkelijker gemaakt om te weten wat er van mij verwacht werd en wat ik moest doen.

Al met al heb ik een fijne samenwerking gehad met Matthijs en heb ik veel van hem geleerd.

## Gekregen feedback teamlid
_Tijdens het project vormde Benjamin Shawki en ik samen een team. Bij de start van het project kwamen wij erachter dat we ons allebei als teamlead hadden opgegeven, hierbij gaf Benjamin aan dat hij vooral betrokken wilde zijn in het contact met de systeembeheerder van Hogeschool Leiden en niet zozeer de teamlead vergaderingen. Toen is besloten dat ik teamlead zou worden, omdat het contact met de systeembeheerder niet afhankelijk was van de teamlead rol._

_Vanwege de kleinte van ons team verliep de samenwerking erg gemakkelijk, wij kwamen er al snel achter dat we op veel vlakken op één lijn liggen, wat de samenwerking ten goede kwam. Na elke teamlead vergadering bracht ik Benjamin op de hoogte van de laatste stand van zaken en bespraken we waar nodig de prioriteit van de dingen die wij nog moesten doen._

_Aan Benjamin wil ik meegeven dat ik de samenwerking als erg prettig heb ervaren. Met mijn kennis van Spring-boot en Angular en Benjamin zijn kennis van Linux en scripting vulden we elkaar goed aan. Benjamin was gedurende het project erg proactief, hij zorgde ervoor dat hij altijd wat te doen had, vroeg hulp als hij ergens niet uitkwam en schoot te hulp als ik ergens niet uitkwam. Ik wil Benjamin dan ook prijzen voor zijn werkhouding en instelling, een prettige ervaring als deze heb ik nog niet eerder gehad tijdens een IPSEN project. Als enige kritiek puntje wil ik Benjamin meegeven dat hij moet letten op zijn tunnelvisie, soms was hij zover bezig met iets dat hij het lastig vond om toch voor de minder mooie oplossing te kiezen. Het is zeker geen slechte eigenschap om altijd naar de beste oplossing te streven, maar weten wanneer je de gekozen richting loslaat is net zo belangrijk._

_Al met al is de samenwerking tijdens dit project vlekkeloos verlopen en zou ik zonder twijfel een volgend project weer met Benjamin willen doen._

### Reflectie op de gekregen feedback
Ik ben erg dankbaar met de feedback die ik van Matthijs heb gekregen. Inderdaad aan het begin van het project was de teamlid rol aan mij toebedeeld, en deze heb ik afgestaan aan Matthijs omdat het voor mij voornamelijk ging om het opzetten van de Proxmox omgeving binnen de Server.

Ik ben blij dat hij de samenwerking als prettig heeft ervaren en dat hij mij prijst voor mijn werkhouding en instelling. Ik heb erg op hem kunnen rekenen en heb veel van hem heb kunnen leren. De feedback over tunnelvisie was mij inderdaad al reeds bekend. Door deze reflectie ben ik me er weer bewust van geworden dat ik moet werken aan deze tunnelvisie.
Ik ben blij dat Matthijs dit heeft aangegeven en ik zal hier in de toekomst aan werken.
