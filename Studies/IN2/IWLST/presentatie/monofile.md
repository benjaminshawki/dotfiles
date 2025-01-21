---
title: "Implementatie en Integratie van A/B-Testen in E-commerce"
subtitle: "Een Casestudie bij PLNTS"
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
  \fancyhead[C]{Onderzoek}
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
  \usepackage{listings}
  \renewcommand{\lstlistingname}{Code fragment}
  \lstset{
    basicstyle=\ttfamily,
    frame=single
  }
date: September 2023 - Februari 2024
output: 
  pdf_document:
    template: template.tex
lang: nl
figureTitle: "Figuur"
figPrefix: "Figuur"
secPrefix: ""
lstPrefix: "Code fragment"
listingTitle: "Code fragment"
exPrefix: "Voorbeeld"
exampleTitle: "Voorbeeld"
---
\begin{center}
\LARGE Onderzoek
\end{center}

![PLNTS Logo](./images/plnts-logo.png){#fig:plnts-logo width=100%}

\newpage
\begin{center}
\LARGE Versiebeheer
\end{center}

| Versie    | Datum    | Notitie    |
|---------------- | --------------- | --------------- |
| 0.1    | 2024-01-23    | Eerste concept versie    |
| 0.2    | 2024-01-27    | Verwerken feedback van Remco    |
| 0.3    | 2024-01-28    | Laatste wijziginen inhoud    |
| 0.4   | 2024-01-29    | Gramatica en spelling's controle    |
| 1.0    | 2024-01-29    | Definitieve versie    |

\normalsize
\newpage
\tableofcontents
\newpage

# Inleiding
Er komt veel kijken bij het maken van een beslissing in een online platform.
Beslissingen worden vaak gemaakt op basis van intuïtie, ervaring, of een combinatie van beide.
Dit kan leiden tot een verkeerde beslissing, wat kan leiden tot een negatieve impact op de gebruikerservaring en de zakelijke resultaten.
Met A/B testen kan er een betere beslissing worden gemaakt op grond van data.
Het biedt een mechanisme om twee versies van een webpagina of applicatie tegenover elkaar te stellen en op basis van gebruikersinteracties te bepalen welke versie beter presteert.
Dit onderzoek worden de benodigde stappen verkent om een opzet te maken voor de implementatie en integratie van A/B Testen binnen het bestaande systeem van PLNTS. \newline

\large [Analyse A/B testen](#sec:analyse)
: &nbsp;
: Deze sectie verkent de basisprincipes van A/B testen en de rol ervan in het meten en verbeteren van de gebruikersinteractie. \newline

[Essentie van A/B Testen](#sec:essentie)
: &nbsp;
: Deze sectie verkent de basisprincipes van A/B testen en de rol ervan in het meten en verbeteren van de gebruikersinteractie. \newline

[Methodiek van A/B Testen](#sec:methodiek) 
: &nbsp;
: Hier wordt de methodologische aanpak van A/B testen onderzocht, inclusief het opstellen van hypotheses en het kiezen van metrics. \newline

[Belang van A/B Testen](#sec:belang) 
: &nbsp;
: Het belang van A/B-testen wordt benadrukt, met focus op hoe het bijdraagt aan data gedreven besluitvorming. \newline

[Metrics](#sec:metrics)
: &nbsp;
: Een overzicht van de metrics die relevant zijn voor PLNTS en hoe deze kunnen worden gebruikt om de resultaten van A/B testen te evalueren. \newline

[Evaluatie van een Experiment](#sec:evaluatie)
: &nbsp;
: Methodes en benaderingen voor het analyseren en interpreteren van A/B testresultaten. \newline

\large [Het Ontwerp](#sec:ontwerp) 
: &nbsp;
: De integratie van A/B-testen binnen de huidige PLNTS systemen vereist een zorgvuldige afweging van de impact op zowel gebruikers als de technische infrastructuur. Dit hoofdstuk behandelt de praktische uitvoering van A/B-testen, inclusief het tonen van variaties aan gebruikers, de implicaties voor het cookie beleid en SEO, en hoe Vercel en Next.js kunnen worden ingezet om de prestaties te optimaliseren en de gebruikerservaring te waarborgen.\newline

[Impact op het Huidige Systeem](#sec:impact) 
: &nbsp;
: Analyse van de invloed van A/B-testen op PLNTS' bestaande infrastructuur en processen. \newline

[Bestaande A/B-Testsystemen](#sec:bestaande-systemen) 
: &nbsp;
: Vergelijking van diverse A/B-testsystemen en hun relevantie voor PLNTS. \newline

[Opzet Integratie met het Huidige Systeem](#sec:opzet) 
: &nbsp;
: De specifieke opzet van A/B-testintegratie binnen PLNTS's bestaande systeem wordt in detail besproken, met aandacht voor de noodzakelijke configuraties en de rol van Vercel's Edge Network en Next.js's render strategieën. \newline

\large [Aanbevelingen](#sec:aanbeveling) en [Conclusies](#sec:conclusie)
: &nbsp;
: Overzicht van bevindingen en strategische aanbevelingen voor de toekomstige inzet van A/B-testen bij PLNTS. 

\newpage
# Analyse A/B-testen {#sec:analyse}
_Hoe kan PLNTS een intern A/B-testing systeem implementeren dat naadloos integreert met de bestaande infrastructuur?_

De wat, hoe en waarom vragen dienen te worden beantwoord om een zo een beter beeld te schetsen over het proces van A/B-testen. Deze worden respectievelijk in de hoofdstukken[@sec:essentie] [Essentie van A/B testen](#sec:essentie),[@sec:methodiek] [Methodiek van A/B testen](#sec:methodiek), en[@sec:belang] [Belang van A/B testen](#sec:belang) behandeld.

Google met hun platform _Optimizely_ heeft een artikel[ [@optimizley-glossary_ab-testing] ](#sec:bronnen) geschreven waarbij een aantal van deze vragen worden beantwoord. Daarnaast moet er een overzicht worden gemaakt van de bestaande A/B-testsystemen en de metrics die worden gebruikt om de resultaten van de A/B-testen te meten.

Dit onderzoek probeert de volgende vragen te beantwoorden.

- _Welke bestaande A/B-testing tools zijn beschikbaar en hoe vergelijken zij zich in termen van functies, prijsstelling en compatibiliteit met de PLNTS tech stack?_
- _Welke data en metrics zijn relevant voor PLNTS om te verzamelen en analyseren tijdens A/B-tests?_
- _Hoe kan de A/B-test data het best worden weergegeven voor effectieve interpretatie en besluitvorming door verschillende stakeholders zoals marketeers en ontwikkelaars?_
- _Wat zijn de technische vereisten voor het integreren van een A/B-testplatform met PLNTS's bestaande infrastructuur, zodat de website prestaties minimaal beïnvloed worden?_
- _Wat zijn de mogelijke cookie beleid implicaties bij het implementeren van externe A/B-testing tools?_
- _Wat is er nodig bij de implementatie van A/B-testen zodat deze geen negatieve impact heeft op de SEO van de website?_

\newpage
## Essentie van A/B testen {#sec:essentie}
A/B Testen, ook wel split-testen of bucket-testen genoemd, is een methode om twee versies van een webpagina of app te vergelijken en om te bepalen welke versie beter presteert.
Het wordt vaak gebruikt om de effectiviteit van veranderingen in de gebruikerservaring te testen, maar kan ook worden gebruikt om andere variabelen te testen, zoals prijs, inhoud en lay-out.

De twee versies (A en B) worden willekeurig maar gebalanceerd aan gebruikers getoond en de resultaten worden geanalyseerd om te bepalen welke versie beter presteert.
Gebalanceerd gesplitst betekent dat de gebruikers gelijkmatig worden verdeeld over de twee versies.
Dit wordt gedaan om ervoor te zorgen dat de resultaten van de test niet worden beïnvloed door een ongelijke verdeling van gebruikers.

Ook zijn er andere redenen om gebruikers niet willekeurig te verdelen over de twee versies.
Zoals het testen op bepaalde gebruikersgroepen met een karakteristiek eigenschap.
Zo kan het zijn dat je een nieuwe feature wilt testen op een gebruikersgroep die een bepaalde actie heeft uitgevoerd, zoals het aanmaken van een account.
Deze gebruikers kunnen vervolgens in een aparte groep worden geplaatst en worden blootgesteld aan de nieuwe feature.

Een ander reden kan zijn dat je verwacht dat het gedrag van gebruikers veranderd op basis van de intensiteit van het gebruik van de website.
High intensity gebruikers, die frequent en intensief interacteren met de website, kunnen anders reageren op wijzigingen dan low intensity gebruikers die de website sporadisch bezoeken. Het gedrag van deze twee groepen kan aanzienlijk verschillen, daarom kan het nuttig zijn om ze apart te testen.

Voor high intensity gebruikers kan een verandering in de interface of een nieuwe functie een directere impact hebben op hun gebruikservaring. Deze gebruikers zijn vaak meer betrokken en investeren meer tijd in de site, waardoor ze gevoeliger kunnen zijn voor subtiele wijzigingen.

Low intensity gebruikers daarentegen hebben een minder gedetailleerd beeld van de website en zijn mogelijk meer geïnteresseerd in algemene gebruiksgemak en toegankelijkheid. Een verandering die hen helpt sneller te vinden wat ze zoeken, kan bijvoorbeeld een grotere impact hebben op hun tevredenheid dan bij high intensity gebruikers.

Een gebalanceerde benadering in A/B-testen zorgt ervoor dat de resultaten representatief zijn voor het gehele gebruikersbestand. Het kan ook nodig zijn om aparte experimenten uit te voeren of de data apart te analyseren voor deze twee groepen om een duidelijk beeld te krijgen van hoe verschillende gebruikers op wijzigingen reageren.


![User Population [ [@practical-ab-testing] ](#sec:bronnen)](./images/user-population.png){#fig:user-population width=60%}

Zoals in [@fig:user-population] te zien bestaat de gebruikerspopulatie uit alle gebruikers die de website bezoeken. Deze gebruikerspopulatie wordt opgedeeld in twee groepen, de control groep en de test groep. De control groep is de groep die de huidige versie van de website te zien krijgt, de test groep is de groep die de nieuwe versie van de website te zien krijgt. De control groep en de test groep worden willekeurig gekozen uit de gebruikerspopulatie. De control groep en de test groep worden ook wel de varianten genoemd. De varianten worden aan de gebruikers getoond door middel van een A/B-test systeem. Dit systeem zorgt ervoor dat de gebruikers in de juiste variant worden geplaatst en dat de resultaten van de varianten worden gemeten. De resultaten van de varianten worden vervolgens geanalyseerd om te bepalen welke variant het beste presteert. De variant die het beste presteert, wordt vervolgens uitgerold naar de gehele gebruikerspopulatie.

Een A/B test te zien in [@fig:ab-test], vergelijkt een variatie van een pagina met een bestaande, en stelt de maker van de test mogelijk om vragen te stellen over de veranderingen binnen het platform. Bijvoorbeeld, welke versie van een productpagina leidt tot meer aankopen? Welke versie van een app leidt tot meer aanmeldingen? Welke versie van een e-mailcampagne leidt tot meer klikken? A/B-testen kan worden gebruikt om deze vragen te beantwoorden en om de effectiviteit van veranderingen te meten.

![Een A/B test [^ab-test]](./images/ab-test.png){#fig:ab-test width=50%}

[^ab-test]: Bron afbeelding: https://diggintravel.com/airline-ab-testing/

In andere woorden, A/B testen is een online gecontroleerd experiment welke de impact van een verandering meet op een subset van gebruikers[ [@practical-ab-testing] ](#sec:bronnen). Een effectieve A/B test is er één waarbij je zeker bent van besluitvorming gebaseerd op resultaat.

In een A/B test, ook wel een experiment genoemd, evalueer je verandering op gebruikers en meet je de uitkomst door gebruik te maken van data. De verandering welke geëvalueerd wordt als onderdeel van een experiment kan bestaan uit: 

- Een nieuwe UX ontwerp voor een pagina.
- Een nieuwe feature, of een wijziging van een bestaande feature.
- Een nieuwe software architectuur of een wijziging van een bestaande software architectuur.

Bij het ontwikkelen van producten gericht op de eindgebruiker is het doel de gebruikerservaring te verbeteren en zakelijke waarde te creëren. Door A/B-testen te gebruiken om veranderingen te beoordelen, kun je met de testresultaten nagaan of je de beoogde doelen bereikt.

Ook is A/B testen een risico management tool. Het kan de impact van een verandering te meten voordat deze wordt uitgerold naar alle gebruikers. Het is één van de beste manieren om nieuwe features te analyseren op de mogelijk schadelijke impact voor het bedrijf of product.

Om een product te innoveren en aan te passen aan de behoeften van zowel gebruikers als het bedrijf, is het niet nodig om direct het juiste antwoord te hebben. Het is belangrijker om methoden te hebben om te bepalen wat effectief is en impact heeft. A/B-testen zijn cruciaal om de effecten van aanpassingen binnen een constant evoluerend product te openbaren.

\newpage
## Methodiek van A/B testen {#sec:methodiek}
A/B testen is een methodologisch proces waarbij twee of meer versies van een pagina of app worden gepresenteerd aan verschillende gebruikersgroepen, meestal aangeduid als de control en test groepen. 

Het A/B-testproces bestaat uit de volgende stappen:

  - Het identificeren van een kans.
  - Het opstellen van een hypothese.
  - Het ontwerpen van een experiment.
  - Het uitvoeren van het experiment.
  - Het analyseren van de resultaten.
  - Het trekken van conclusies.

Bij het trekken van de conclusies is er vaak ook extra onderzoek nodig om de resultaten te kunnen verklaren. De resultaten van een A/B test vertelt je vaak wat er is gebeurd, maar om antwoord te krijgen op de waarom vraag zijn er vaak extra analyses nodig.

In de kern van A/B testen staat het opstellen van een heldere en weloverwogen hypothese. Deze hypothese stelt verwachtingen op over de uitkomst van de test en dient als een fundament voor het experiment. Het formuleren van een effectieve hypothese omvat niet alleen het voorspellen van een resultaat, maar ook het expliciet definiëren van succes en het vaststellen van de rationale achter de verwachte uitkomst.

Het kiezen van de juiste metrics is een ander vitaal aspect van A/B testen. Succesmetrics, zoals conversieratio's of gemiddelde tijd op pagina, helpen bij het meten van de directe impact van de test. 
Daarnaast zijn guardrail-metrics, zoals omzet, bounce rate en paginalaadtijd, essentieel om ervoor te zorgen dat de verandering geen onbedoelde negatieve effecten heeft.
Een uitgebreid overzicht van de metrics is te vinden in het hoofdstuk[@sec:metrics] [Metrics](#sec:metrics).

Een andere sleutelfactor in A/B testen is het gebruik van geschikte steekproeftechnieken. Deze technieken zorgen ervoor dat de test en controlegroepen representatief zijn en willekeurig gekozen worden, wat helpt aan de betrouwbaarheid en geldigheid van de testresultaten.
Dit wordt verder besproken in het hoofdstuk[@sec:betrouwbaarheid] [Betrouwbaarheid verhogen in Testresultaten](#sec:betrouwbaarheid).

Bij het uitvoeren van A/B testen is het belangrijk om consistentie te bewaren in de manier waarop gegevens worden verzameld en geanalyseerd. Dit betekend het vaststellen van duidelijke criteria voor het includeren van gebruikers in de test, het definiëren van wat een 'actieve' gebruiker is, en het zorgen voor een betrouwbare data-infrastructuur.

\newpage
## Belang van A/B testen {#sec:belang}
Het testen verandert giswerk in wetenschap. In plaats van te vertrouwen op giswerk om te bepalen welke versie van een pagina of app het beste presteert, kunnen A/B-testen en statistische analyse worden gebruikt om te bepalen welke versie beter presteert. Door A/B-testen te gebruiken om te experimenteren, kunnen bedrijven hun intuïtie vervangen door bewijs bij het nemen van beslissingen over hun producten, ook wel data-gedreven besluitvorming genoemd.

Met A/B testen verlaag je de kans om veranderingen te implementeren welke een negatieve impact hebben op de gebruikerservaring. 

### Het juiste type experiment kiezen
Bij het ontwerpen van een effectief experiment is een belangrijke stap het kiezen van het juiste type A/B-test. Elk type heeft specifieke situaties waarin het het meest geschikt is.

Superioriteitstests
: &nbsp; 
: Deze worden gebruikt om aan te tonen dat een nieuwe versie beter presteert dan de bestaande controleversie. Ze zijn ideaal voor situaties waarin je verwacht dat een nieuwe functie een duidelijke verbetering zal zijn. Bijvoorbeeld, een nieuwe gebruikersinterface die naar verwachting de betrokkenheid zal vergroten. \newline

Non-inferioriteitstests
: &nbsp; 
: Deze tests zijn gericht op het aantonen dat een nieuwe versie niet significant slechter is dan de controle. Deze zijn nuttig wanneer kleine aanpassingen worden gemaakt. Een voorbeeld is het optimaliseren van een achtergrond proces dat geen directe impact heeft op de gebruikers ervaring. \newline

Equivalentietests
: &nbsp; 
: Gebruikt om aan te tonen dat twee versies gelijkwaardig zijn in prestaties. Deze zijn bijzonder nuttig bij architecturale veranderingen of platform migraties waarbij de verandering niet direct zichtbaar is voor de gebruiker. \newline

Langetermijnexperimenten (Degradatie Holdbacks en Cumulatieve Holdbacks)
: &nbsp; 
: Deze tests zijn bedoeld om de langetermijneffecten van veranderingen te meten. Degradatie holdbacks houden een functie terug van een klein deel van de gebruikers om de impact over langere tijd te meten, terwijl cumulatieve holdbacks meerdere functies tegelijk testen om de collectieve impact te beoordelen. \newline

[@fig:flow-test-type] illustreert een besluitvormingsproces voor het selecteren van het juiste type A/B-test. Het begint met de vraag of alle gebruikers de nieuwe feature al hebben gezien, wat leidt tot een tak voor degradatietests als dat zo is. Als de feature nog niet is uitgerold, wordt de volgende vraag gesteld of de verandering op zichzelf moet worden geëvalueerd, wat een normale A/B-test zou rechtvaardigen. Als er interactie is tussen nieuwe features, of als men geïnteresseerd is in de cumulatieve impact van wijzigingen over tijd, worden andere testtypes zoals cumulatieve A/B-tests voorgesteld.

Bij het bepalen of een nieuwe feature superieur is aan de huidige, worden superioriteitstests gebruikt. Als de doelstelling is aan te tonen dat de nieuwe feature niet inferieur is, worden non-inferioriteitstests ingezet. Equivalentietests worden gebruikt wanneer men wil bewijzen dat twee versies gelijkwaardig zijn. Het diagram dient als een gids om onderzoekers door de logica van deze beslissingen te leiden.

![Flow chart kiezen van het juiste type experiment [ [@practical-ab-testing] ](#sec:bronnen)](./images/flow-test-type.png){#fig:flow-test-type width=100%}

De flowchart in [@fig:flow-test-type] is een vereenvoudigde weergave van de besluitvorming die nodig is om het juiste type A/B-test te kiezen.
Het is belangrijk om te onthouden dat het kiezen van het juiste type A/B-test een iteratief proces is.
Het is niet altijd mogelijk om het juiste type A/B-test te kiezen bij het eerste experiment.
Het is belangrijk om te experimenteren met verschillende testtypes en om te leren welke testtypes het beste werken voor een bepaald experiment.

\newpage
## Metrics {#sec:metrics}
Om te bepalen of een experiment succesvol is, moeten er metrics worden gebruikt. Deze metrics zijn de meetbare waarden die worden gebruikt om de resultaten van een experiment te evalueren. Het is belangrijk om de juiste metrics te kiezen, omdat deze de basis vormen voor het nemen van beslissingen. Het is ook belangrijk om te onthouden dat het kiezen van de juiste metrics een iteratief proces is. Het is niet altijd mogelijk om de juiste metrics te kiezen bij het eerste experiment. Het is belangrijk om te experimenteren met verschillende metrics en om te leren welke metrics het beste werken voor een bepaald experiment. 

Een effectieve metric wordt gekenmerkt door de volgende eigenschappen:

- Direct te begrijpen: Een duidelijke ratio of telling die snel te interpreteren is door collega's en teamleden.
- Eenvoudige berekening: De metric moet berekenbaar zijn zonder ingewikkelde formules in combinatie met meerdere metrics.
- Actiegericht: Een goede metric moet duidelijke actie signaleren, of het nu om een stijging of daling gaat.
- Betrouwbaarheid: De metric moet betrouwbaar en tijdig geproduceerd kunnen worden zonder afhankelijk te zijn van een complexe data-infrastructuur.


### Succesmetrics
Na afloop van de test wordt er bepaald of het voorspelde resultaat is behaald door het meten van succes aan de hand van succesmetrics. Een succesmetric, of primaire metric, is de indicator die men wil beïnvloeden om te demonstreren dat de test het verwachte effect heeft gehad. Deze metric, of een set van metrics, geeft inzicht in het succes van het beoogde effect, zoals omschreven in de hypothese. De succesmetric kan aangeven dat gebruikers geïnteresseerd zijn in een nieuwe functie, of het kan de toegevoegde waarde vanuit een zakelijk perspectief meten. Het vaststellen van de juiste succesmetrics hangt af van het doel van de verandering die wordt beoordeeld.

### Guardrail-metrics
Guardrail-metrics, of secundaire metrics, zijn de metrics die worden gebruikt om de impact van de test op andere gebieden te meten. Deze metrics zijn belangrijk om te bepalen of de test onbedoelde negatieve effecten heeft. 

Guardrail-metrics worden ingezet om de effecten van een A/B test op verschillende gebieden in de gaten te houden. [@fig:guardrail-metrics] laat een aantal belangrijke indicatoren zien, zoals omzet, bounce rate en paginalaadtijd. Ze bieden inzicht in zowel de positieve als de negatieve neveneffecten van de test op de gebruikerservaring en de zakelijke resultaten.

![Voorbeeld Guardrail-Metrics [ [@practical-ab-testing] ](#sec:bronnen)](./images/guardrail-metrics.png){#fig:guardrail-metrics width=60%}


### Metrics voor PLNTS
Om een beter beeld te krijgen van de specifieke metrics die relevant zijn voor PLNTS is er een enquête onderzoek gedaan naar de gewenste onderdelen die gemeten dienen te worden en welke soorten metrics relevant zijn voor een bepaald onderdeel van de website. In[@sec:notion-artikel] [Notion artikel](#sec:notion-artikel) staan het artikel dat op de wiki van PLNTS geplaatst is, *de reacties van het IT en Marketing team*, en *de door mij getrokken conclusies*.

\newpage
## Evaluatie van een Experiment {#sec:evaluatie}
Een veelvoorkomende misvatting over A/B-testen is dat evaluatie enkel plaatsvindt aan het einde van een experiment.
In werkelijkheid is evaluatie een continu en doorlopend onderdeel van het gehele A/B-testproces.
Deze voortdurende evaluatie omvat het beoordelen van diverse essentiële factoren die cruciaal zijn voor het meten van het succes van het experiment en voor het vaststellen of de beoogde doelstellingen zijn bereikt.
Evaluatie moet gezien worden als een doorlopend proces, en niet slechts als een afsluitende stap na afloop van een experiment.

Bij de evaluatie van een experiment zijn er een aantal zaken die van belang zijn. Deze zaken zijn de vraagstellingen, het stappenplan en er moet geverifieerd worden of de resultaten betrouwbaar zijn.

### Evaluatie vraagstellingen
De volgende vraagstellingen zijn van belang bij het evalueren van een experiment:

 - Wat is het doel van het experiment?
 - Wat is de hypothese?
 - Welke metrics worden gebruikt om het experiment te evalueren?
 - Wat is de verwachte uitkomst?
 - Wat is de minimale detecteerbare effect grootte? 
 - Wat is de minimale effect grootte die nodig is om het experiment te laten slagen?
 - Wat is de minimale looptijd van het experiment?
 - Wat is de minimale steekproefgrootte?

Het beantwoorden van deze vragen helpt om een duidelijk beeld te schetsen over het experiment en zorgt voor een goede basis voor het evalueren van het experiment.

### Evaluatie stappenplan
Voor het evalueren van een experiment is het belangrijk om een stappenplan te hebben. 

1. Evaluatieobject \newline
De eerste stap is het bepalen van het evaluatieobject. Dit is het object dat wordt geëvalueerd. Dit kan een pagina, een app of een ander object zijn. 

1. Evaluatiecriteria \newline
De tweede stap is het bepalen van de evaluatiecriteria. Dit zijn de criteria die worden gebruikt om het evaluatieobject te evalueren. Dit kunnen bijvoorbeeld de conversieratio, de gemiddelde orderwaarde en de gemiddelde tijd op de pagina zijn. 

1. Evaluatiemethode \newline
De derde stap is het bepalen van de evaluatiemethode. Dit is de methode die wordt gebruikt om het evaluatieobject te evalueren. Dit kan op verschillende manieren gedaan worden en de mannier waarvoor plnts gekozen heeft is A/B testen.

1. Evaluatieresultaat \newline
De vierde stap is het bepalen van het evaluatieresultaat. Dit is het resultaat van de evaluatie van het evaluatieobject. Dit kan bijvoorbeeld een conversieratio van 5% zijn.

1. Evaluatieactie \newline
De vijfde stap is het bepalen van de evaluatieactie. Dit is de actie die wordt ondernomen op basis van het evaluatieresultaat. Dit kan bijvoorbeeld het aanpassen van de kleur van een knop zijn.

### Betrouwbaarheid verhogen in Testresultaten {#sec:betrouwbaarheid}
Voor de correcte configuratie van een A/B test is er een basis nodig voor de statistische vormgeving. Dit is niet een compleet beeld, maar het biedt de ideeën en concepten om te beginnen met het opzetten van een experiment waarin de test resultaten tot op zekere hooge betrouwbaar zijn.

Juiste Configuratie van je A/B-test
Een correct geconfigureerde A/B-test is cruciaal voor het hebben van vertrouwen in de resultaten. Hoe zekerder je bent over je testopstelling, hoe beter je op basis van de testdata beslissingen kunt nemen.

#### Steekproefgrootte bepalen
Bij A/B-testen is de steekproefgrootte van groot belang voor de betrouwbaarheid van de resultaten. Een te kleine steekproef kan leiden tot onnauwkeurige conclusies, terwijl een te grote steekproef onnodige middelen kan verspillen. De steekproefgrootte wordt beïnvloed door het gewenste Minimum Detectable Effect (MDE) en de basis conversie ratio. Het MDE bepaalt de kleinste verbetering die men wil detecteren, en de basis conversie ratio dient als referentiepunt voor verandering.

Voor de berekening van de steekproefgrootte gebruikt men vaak statistische formules of online rekentools. Deze hulpmiddelen nemen de MDE, de basis conversie ratio, de gewenste zekerheidsniveau (vaak uitgedrukt als de Z-score), en de populatiegrootte in overweging om een adequaat aantal proefpersonen voor de test te bepalen.

De steekproefgrootte kan worden berekend met behulp van een online calculator, zoals de calculator van Optimizely[^optimizely-sample-size-calculator]. Deze calculator berekent de steekproefgrootte op basis van de MDE en de basis conversie ratio. 
De steekproefgrootte kan worden berekend met behulp van de volgende formule[^calculator-formula]: 

Voor een onbeperkte populatie kan de steekproefgrootte $n$ berekend worden als:

$$ n = \frac{z^2 \times \hat{p} \times (1-\hat{p})}{e^2} $$

Voor een eindige populatie is de aangepaste steekproefgrootte $n'$:

$$ n' = \frac{n}{1+\frac{n-1}{N}} = \frac{n}{1+\frac{z^2 \times \hat{p} \times (1-\hat{p})}{e^2 \times N}} $$

waar

- $z$ is de Z-score
- $e$ is de foutmarge
- $N$ is de omvang van de populatie
- $\hat{p}$ is het proportie van de populatie

Het zorgvuldig vaststellen van deze parameters voorafgaand aan de test waarborgt dat de A/B-test statistisch significant en betrouwbaar is. Dit is een standaardpraktijk in het veld van data-analyse en digitale marketing, en essentieel voor het nemen van gefundeerde beslissingen op basis van de testresultaten.

[^optimizely-sample-size-calculator]: Optimizely Sample Size Calculator: https://www.optimizely.com/sample-size-calculator/

[^calculator-formula]: Sample Size Formula: https://www.calculator.net/sample-size-calculator.html

#### Trek niet te vroeg conclusies
Een gouden regel bij A/B testen: neem niet te vroeg actie door te snel naar de resultaten te kijken voordat het experiment is afgelopen. Als je vroeg een test stopzet wanneer er een statistisch significant effect lijkt te zijn, is de kans op een vals positief resultaat groter. Dit kan onder anderen voorkomen worden door bijvoorbeeld een p-waarde[ [@p-waarde] ](#sec:bronnen) te definiëren, om zo de kans op het geschatte verschil tussen de test en controle varianten te bepalen.

Als voorbeeld: stel dat je een A/B-test uitvoert met een p-waarde van 0,05. Dit betekent dat er slechts 5% kans is dat de waargenomen verschillen tussen de groepen toeval zijn. 
Een lagere p-waarde duidt op een hogere statistische significantie. 
Het is belangrijk om de test niet voortijdig te stoppen, zelfs als er vroeg in het proces significante verschillen lijken te zijn. 
Door te wachten tot het einde van de testperiode, verminder je het risico op valse positieven en zorg je voor meer betrouwbare resultaten.

\newpage
# Het Ontwerp {#sec:ontwerp}
De integratie van het A/B testen met de webshop van PLNTS is een belangrijk onderdeel van dit onderzoek. 
In dit hoofdstuk wordt er gekeken naar de impact van het A/B testen op het huidige systeem en naar de verschillende manieren waarop het A/B testen geïntegreerd kan worden in de webshop.

## Impact op het huidige systeem {#sec:impact}
In overleg met de andere developers van PLNTS, en verder onderzoek naar de implementatie van A/B testen zijn er een aantal punten die van extra belang zijn met betrekking tot de integratie met het huidige systeem.

### Het tonen van de verschillende varianten aan de gebruikers
Het tonen van de verschillende varianten aan de gebruikers is één van de belangrijkste functionaliteiten van het A/B-test systeem. Er moet een variant van een experiment getoond worden aan de gebruikers. De variant wordt in het geval van PLNTS bepaald zodra de gebruiker de pagina bezoekt. De gebruiker wordt per experiment in een groep ingedeeld en deze indeling wordt lokaal bij de gebruiker opgeslagen in de cookie. 

### Impact op het huidige cookie beleid
A/B-testen zal mogelijk een aanpassing of toevoeging nodig hebben op het huidige cookie beleid van PLNTS. Dit komt omdat er cookies worden gebruikt om de gebruikers te identificeren. Deze cookies worden gebruikt om de gebruikers in een variant te plaatsen. In eerste instantie lijkt het huidige cookie beleid[^cookie-beleid] voldoende te zijn voor de implementatie van A/B testen, wat wordt weergegeven in [@fig:cookie].
Ik raad aan om dit nogmaals te controleren met een juridisch expert om er zeker van te zijn dat het huidige cookie beleid voldoet aan de eisen van de AVG.

[^cookie-beleid]: Cookie beleid: https://plnts.com/nl/legal/cookies

![Cookie beleid PLNTS](./images/cookie.png){#fig:cookie width=60%}

### Impact SEO
Het A/B-testen heeft mogelijk impact op de SEO van PLNTS. Dit kan komen door de manier van de implementatie van het A/B testen.
Wanneer de SEO negatief wordt, beïnvloedt zorgt dit voor een verlaging van rangschikking in zoekmachines en verminderd dus het totaal bezoekersaantal, wat voorkomen kan worden door rekening te houden met een aantal aandachtspunten beschreven in een artikel van Google Optimizely over A/B testen[ [@impact-seo] ](#sec:bronnen) moet voornamelijk gekeken worden naar [Cloaking](#sec:cloaking), [Redirection](#sec:redirection), [Duplication](#sec:duplication), en [Performance](#sec:performance)


### Cloaking {#sec:cloaking}
Cloaking[ [@dont-cloak-your-test-pages] ](#sec:bronnen) in SEO verwijst naar de praktijk waarbij verschillende inhoud of URL's worden gepresenteerd aan gebruikers en zoekmachines.
Cloaking gebeurt vaak via serverlogica of een robots.txt bestand.
Deze techniek kan een negatieve invloed hebben op de page ranking van de site, omdat het door zoekmachines als misleidend wordt beschouwd.

Om dit te voorkomen, moet ervoor gezorgd worden dat zowel gebruikers als zoekmachines dezelfde pagina zien. Cloaking wordt beschouwd als een overtreding van Google's Richtlijnen[ [@google-spam-policy] ](#sec:bronnen), en kan leiden tot het bestraffen of zelfs verwijderen van je site uit zoekresultaten.

Het is belangrijk te onthouden dat Googlebot over het algemeen geen cookies ondersteunt. Dit betekent dat het alleen de contentversie zal zien die toegankelijk is voor gebruikers wiens browsers geen cookies accepteren. Daarom, als cookies worden gebruikt om de test te beheersen, zal Googlebot alleen de versie zonder cookie zien.
Dit aspect moet worden overwogen bij het ontwerpen van A/B-tests om te voorkomen dat onbedoelde cloaking plaatsvindt.

### Redirection {#sec:redirection}
Redirection in SEO verwijst naar het doorsturen van gebruikers van de ene URL naar een andere.
Dit kan worden gedaan met behulp van een 301-redirect, die permanent is, of een 302-redirect, die tijdelijk is.
Het gebruik van een 302-redirect kan een negatieve invloed hebben op de SEO van de site, omdat het door zoekmachines zoals Google als misleidend wordt beschouwd.
Om dit te voorkomen, moet ervoor gezorgd worden dat zowel gebruikers als zoekmachines dezelfde pagina zien.
Permanente redirection wordt beschouwd als een overtreding van Google's Richtlijnen[ [@use-302-not-301] ](#sec:bronnen), en kan wederom leiden tot het bestraffen of zelfs verwijderen van je site uit zoekresultaten.
Dit methode die dit project gebruikt is geen omleiding (redirect), maar herschrijft (rewrite) de URL op middleware niveau.
Herschrijvingen (rewrites) geeft de mogelijkheid om een inkomend verzoekpad (request path) te koppelen aan een ander bestemmingspad (destination path).
Herschrijvingen dienen als een URL-proxy en maskeren het bestemmingspad, waardoor het lijkt alsof de gebruiker zijn locatie op de site niet heeft veranderd.
Dit in tegenstelling tot omleidingen (redirects), die doorverwijzen naar een nieuwe pagina en de URL-wijzigingen tonen[ [@next-rewrites] ](#sec:bronnen).

### Duplication {#sec:duplication}
Duplication in SEO verwijst naar het hebben van dezelfde inhoud op meerdere URL's. In dit project zal hier rekening mee gehouden worden door de URL's van de verschillende varianten van een pagina te herschrijven (rewrite) naar dezelfde URL.

Bij het beheren van contentduplicatie in SEO is het belangrijk om te zorgen dat zoekmachines begrijpen welke versie van de content de voorkeursversie is. Dit kan gedaan worden met de rel="canonical" link tag. Deze tag wordt gebruikt om aan te geven welke URL de originele of voorkeursversie van de content is. Dit is vooral nuttig bij het testen van meerdere URL's of bij het hebben van dezelfde content in verschillende talen.

Door de rel="canonical" tag toe te passen, geef je zoekmachines aan dat, hoewel er verschillende versies van een pagina kunnen bestaan (zoals bij een A/B-test of vertaalde versies), wordt er aangegeven welke versie de hoofdpagina is. Dit zorgt ervoor dat de SEO-waarde van de pagina's wordt geconcentreerd op de hoofdpagina, terwijl de alternatieve pagina's nog steeds toegankelijk blijven voor gebruikers.

### Performance {#sec:performance}
Het A/B-test systeem moet een minimale impact hebben op de laad tijd van de pagina. Dit is belangrijk omdat de laad tijd van de pagina een grote impact heeft op veel velden, zoals conversie ratio, page views, en ook op SEO. Een vertraging van 100 milliseconde kan al leiden tot een verlaging van de conversie ratio met 7%[ [@akamai-ecommerce-performance] ](#sec:bronnen) en een vertraging van 2 seconden kan de bounce rate verhogen met 103%[ [@akamai-ecommerce-performance] ](#sec:bronnen).

### Cumulative Layout Shift (CLS) {#sec:cls}
Verder is het van belang dat er geen cumulatieve indeling verschuiving aanwezig is, ofwel de meer gangbare Engelse term "Zero Cumulative Layout Shift (CLS)". Dit betekend grofweg dat de er geen verspringingen zijn bij het inladen van componenten, wat de gebruikers ervaring negatief beïnvloedt. \newline

De bovenstaande punten worden onder anderen opgelost door gebruik te maken van de technologieën die Vercel met Next.js biedt. Om bijvoorbeeld de laad tijd en CLS te verbeteren, worden pagina's van tevoren opgebouwd. Dit houdt in dat een enkele pagina meerdere keren wordt voorbereid en opgeslagen in de cache voor de verschillende combinaties van experimenten op de pagina. Dit wordt in meer detail beschreven in [@sec:opzet] [Opzet integratie met het huidige systeem](#sec:opzet).

Bij het kiezen tussen een zelfgebouwd A/B-testplatform en een oplossing van derden, zullen er verschillende factoren moeten worden overwogen. Een zelfgebouwd platform biedt flexibiliteit en een naadloze integratie met bestaande systemen. Het vereist echter significante investeringen in tijd, middelen en voortdurend onderhoud. Aan de andere kant heeft het gebruik maken van een derde partij als voordeel dat deze sneller geïmplementeerd kan worden en dat er professionele ondersteuning beschikbaar is in vorm van documentatie en support. Derde partijen hebben als nadeel dat deze soms beperkt kunnen zijn voor specifiek maatwerk, en er kunnen hoge kosten op lange termijn aan verbonden zijn.

## Bestaande A/B-testsystemen {#sec:bestaande-systemen}
Natuurlijk is het mogelijk om zelf een A/B-testsysteem te bouwen voor het meten van events en voor de weergave van de resultaten. Dit zijn complexe systemen die veel tijd en geld kosten om te bouwen en te onderhouden. Daarom zal er voor dit onderzoek gebruik gemaakt worden van bestaande systemen gemaakt door derde partijen. Deze worden vervolgens geconfigureerd zodat ze voldoen aan de wensen en eisen van PLNTS. Er zijn veel verschillende A/B-testsystemen beschikbaar, onder anderen Optimizely, Split.io en Statsig.

Optimizely[^optimizely] staat bekend om het uitgebreide assortiment als experimenten platform, het heeft krachtige vormen van analyses.
Echter, is Optimizely vergeleken met de concurrentie erg prijzig.
Split.io[^split-io] richt zich op feature flagging gecombineerd met A/B testen en is bedoeld voor technische teams die op zoek zijn naar flexibiliteit en controle over hun experimenten.
Statsig[^statsig] lijkt een voordelig alternatief aan te bieden en richt zich op snelle deployment. Bovendien heeft Statsig uitstekende integratie met Vercel en Next.js[^vercel-statsig]. 

Er zijn nog veel meer A/B testplatformen beschikbaar, of andere oplossingen zoals configcat[^configcat] en LaunchDarkly[^launchdarkly]. 

De opzet van de proof of concept zal gebruik maken van Statsig, gezien de snelheid van deployment en de uitstekende integratie met Vercel en Next.js. 
Echter, is de opzet van de proof of concept niet afhankelijk van de keuze van het A/B testplatform.
De opzet kan ook gebruikt worden voor andere A/B testplatformen, zoals Optimizely en Split.io.
Wel zal er dan gekeken moeten worden naar de correcte integratie met Vercel Edge Config. 

[^optimizely]: Optimizely: https://www.optimizely.com/
[^split-io]: Split.io: https://www.split.io/
[^statsig]: Statsig: https://www.statsig.com/
[^vercel-statsig]: Statsig integratie voor Vercel : https://vercel.com/integrations/statsig
[^configcat]: Configcat: https://configcat.com/
[^launchdarkly]: LaunchDarkly: https://launchdarkly.com/

\newpage
## Opzet integratie met het huidige systeem {#sec:opzet}
Om A/B testen te integreren met het huidige systeem van PLNTS is er een opzet en ontwerp gemaakt die aansluit bij de technologie stack. Deze opzet houdt rekening met de wensen en eisen van PLNTS. Bij deze opzet wordt rekening gehouden met het mogelijk veranderen van de A/B test provider. Vooralsnog blijkt Statsig de betere optie voor PLNTS en zal dus gebruikt worden voor de rest van dit hoofdstuk.

PLNTS heeft de fronted applicatie draaien op Vercel[^vercel], waarin onder anderen gebruik gemaakt wordt van Next.js[^next], en React[^react]. Welke onder anderen communiceert met de backend service Magento[^magento-2] via graphql[^graphql], en strapi[^strapi] als Content Management Sytem (CMS).

[^vercel]: Vercel: https://vercel.com/
[^next]: Next.js: https://nextjs.org/
[^react]: React: https://reactjs.org/
[^magento-2]: Magento 2: https://magento.com/
[^graphql]: GraphQL: https://graphql.org/
[^strapi]: Strapi: https://strapi.io/

Vercel in combinatie met Next.js, is goed geschikt voor A/B testen vanwege de functies en integraties die dit platform beschikbaar heeft. Vercel biedt een krachtige infrastructuur die geoptimaliseerd is voor front-end frameworks zoals hun eigen framework Next.js, wat zorgt voor snelle laadtijden en efficiënte levering van webpagina's[^what-is-vercel].

[^what-is-vercel]: What is Vercel? https://vercel.com/blog/what-is-vercel

Het ontwerp voor de infrastructuur om A/B testen te implementeren is grotendeels gebaseerd op de opzet die het artikel [_How to build zero-CLS A/B tests with Next.js and Vercel Edge Config_](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config) [ [@zero-cls-experiments] ](#sec:bronnen) beschreven wordt.
Waarbij wel gezegd moet worden dat dit ontwerp gebruik maakt van de App router in Next.js i.p.v. de oudere Pages router in dit artikel.

### Achtergrond informatie
Voordat we verder gaan met het ontwerp van de infrastructuur is het belangrijk om een begrippen en processen te begrijpen.

Vercel's Edge Network verbetert de prestaties van webapplicaties door inhoud te cachen op de edge-locaties, waardoor data snel aan gebruikers geleverd kan worden. Dit netwerk biedt twee soorten caching[^edge-caching]:

[^edge-caching]: Edge Caching: https://vercel.com/docs/edge-network/caching

Het Statisch cachen van bestanden
: &nbsp;
: Dit proces vindt automatisch plaats voor alle implementaties en vereist geen handmatige configuratie. Het zorgt voor het snel laden van statische inhoud zoals afbeeldingen en stylesheets.\newline

Het Dynamische cachen van inhoud
: &nbsp;
: Dit betreft het cachen van dynamische inhoud, waaronder content die via SSR (Server-Side Rendering) gegenereerd wordt. Dynamisch cachen vereist specifieke configuratie om te zorgen dat actuele inhoud correct wordt opgehaald en weergegeven, terwijl de laadtijden geoptimaliseerd blijven.

Next.js biedt verschillende render strategieën om de prestaties van webapplicaties te optimaliseren. Deze strategieën zijn:

Server-Side Rendering (SSR)
: &nbsp;
: Hierbij genereert de server de HTML voor elke aanvraag.

Static Site Generation (SSG)
: &nbsp;
: HTML-pagina's worden tijdens het bouwproces gegenereerd.

Incremental Static Regeneration (ISR)
: &nbsp;
: Combineert de voordelen van SSR en SSG. Pagina's worden statisch gegenereerd tijdens het bouwen, met de mogelijkheid om individuele pagina's te herbouwen zonder dat dit nodig is voor de gehele applicatie.

### Overzicht ontwerp
![Diagram van de infrastructuur voor A/B testen](./images/diagram.png){#fig:diagram width=90%}

In [@fig:diagram] wordt een globaal overzicht gegeven van de werking van de infrastructuur voor A/B testen. 

Request
: &nbsp;
: Het proces start wanneer een gebruiker een verzoek doet naar de server. \newline

Bucket Cookie
: &nbsp;
: Het systeem controleert of de gebruiker al een cookie heeft voor de ingedeelde experimenten. Als deze niet bestaat, wordt een nieuwe cookie gecreëerd en de gebruiker aan een experimentbucket toegewezen. \newline

```json
{
  "userId":"f4dbb912-47d3-47f4-b9f1-7a2bd8be46e8",
  "experiments":[
    {"name":"rps","group":"Test"},
    {"name":"shop","group":"Test"},
    {"name":"footer","group":"Control"}
  ]
}
```

Get Path For Experiment
: &nbsp;
: Experimenten kunnen beschikbaar zijn op verschillende routes. Geen path betekend op elke route. Hieronder is een experiment object te zien waarin de `params` key variabelen gedefinieerd staan met elk een array van waardes. De Control varianten zijn de waardes met een index van 0, en de Test varianten zijn de waardes met een index van 1.

```ts
export const EXPERIMENTS: Experiment[] = [
  {
    name: 'rps',
    params: {
      icons: [
        ['rock', 'paper', 'scissors'],
        ['snail', 'turtle', 'rabbit'],
      ],
      imageSize: [50, 100],
    },
    paths: ['/blog'],
  },
  {
    name: 'shop',
    params: {
      layout: ['grid', 'flex'],
      bgColor: ['red', 'green'],
      defaultSort: ['price', 'name'],
    },
    paths: ['/shop'],
  },
  {
    name: 'footer',
    params: {
      bgColor: ['blue', 'purple'],
    },
  },
];
```

Encode URL Based on Experiments
: &nbsp;
: De URL wordt gecodeerd op basis van de combinatie van de toegewezen experimenten. In[@fig:encode-url] en in de code daaronder wordt een voorbeeld gegeven van verschillende versies van een experiment binnen een URL.

![Url encoding](./images/encode-url.png){#fig:encode-url width=50%}


```ts
/*
 * Generate a bucket URL based on combination of different experiment groups.
 * The bucket URL is used to determine which experiment group the user is in and will be decoded on
 * the in generateStaticParms
 */
function generateBucketUrl(userExperiments: COOKIE_EXPERIMENT_TYPE, req: NextRequest) {
  const requestPath = req.nextUrl.pathname;

  let bucketUrl = '';

  for (let i = 0; i < EXPERIMENTS.length; i++) {
    const experiment = EXPERIMENTS[i];
    const paths = experiment.paths;
    if (!paths || (paths.length !== 0 && paths.includes(requestPath))) {
      const currentUserExperiment = userExperiments.experiments.find(
        (userExperiment) => userExperiment.name === experiment.name,
      );

      const groupIndex = currentUserExperiment?.group === 'Test' ? 1 : 0;

      bucketUrl += `e${i}g${groupIndex}`;
    }
  }

  return bucketUrl;
}
```

Rewrite Response
: &nbsp;
: De middleware herschrijft (rewrite) de response door de bron-URL (gecodeerde URL) te vervangen door het request pad (de URL die de gebruiker heeft aangevraagd). De url blijft voor de gebruiker hetzelfde terwijl er een request wordt gedaan naar een pagina met de gecodeerde url (de combinatie van experimenten op een pagina). \newline

Build Step
: &nbsp;
: De verschillende combinaties van experimenten krijgen tot een maximum van standaard 100 elk hun eigen pagina met elk een eigen gecodeerde url, zie [@fig:encode-url]. 
Wanneer een gebruiker een pagina opvraagt die nog niet is voorbereid of opgeslagen in de Vercel Edge-cache, wordt deze on-demand gegenereerd via Incremental Static Regeneration (ISR) en vervolgens gecached voor toekomstige verzoeken. \newline

Generate Static Params
: &nbsp;
: Tijdens de build step worden statische parameters gegenereerd door het decoderen van de URL, zoals geïllustreerd in de code op de volgende pagina. In de app-router van Next.js duidt [bucket] in het pad op een dynamische route[^dynamic-routes], die de combinatie van experimenten op een bepaald pad representeert. Elk van deze paden kan tot een maximum van 100 worden voorbereid, elk met zijn eigen unieke set parameters. \newline

[^dynamic-routes]: Dynamic Routes: ttps://nextjs.org/docs/pages/building-your-application/routing/dynamic-routes

Request with Encoded URL 
: &nbsp;
: De server verwerkt het verzoek met de gecodeerde URL. \newline

Serve the Pre-build Page
: &nbsp;
: De server levert de vooraf gebouwde pagina aan de gebruiker. \newline

`app/shop/[bucket]/page.tsx`
```ts
export function generateStaticParams() {
  const encodedUrls = generateStaticParamsBuckets('/shop');
  return encodedUrls.map((url) => ({ bucket: url }));
}

export default function ShopPage({ params }: { params: { bucket: string } }) {
  const decoded = getParamsFromCombination(params.bucket);
  return (
    <div
      className={cn({
        'bg-red-600': decoded?.shop?.bgColor === 'red',
        'bg-green-600': decoded?.shop?.bgColor === 'green',
      })}
    >
      {decoded.shop?.layout === 'grid' ? (
        <div className="grid grid-cols-3 gap-4">
          <p>Product 1</p>
          <p>Product 2</p>
          <p>Product 3</p>
        </div>
      ) : decoded.shop?.layout === 'flex' ? (
        <div className="flex flex-row gap-4">
          <p>Product 1</p>
          <p>Product 2</p>
          <p>Product 3</p>
        </div>
      ) : (
        <p>No layout</p>
      )}
    </div>
  );
}
```


\newpage
# Aanbeveling {#sec:aanbeveling}
De implementatie van een intern A/B test systeem bij PLNTS biedt veelbelovende mogelijkheden voor datagestuurde besluitvorming en optimalisatie van de gebruikerservaring.
Gezien de positieve resultaten van de proof of concept, wordt aanbevolen om het A/B test systeem verder te integreren en te ontwikkelen binnen de omgeving van PLNTS.
Statsig blijkt een effectieve keuze voor de huidige behoeften van PLNTS, gezien de naadloze integratie met Vercel en Next.js.
Toch is het belangrijk om flexibel te blijven en open te staan voor toekomstige aanpassingen of verbeteringen aan het systeem, afhankelijk van de evoluerende eisen en technologische trends.

# Conclusie {#sec:conclusie}
Dit onderzoek heeft aangetoond dat de implementatie en integratie van A/B testen een grote rol rol spelen in het verbeteren van de e-commerce ervaring bij PLNTS.
Door het succesvol testen en analyseren van verschillende website elementen, kan PLNTS zijn digitale strategie effectiever afstemmen op de behoeften en voorkeuren van zijn gebruikers.
Dit leidt niet alleen tot een betere gebruikerservaring maar ook tot een hogere conversie en klanttevredenheid.
PLNTS kan met behulp van het ontwerp en de opgeleverde broncode de juiste stappen zetten voor een succesvolle implementatie binnen hun website.

A/B testen blijft een essentiële tool voor elk bedrijf dat streeft naar continue verbetering, innovatie en data gedreven besluitvorming in een steeds veranderende digitale wereld.

\newpage
# Bijlagen

## Notion artikel {#sec:notion-artikel}
> \LARGE A/B Testing \
> 
> 
> \small
> One of the most effective methods to obtain actionable insights from user behavior is A/B testing. This technique involves comparing two versions of a webpage or app against each other to determine which one performs better in terms of driving desired user actions. In the subsequent sections, we delve deep into categorized A/B testing ideas tailored for [plnts.com](http://plnts.com/), aiming to shed light on potential areas of optimization and the unique metrics that can help gauge their success.
> 
> \large Categorized A/B Testing Ideas for [plnts.com](http://plnts.com/) \
> 
> \small
> 1. Product Listings and Display:
>   - Test: Different layouts (grid view vs. list view) or product image sizes.
>   - Metrics:
>     - Click-through rate
>     - Product views
>     - Time spent on product pages
>     - Add-to-cart rate \newline
>     - *Misschien hier AOV toevoegen?*
>     - *Misschien hier Aantal producten per bestelling toevoegen?*
>
> \normalsize
> **Average orde value (AOV) -> Helps understand purchasing behavior, because it gives a better understanding of how much a customer is willing to spend on a single purchase.**
>
> **Number of products per order -> Similar to AOV, this metric helps understand purchasing behavior.**
>
> \small
> 2. Product Descriptions:
>   - Test: Different description lengths, formats, or user reviews vs. professional descriptions.
>   - Metrics:
>     - Time spent on product page
>     - Add-to-cart rate
>     - Conversion rate \newline
>     - *Misschien hier voor CS ook iets meetbaar maken? Aantal vragen over een specifiek product? Dan zou je echt een integratie moeten maken met Zendesk en dat is een andere fase denk ik*
>
> \normalsize
> **Customer satisfaction (CS) -> Helps understand how satisfied customers are with the product.**
>
> \small
> 3. Call-to-Action (CTA) Buttons:
>   - Test: Different button colors, sizes, text (e.g., "Buy Now" vs. "Add to Cart").
>   - Metrics:
>     - Click-through rate of the CTA
>     - Conversion rate \newline
>     - *Misschien exit % toevoegen? Hoeveel mensen haken af door deze aanpassing (mogelijk te veel push)*
>
> \normalsize
> **Exit rate -> Helps understand how many people leave the site after viewing a specific page.**
> 
> \small
> 4. Pricing and Promotions:
>   - Test: Different pricing strategies or promotional offers (e.g., "20% off" vs. "Buy One Get One Free").
>   - Metrics:
>     - Conversion rate
>     - Average order value
>     - Total sales \newline
>     - *Misschien exit % toevoegen? Hoeveel mensen haken af door deze aanpassing (mogelijk te veel push)*
>     - *Misschien add-to-cart % toevoegen*
> 
> \normalsize
> **Exit rate -> see above**
>
> **Add-to-cart rate -> Helps understand how many people add a product to their cart after viewing it.**
> 
> \small
> 5. Checkout Process:
>   - Test: Single-page vs. multi-step checkout or different checkout page designs.
>   - Metrics:
>     - Cart abandonment rate
>     - Conversion rate
>     - *Misschien exit % toevoegen? Hoeveel mensen haken af door deze aanpassing (mogelijk te veel push)*
>
> \normalsize
> **Exit rate -> see above**
>     - *Mogelijk kan je de AOV nog omhoog krikken door in de check-out upsells toe te voegen?*
>
> **Average order value (AOV) -> see above**
> 
> \small
> 6. Landing Pages
>   - Test: Different designs, images, headlines, or content structures.
>   - Metrics:
>     - Bounce rate
>     - Time spent on page
>     - Conversion rate
> 7. Navigation and Menu:
>   - Test: Different menu structures or navigation layouts.
>   - Metrics:
>     - Bounce rate
>     - Time spent on site
>     - Pages viewed per session
> 8. Search Functionality:
>   - Test: Search bar placement, predictive search suggestions, or filter options.
>   - Metrics:
>     - Use of search functionality
>     - Conversion rate from search results
>     - User satisfaction with search results
> 9. Email Sign-Up Prompts:
>   - Test: Pop-up vs. embedded sign-up forms or different incentives for signing up (e.g., discount codes vs. care guides).
>   - Metrics:
>     - Email sign-up rate
>     - Bounce rate
>     - Subsequent open and click rates of emails
> 10. Product Recommendations:
>   - Test: Algorithmic recommendations vs. curated ones.
>   - Metrics:
>     - Click-through rate on recommended products
>     - Average order value
>     - Conversion rate
> 11. Mobile vs. Desktop Experience:
>   - Test: Different mobile layouts or features.
>   - Metrics:
>     - Mobile conversion rate
>     - Bounce rate
>     - Average session duration
> 12. Testimonials and User Feedback: → *gebruiken we nu Hotjar voor*
>
> \normalsize
> **Hotjar -> Helps understand how users interact with the site.**
> 
> \small
>   - Test: Exploring various positions and formats for reviews, ratings, or user testimonials.
>   - Metrics:
>     - Trust metrics
>     - Conversion rate
>     - Time spent on pages with testimonials
> 13. Content and Blog: → *deze zou ik er persoonlijk uit halen, op content zit bij ons niet veel volume*
>   - Test: Different content formats (e.g., videos, articles, infographics) or different topics.
>   - Metrics:
>     - Engagement metrics like time spent on page
>     - Shares (For the future, currently not a feature)
>     - Comments (For the future, currently not a feature)
>     - Return visits
> 
> \large Unique Metrics from A/B Testing Ideas for [plnts.com](http://plnts.com/):\
> 
> \small
> 1. Click-through rate (CTR):
>   - Description: The percentage of people who clicked on an element (like an ad, link, or button) out of the total who viewed it. It's a primary measure of user engagement and the effectiveness of calls-to-action.
> 2. Product page views:
>   - Description: The number of times a product page is viewed. It helps understand product interest.
> 3. Add-to-cart rate:
>   - Description: The percentage of visitors who add a product to the cart after viewing it. It's an initial step towards conversion.
> 4. Conversion rate:
>   - Description: The percentage of visitors who take a desired action, typically making a purchase. It indicates the effectiveness of the site in persuading visitors to become customers.
> 5. Average order value (AOV):
>   - Description: The average amount of money each customer spends per transaction. It helps understand purchasing behavior.
> 6. Total sales:
>   - Description: The complete number of sales made within a specific time frame.
> 7. Bounce rate:
>   - Description: The percentage of visitors who navigate away from the site after viewing only one page. A high bounce rate can indicate irrelevant content or poor user experience.
> 8. Pages per session:
>   - Description: Average number of pages viewed during a single session. It helps measure user engagement.
> 9. Search usage rate:
>   - Description: The percentage of visitors who use the site's search function. A higher rate can indicate navigation problems or users looking for specific products.
> 10. Cart abandonment rate:
>   - Description: The percentage of shoppers who add items to their cart but do not complete the purchase. It helps identify potential issues in the checkout process.
> 11. Email sign-up rate:
>   - Description: The percentage of visitors who subscribe to the email list. Higher rates can indicate effective incentives or interest in staying connected.
> 12. Email open and click rates:
>   - Description: Respectively, the percentage of recipients who open an email and the percentage of those who click on a link within it. These rates measure the effectiveness of email campaigns.
> 13. Time on testimonial pages:
>   - Description: Average duration users spend on pages containing testimonials or reviews. It can indicate the influence of social proof on buying decisions.
> 14. Page engagement (duration, return visits):
>   - Description: Measures like time spent on a page and the frequency of return visits. They help gauge the effectiveness and relevance of content to users.
> 
> \large Combining Click Path with Other Metrics: \
> 
> \small
> 1. Click Path + Time Spent:
>   - Analyze the duration users spend on each page in their click path to see which content keeps them engaged and which doesn’t.
> 2. Click Path + Conversion Rate:
>   - Understand which navigation paths are most likely to lead to conversions. This can help in streamlining the user journey for higher conversions.
> 3. Click Path + Bounce Rate:
>   - If specific click paths have a high bounce rate, investigate those paths or pages for possible issues.
> 4. Click Path + Exit Rate:
>   - Identify pages where users frequently exit. This might show pages that are not meeting user expectations.
> 5. Click Path + Cart Abandonment Rate:
>   - Understand at which step users are abandoning their carts. This can help refine the checkout process.
> 6. Click Path + CTR:
>   - For paths that include promotional or CTA elements, checking the click-through rates can help evaluate the effectiveness of those elements in the user journey.
> 7. Click Path + Search Usage Rate:
>   - If users are frequently using search in their paths, it may indicate they're having trouble finding what they need through regular navigation.
> 8. Click Path + Product Page Views/Add-to-Cart Rate:
>   - Understand the sequence of products viewed and how often they lead to a product being added to the cart. This can provide insights into cross-selling or upselling opportunities.
> 
> \large Things to Note \
> 
> \small
> - Not all metrics are equally easy to measure. While metrics like click-through rate or bounce rate can be directly captured through most analytics tools, metrics like "trust" or "user satisfaction" may require more indirect methods, such as surveys or user feedback sessions.
> - To measure specific metrics, integration with our other utilized platforms is essential. For example, to gauge the effectiveness of email campaigns, we need to integrate our analytics tool with our email marketing platform. Additionally, integration with Magento and Tweakwise might be necessary to gain deeper insights into e-commerce behavior and search functionalities.
> - When combining metrics, such as Click Path with others, it's vital to consider the user's journey's broader context. For instance, a longer time spent on a page could indicate interest, but it could also suggest confusion.
> 
> \large Conclusion \
> 
> \small
> A/B testing is a powerful method to optimize the user experience and improve conversion rates. By systematically experimenting with various elements of the website, from product displays to CTA buttons, we can make data-driven decisions about the most effective design and content strategies.
> 
> Furthermore, by coupling traditional metrics like conversion rates and bounce rates with more detailed analytics, such as click paths, we can gain a comprehensive understanding of user behavior. This, in turn, allows us to tailor the user experience more closely to our audience's preferences and needs.
> 
> However, as with all data-driven approaches, the key to success lies in meticulous execution and interpretation. Integration with other platforms, careful choice of metrics, and an understanding of the broader user journey are essential to ensure that our tests yield actionable insights. Only then can we truly harness the full potential of A/B testing to refine and elevate the user experience on [plnts.com](http://plnts.com/).

\newpage
# Bronnen {#sec:bronnen}
&nbsp;


---
END FILE STAGEVERSLAG
---

---
title: "Implementatie en Integratie van A/B-Testen in E-commerce
subtitle: "Een Casestudie bij PLNTS"
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
  \fancyhead[C]{Onderzoek}
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
  \usepackage{listings}
  \renewcommand{\lstlistingname}{Code fragment}
  \lstset{
    basicstyle=\ttfamily,
    frame=single
  }
date: September 2023 - Februari 2024
output: 
  pdf_document:
    template: template.tex
lang: nl
figureTitle: "Figuur"
figPrefix: "Figuur"
secPrefix: ""
lstPrefix: "Code fragment"
listingTitle: "Code fragment"
exPrefix: "Voorbeeld"
exampleTitle: "Voorbeeld"
---
\begin{center}
\LARGE Onderzoek
\end{center}

![PLNTS Logo](./images/plnts-logo.png){#fig:plnts-logo width=100%}

\newpage
\begin{center}
\LARGE Versiebeheer
\end{center}

| Versie    | Datum    | Notitie    |
|---------------- | --------------- | --------------- |
| 0.1    | 2024-01-23    | Eerste concept versie    |
| 0.2    | 2024-01-27    | Verwerken feedback van Remco    |
| 0.3    | 2024-01-28    | Laatste wijziginen inhoud    |
| 0.4   | 2024-01-29    | Gramatica en spelling's controle    |
| 1.0    | 2024-01-29    | Definitieve versie    |

\normalsize
\newpage
\tableofcontents
\newpage

# Inleiding
Er komt veel kijken bij het maken van een beslissing in een online platform.
Beslissingen worden vaak gemaakt op basis van intuïtie, ervaring, of een combinatie van beide.
Dit kan leiden tot een verkeerde beslissing, wat kan leiden tot een negatieve impact op de gebruikerservaring en de zakelijke resultaten.
Met A/B testen kan er een betere beslissing worden gemaakt op grond van data.
Het biedt een mechanisme om twee versies van een webpagina of applicatie tegenover elkaar te stellen en op basis van gebruikersinteracties te bepalen welke versie beter presteert.
Dit onderzoek worden de benodigde stappen verkent om een opzet te maken voor de implementatie en integratie van A/B Testen binnen het bestaande systeem van PLNTS. \newline

\large [Analyse A/B testen](#sec:analyse)
: &nbsp;
: Deze sectie verkent de basisprincipes van A/B testen en de rol ervan in het meten en verbeteren van de gebruikersinteractie. \newline

[Essentie van A/B Testen](#sec:essentie)
: &nbsp;
: Deze sectie verkent de basisprincipes van A/B testen en de rol ervan in het meten en verbeteren van de gebruikersinteractie. \newline

[Methodiek van A/B Testen](#sec:methodiek) 
: &nbsp;
: Hier wordt de methodologische aanpak van A/B testen onderzocht, inclusief het opstellen van hypotheses en het kiezen van metrics. \newline

[Belang van A/B Testen](#sec:belang) 
: &nbsp;
: Het belang van A/B-testen wordt benadrukt, met focus op hoe het bijdraagt aan data gedreven besluitvorming. \newline

[Metrics](#sec:metrics)
: &nbsp;
: Een overzicht van de metrics die relevant zijn voor PLNTS en hoe deze kunnen worden gebruikt om de resultaten van A/B testen te evalueren. \newline

[Evaluatie van een Experiment](#sec:evaluatie)
: &nbsp;
: Methodes en benaderingen voor het analyseren en interpreteren van A/B testresultaten. \newline

\large [Het Ontwerp](#sec:ontwerp) 
: &nbsp;
: De integratie van A/B-testen binnen de huidige PLNTS systemen vereist een zorgvuldige afweging van de impact op zowel gebruikers als de technische infrastructuur. Dit hoofdstuk behandelt de praktische uitvoering van A/B-testen, inclusief het tonen van variaties aan gebruikers, de implicaties voor het cookie beleid en SEO, en hoe Vercel en Next.js kunnen worden ingezet om de prestaties te optimaliseren en de gebruikerservaring te waarborgen.\newline

[Impact op het Huidige Systeem](#sec:impact) 
: &nbsp;
: Analyse van de invloed van A/B-testen op PLNTS' bestaande infrastructuur en processen. \newline

[Bestaande A/B-Testsystemen](#sec:bestaande-systemen) 
: &nbsp;
: Vergelijking van diverse A/B-testsystemen en hun relevantie voor PLNTS. \newline

[Opzet Integratie met het Huidige Systeem](#sec:opzet) 
: &nbsp;
: De specifieke opzet van A/B-testintegratie binnen PLNTS's bestaande systeem wordt in detail besproken, met aandacht voor de noodzakelijke configuraties en de rol van Vercel's Edge Network en Next.js's render strategieën. \newline

\large [Aanbevelingen](#sec:aanbeveling) en [Conclusies](#sec:conclusie)
: &nbsp;
: Overzicht van bevindingen en strategische aanbevelingen voor de toekomstige inzet van A/B-testen bij PLNTS. 

\newpage
# Analyse A/B-testen {#sec:analyse}
_Hoe kan PLNTS een intern A/B-testing systeem implementeren dat naadloos integreert met de bestaande infrastructuur?_

De wat, hoe en waarom vragen dienen te worden beantwoord om een zo een beter beeld te schetsen over het proces van A/B-testen. Deze worden respectievelijk in de hoofdstukken[@sec:essentie] [Essentie van A/B testen](#sec:essentie),[@sec:methodiek] [Methodiek van A/B testen](#sec:methodiek), en[@sec:belang] [Belang van A/B testen](#sec:belang) behandeld.

Google met hun platform _Optimizely_ heeft een artikel[ [@optimizley-glossary_ab-testing] ](#sec:bronnen) geschreven waarbij een aantal van deze vragen worden beantwoord. Daarnaast moet er een overzicht worden gemaakt van de bestaande A/B-testsystemen en de metrics die worden gebruikt om de resultaten van de A/B-testen te meten.

Dit onderzoek probeert de volgende vragen te beantwoorden.

- _Welke bestaande A/B-testing tools zijn beschikbaar en hoe vergelijken zij zich in termen van functies, prijsstelling en compatibiliteit met de PLNTS tech stack?_
- _Welke data en metrics zijn relevant voor PLNTS om te verzamelen en analyseren tijdens A/B-tests?_
- _Hoe kan de A/B-test data het best worden weergegeven voor effectieve interpretatie en besluitvorming door verschillende stakeholders zoals marketeers en ontwikkelaars?_
- _Wat zijn de technische vereisten voor het integreren van een A/B-testplatform met PLNTS's bestaande infrastructuur, zodat de website prestaties minimaal beïnvloed worden?_
- _Wat zijn de mogelijke cookie beleid implicaties bij het implementeren van externe A/B-testing tools?_
- _Wat is er nodig bij de implementatie van A/B-testen zodat deze geen negatieve impact heeft op de SEO van de website?_

\newpage
## Essentie van A/B testen {#sec:essentie}
A/B Testen, ook wel split-testen of bucket-testen genoemd, is een methode om twee versies van een webpagina of app te vergelijken en om te bepalen welke versie beter presteert.
Het wordt vaak gebruikt om de effectiviteit van veranderingen in de gebruikerservaring te testen, maar kan ook worden gebruikt om andere variabelen te testen, zoals prijs, inhoud en lay-out.

De twee versies (A en B) worden willekeurig maar gebalanceerd aan gebruikers getoond en de resultaten worden geanalyseerd om te bepalen welke versie beter presteert.
Gebalanceerd gesplitst betekent dat de gebruikers gelijkmatig worden verdeeld over de twee versies.
Dit wordt gedaan om ervoor te zorgen dat de resultaten van de test niet worden beïnvloed door een ongelijke verdeling van gebruikers.

Ook zijn er andere redenen om gebruikers niet willekeurig te verdelen over de twee versies.
Zoals het testen op bepaalde gebruikersgroepen met een karakteristiek eigenschap.
Zo kan het zijn dat je een nieuwe feature wilt testen op een gebruikersgroep die een bepaalde actie heeft uitgevoerd, zoals het aanmaken van een account.
Deze gebruikers kunnen vervolgens in een aparte groep worden geplaatst en worden blootgesteld aan de nieuwe feature.

Een ander reden kan zijn dat je verwacht dat het gedrag van gebruikers veranderd op basis van de intensiteit van het gebruik van de website.
High intensity gebruikers, die frequent en intensief interacteren met de website, kunnen anders reageren op wijzigingen dan low intensity gebruikers die de website sporadisch bezoeken. Het gedrag van deze twee groepen kan aanzienlijk verschillen, daarom kan het nuttig zijn om ze apart te testen.

Voor high intensity gebruikers kan een verandering in de interface of een nieuwe functie een directere impact hebben op hun gebruikservaring. Deze gebruikers zijn vaak meer betrokken en investeren meer tijd in de site, waardoor ze gevoeliger kunnen zijn voor subtiele wijzigingen.

Low intensity gebruikers daarentegen hebben een minder gedetailleerd beeld van de website en zijn mogelijk meer geïnteresseerd in algemene gebruiksgemak en toegankelijkheid. Een verandering die hen helpt sneller te vinden wat ze zoeken, kan bijvoorbeeld een grotere impact hebben op hun tevredenheid dan bij high intensity gebruikers.

Een gebalanceerde benadering in A/B-testen zorgt ervoor dat de resultaten representatief zijn voor het gehele gebruikersbestand. Het kan ook nodig zijn om aparte experimenten uit te voeren of de data apart te analyseren voor deze twee groepen om een duidelijk beeld te krijgen van hoe verschillende gebruikers op wijzigingen reageren.


![User Population [ [@practical-ab-testing] ](#sec:bronnen)](./images/user-population.png){#fig:user-population width=60%}

Zoals in [@fig:user-population] te zien bestaat de gebruikerspopulatie uit alle gebruikers die de website bezoeken. Deze gebruikerspopulatie wordt opgedeeld in twee groepen, de control groep en de test groep. De control groep is de groep die de huidige versie van de website te zien krijgt, de test groep is de groep die de nieuwe versie van de website te zien krijgt. De control groep en de test groep worden willekeurig gekozen uit de gebruikerspopulatie. De control groep en de test groep worden ook wel de varianten genoemd. De varianten worden aan de gebruikers getoond door middel van een A/B-test systeem. Dit systeem zorgt ervoor dat de gebruikers in de juiste variant worden geplaatst en dat de resultaten van de varianten worden gemeten. De resultaten van de varianten worden vervolgens geanalyseerd om te bepalen welke variant het beste presteert. De variant die het beste presteert, wordt vervolgens uitgerold naar de gehele gebruikerspopulatie.

Een A/B test te zien in [@fig:ab-test], vergelijkt een variatie van een pagina met een bestaande, en stelt de maker van de test mogelijk om vragen te stellen over de veranderingen binnen het platform. Bijvoorbeeld, welke versie van een productpagina leidt tot meer aankopen? Welke versie van een app leidt tot meer aanmeldingen? Welke versie van een e-mailcampagne leidt tot meer klikken? A/B-testen kan worden gebruikt om deze vragen te beantwoorden en om de effectiviteit van veranderingen te meten.

![Een A/B test [^ab-test]](./images/ab-test.png){#fig:ab-test width=50%}

[^ab-test]: Bron afbeelding: https://diggintravel.com/airline-ab-testing/

In andere woorden, A/B testen is een online gecontroleerd experiment welke de impact van een verandering meet op een subset van gebruikers[ [@practical-ab-testing] ](#sec:bronnen). Een effectieve A/B test is er één waarbij je zeker bent van besluitvorming gebaseerd op resultaat.

In een A/B test, ook wel een experiment genoemd, evalueer je verandering op gebruikers en meet je de uitkomst door gebruik te maken van data. De verandering welke geëvalueerd wordt als onderdeel van een experiment kan bestaan uit: 

- Een nieuwe UX ontwerp voor een pagina.
- Een nieuwe feature, of een wijziging van een bestaande feature.
- Een nieuwe software architectuur of een wijziging van een bestaande software architectuur.

Bij het ontwikkelen van producten gericht op de eindgebruiker is het doel de gebruikerservaring te verbeteren en zakelijke waarde te creëren. Door A/B-testen te gebruiken om veranderingen te beoordelen, kun je met de testresultaten nagaan of je de beoogde doelen bereikt.

Ook is A/B testen een risico management tool. Het kan de impact van een verandering te meten voordat deze wordt uitgerold naar alle gebruikers. Het is één van de beste manieren om nieuwe features te analyseren op de mogelijk schadelijke impact voor het bedrijf of product.

Om een product te innoveren en aan te passen aan de behoeften van zowel gebruikers als het bedrijf, is het niet nodig om direct het juiste antwoord te hebben. Het is belangrijker om methoden te hebben om te bepalen wat effectief is en impact heeft. A/B-testen zijn cruciaal om de effecten van aanpassingen binnen een constant evoluerend product te openbaren.

\newpage
## Methodiek van A/B testen {#sec:methodiek}
A/B testen is een methodologisch proces waarbij twee of meer versies van een pagina of app worden gepresenteerd aan verschillende gebruikersgroepen, meestal aangeduid als de control en test groepen. 

Het A/B-testproces bestaat uit de volgende stappen:

  - Het identificeren van een kans.
  - Het opstellen van een hypothese.
  - Het ontwerpen van een experiment.
  - Het uitvoeren van het experiment.
  - Het analyseren van de resultaten.
  - Het trekken van conclusies.

Bij het trekken van de conclusies is er vaak ook extra onderzoek nodig om de resultaten te kunnen verklaren. De resultaten van een A/B test vertelt je vaak wat er is gebeurd, maar om antwoord te krijgen op de waarom vraag zijn er vaak extra analyses nodig.

In de kern van A/B testen staat het opstellen van een heldere en weloverwogen hypothese. Deze hypothese stelt verwachtingen op over de uitkomst van de test en dient als een fundament voor het experiment. Het formuleren van een effectieve hypothese omvat niet alleen het voorspellen van een resultaat, maar ook het expliciet definiëren van succes en het vaststellen van de rationale achter de verwachte uitkomst.

Het kiezen van de juiste metrics is een ander vitaal aspect van A/B testen. Succesmetrics, zoals conversieratio's of gemiddelde tijd op pagina, helpen bij het meten van de directe impact van de test. 
Daarnaast zijn guardrail-metrics, zoals omzet, bounce rate en paginalaadtijd, essentieel om ervoor te zorgen dat de verandering geen onbedoelde negatieve effecten heeft.
Een uitgebreid overzicht van de metrics is te vinden in het hoofdstuk[@sec:metrics] [Metrics](#sec:metrics).

Een andere sleutelfactor in A/B testen is het gebruik van geschikte steekproeftechnieken. Deze technieken zorgen ervoor dat de test en controlegroepen representatief zijn en willekeurig gekozen worden, wat helpt aan de betrouwbaarheid en geldigheid van de testresultaten.
Dit wordt verder besproken in het hoofdstuk[@sec:betrouwbaarheid] [Betrouwbaarheid verhogen in Testresultaten](#sec:betrouwbaarheid).

Bij het uitvoeren van A/B testen is het belangrijk om consistentie te bewaren in de manier waarop gegevens worden verzameld en geanalyseerd. Dit betekend het vaststellen van duidelijke criteria voor het includeren van gebruikers in de test, het definiëren van wat een 'actieve' gebruiker is, en het zorgen voor een betrouwbare data-infrastructuur.

\newpage
## Belang van A/B testen {#sec:belang}
Het testen verandert giswerk in wetenschap. In plaats van te vertrouwen op giswerk om te bepalen welke versie van een pagina of app het beste presteert, kunnen A/B-testen en statistische analyse worden gebruikt om te bepalen welke versie beter presteert. Door A/B-testen te gebruiken om te experimenteren, kunnen bedrijven hun intuïtie vervangen door bewijs bij het nemen van beslissingen over hun producten, ook wel data-gedreven besluitvorming genoemd.

Met A/B testen verlaag je de kans om veranderingen te implementeren welke een negatieve impact hebben op de gebruikerservaring. 

### Het juiste type experiment kiezen
Bij het ontwerpen van een effectief experiment is een belangrijke stap het kiezen van het juiste type A/B-test. Elk type heeft specifieke situaties waarin het het meest geschikt is.

Superioriteitstests
: &nbsp; 
: Deze worden gebruikt om aan te tonen dat een nieuwe versie beter presteert dan de bestaande controleversie. Ze zijn ideaal voor situaties waarin je verwacht dat een nieuwe functie een duidelijke verbetering zal zijn. Bijvoorbeeld, een nieuwe gebruikersinterface die naar verwachting de betrokkenheid zal vergroten. \newline

Non-inferioriteitstests
: &nbsp; 
: Deze tests zijn gericht op het aantonen dat een nieuwe versie niet significant slechter is dan de controle. Deze zijn nuttig wanneer kleine aanpassingen worden gemaakt. Een voorbeeld is het optimaliseren van een achtergrond proces dat geen directe impact heeft op de gebruikers ervaring. \newline

Equivalentietests
: &nbsp; 
: Gebruikt om aan te tonen dat twee versies gelijkwaardig zijn in prestaties. Deze zijn bijzonder nuttig bij architecturale veranderingen of platform migraties waarbij de verandering niet direct zichtbaar is voor de gebruiker. \newline

Langetermijnexperimenten (Degradatie Holdbacks en Cumulatieve Holdbacks)
: &nbsp; 
: Deze tests zijn bedoeld om de langetermijneffecten van veranderingen te meten. Degradatie holdbacks houden een functie terug van een klein deel van de gebruikers om de impact over langere tijd te meten, terwijl cumulatieve holdbacks meerdere functies tegelijk testen om de collectieve impact te beoordelen. \newline

[@fig:flow-test-type] illustreert een besluitvormingsproces voor het selecteren van het juiste type A/B-test. Het begint met de vraag of alle gebruikers de nieuwe feature al hebben gezien, wat leidt tot een tak voor degradatietests als dat zo is. Als de feature nog niet is uitgerold, wordt de volgende vraag gesteld of de verandering op zichzelf moet worden geëvalueerd, wat een normale A/B-test zou rechtvaardigen. Als er interactie is tussen nieuwe features, of als men geïnteresseerd is in de cumulatieve impact van wijzigingen over tijd, worden andere testtypes zoals cumulatieve A/B-tests voorgesteld.

Bij het bepalen of een nieuwe feature superieur is aan de huidige, worden superioriteitstests gebruikt. Als de doelstelling is aan te tonen dat de nieuwe feature niet inferieur is, worden non-inferioriteitstests ingezet. Equivalentietests worden gebruikt wanneer men wil bewijzen dat twee versies gelijkwaardig zijn. Het diagram dient als een gids om onderzoekers door de logica van deze beslissingen te leiden.

![Flow chart kiezen van het juiste type experiment [ [@practical-ab-testing] ](#sec:bronnen)](./images/flow-test-type.png){#fig:flow-test-type width=100%}

De flowchart in [@fig:flow-test-type] is een vereenvoudigde weergave van de besluitvorming die nodig is om het juiste type A/B-test te kiezen.
Het is belangrijk om te onthouden dat het kiezen van het juiste type A/B-test een iteratief proces is.
Het is niet altijd mogelijk om het juiste type A/B-test te kiezen bij het eerste experiment.
Het is belangrijk om te experimenteren met verschillende testtypes en om te leren welke testtypes het beste werken voor een bepaald experiment.

\newpage
## Metrics {#sec:metrics}
Om te bepalen of een experiment succesvol is, moeten er metrics worden gebruikt. Deze metrics zijn de meetbare waarden die worden gebruikt om de resultaten van een experiment te evalueren. Het is belangrijk om de juiste metrics te kiezen, omdat deze de basis vormen voor het nemen van beslissingen. Het is ook belangrijk om te onthouden dat het kiezen van de juiste metrics een iteratief proces is. Het is niet altijd mogelijk om de juiste metrics te kiezen bij het eerste experiment. Het is belangrijk om te experimenteren met verschillende metrics en om te leren welke metrics het beste werken voor een bepaald experiment. 

Een effectieve metric wordt gekenmerkt door de volgende eigenschappen:

- Direct te begrijpen: Een duidelijke ratio of telling die snel te interpreteren is door collega's en teamleden.
- Eenvoudige berekening: De metric moet berekenbaar zijn zonder ingewikkelde formules in combinatie met meerdere metrics.
- Actiegericht: Een goede metric moet duidelijke actie signaleren, of het nu om een stijging of daling gaat.
- Betrouwbaarheid: De metric moet betrouwbaar en tijdig geproduceerd kunnen worden zonder afhankelijk te zijn van een complexe data-infrastructuur.


### Succesmetrics
Na afloop van de test wordt er bepaald of het voorspelde resultaat is behaald door het meten van succes aan de hand van succesmetrics. Een succesmetric, of primaire metric, is de indicator die men wil beïnvloeden om te demonstreren dat de test het verwachte effect heeft gehad. Deze metric, of een set van metrics, geeft inzicht in het succes van het beoogde effect, zoals omschreven in de hypothese. De succesmetric kan aangeven dat gebruikers geïnteresseerd zijn in een nieuwe functie, of het kan de toegevoegde waarde vanuit een zakelijk perspectief meten. Het vaststellen van de juiste succesmetrics hangt af van het doel van de verandering die wordt beoordeeld.

### Guardrail-metrics
Guardrail-metrics, of secundaire metrics, zijn de metrics die worden gebruikt om de impact van de test op andere gebieden te meten. Deze metrics zijn belangrijk om te bepalen of de test onbedoelde negatieve effecten heeft. 

Guardrail-metrics worden ingezet om de effecten van een A/B test op verschillende gebieden in de gaten te houden. [@fig:guardrail-metrics] laat een aantal belangrijke indicatoren zien, zoals omzet, bounce rate en paginalaadtijd. Ze bieden inzicht in zowel de positieve als de negatieve neveneffecten van de test op de gebruikerservaring en de zakelijke resultaten.

![Voorbeeld Guardrail-Metrics [ [@practical-ab-testing] ](#sec:bronnen)](./images/guardrail-metrics.png){#fig:guardrail-metrics width=60%}


### Metrics voor PLNTS
Om een beter beeld te krijgen van de specifieke metrics die relevant zijn voor PLNTS is er een enquête onderzoek gedaan naar de gewenste onderdelen die gemeten dienen te worden en welke soorten metrics relevant zijn voor een bepaald onderdeel van de website. In[@sec:notion-artikel] [Notion artikel](#sec:notion-artikel) staan het artikel dat op de wiki van PLNTS geplaatst is, *de reacties van het IT en Marketing team*, en *de door mij getrokken conclusies*.

\newpage
## Evaluatie van een Experiment {#sec:evaluatie}
Een veelvoorkomende misvatting over A/B-testen is dat evaluatie enkel plaatsvindt aan het einde van een experiment.
In werkelijkheid is evaluatie een continu en doorlopend onderdeel van het gehele A/B-testproces.
Deze voortdurende evaluatie omvat het beoordelen van diverse essentiële factoren die cruciaal zijn voor het meten van het succes van het experiment en voor het vaststellen of de beoogde doelstellingen zijn bereikt.
Evaluatie moet gezien worden als een doorlopend proces, en niet slechts als een afsluitende stap na afloop van een experiment.

Bij de evaluatie van een experiment zijn er een aantal zaken die van belang zijn. Deze zaken zijn de vraagstellingen, het stappenplan en er moet geverifieerd worden of de resultaten betrouwbaar zijn.

### Evaluatie vraagstellingen
De volgende vraagstellingen zijn van belang bij het evalueren van een experiment:

 - Wat is het doel van het experiment?
 - Wat is de hypothese?
 - Welke metrics worden gebruikt om het experiment te evalueren?
 - Wat is de verwachte uitkomst?
 - Wat is de minimale detecteerbare effect grootte? 
 - Wat is de minimale effect grootte die nodig is om het experiment te laten slagen?
 - Wat is de minimale looptijd van het experiment?
 - Wat is de minimale steekproefgrootte?

Het beantwoorden van deze vragen helpt om een duidelijk beeld te schetsen over het experiment en zorgt voor een goede basis voor het evalueren van het experiment.

### Evaluatie stappenplan
Voor het evalueren van een experiment is het belangrijk om een stappenplan te hebben. 

1. Evaluatieobject \newline
De eerste stap is het bepalen van het evaluatieobject. Dit is het object dat wordt geëvalueerd. Dit kan een pagina, een app of een ander object zijn. 

1. Evaluatiecriteria \newline
De tweede stap is het bepalen van de evaluatiecriteria. Dit zijn de criteria die worden gebruikt om het evaluatieobject te evalueren. Dit kunnen bijvoorbeeld de conversieratio, de gemiddelde orderwaarde en de gemiddelde tijd op de pagina zijn. 

1. Evaluatiemethode \newline
De derde stap is het bepalen van de evaluatiemethode. Dit is de methode die wordt gebruikt om het evaluatieobject te evalueren. Dit kan op verschillende manieren gedaan worden en de mannier waarvoor plnts gekozen heeft is A/B testen.

1. Evaluatieresultaat \newline
De vierde stap is het bepalen van het evaluatieresultaat. Dit is het resultaat van de evaluatie van het evaluatieobject. Dit kan bijvoorbeeld een conversieratio van 5% zijn.

1. Evaluatieactie \newline
De vijfde stap is het bepalen van de evaluatieactie. Dit is de actie die wordt ondernomen op basis van het evaluatieresultaat. Dit kan bijvoorbeeld het aanpassen van de kleur van een knop zijn.

### Betrouwbaarheid verhogen in Testresultaten {#sec:betrouwbaarheid}
Voor de correcte configuratie van een A/B test is er een basis nodig voor de statistische vormgeving. Dit is niet een compleet beeld, maar het biedt de ideeën en concepten om te beginnen met het opzetten van een experiment waarin de test resultaten tot op zekere hooge betrouwbaar zijn.

Juiste Configuratie van je A/B-test
Een correct geconfigureerde A/B-test is cruciaal voor het hebben van vertrouwen in de resultaten. Hoe zekerder je bent over je testopstelling, hoe beter je op basis van de testdata beslissingen kunt nemen.

#### Steekproefgrootte bepalen
Bij A/B-testen is de steekproefgrootte van groot belang voor de betrouwbaarheid van de resultaten. Een te kleine steekproef kan leiden tot onnauwkeurige conclusies, terwijl een te grote steekproef onnodige middelen kan verspillen. De steekproefgrootte wordt beïnvloed door het gewenste Minimum Detectable Effect (MDE) en de basis conversie ratio. Het MDE bepaalt de kleinste verbetering die men wil detecteren, en de basis conversie ratio dient als referentiepunt voor verandering.

Voor de berekening van de steekproefgrootte gebruikt men vaak statistische formules of online rekentools. Deze hulpmiddelen nemen de MDE, de basis conversie ratio, de gewenste zekerheidsniveau (vaak uitgedrukt als de Z-score), en de populatiegrootte in overweging om een adequaat aantal proefpersonen voor de test te bepalen.

De steekproefgrootte kan worden berekend met behulp van een online calculator, zoals de calculator van Optimizely[^optimizely-sample-size-calculator]. Deze calculator berekent de steekproefgrootte op basis van de MDE en de basis conversie ratio. 
De steekproefgrootte kan worden berekend met behulp van de volgende formule[^calculator-formula]: 

Voor een onbeperkte populatie kan de steekproefgrootte $n$ berekend worden als:

$$ n = \frac{z^2 \times \hat{p} \times (1-\hat{p})}{e^2} $$

Voor een eindige populatie is de aangepaste steekproefgrootte $n'$:

$$ n' = \frac{n}{1+\frac{n-1}{N}} = \frac{n}{1+\frac{z^2 \times \hat{p} \times (1-\hat{p})}{e^2 \times N}} $$

waar

- $z$ is de Z-score
- $e$ is de foutmarge
- $N$ is de omvang van de populatie
- $\hat{p}$ is het proportie van de populatie

Het zorgvuldig vaststellen van deze parameters voorafgaand aan de test waarborgt dat de A/B-test statistisch significant en betrouwbaar is. Dit is een standaardpraktijk in het veld van data-analyse en digitale marketing, en essentieel voor het nemen van gefundeerde beslissingen op basis van de testresultaten.

[^optimizely-sample-size-calculator]: Optimizely Sample Size Calculator: https://www.optimizely.com/sample-size-calculator/

[^calculator-formula]: Sample Size Formula: https://www.calculator.net/sample-size-calculator.html

#### Trek niet te vroeg conclusies
Een gouden regel bij A/B testen: neem niet te vroeg actie door te snel naar de resultaten te kijken voordat het experiment is afgelopen. Als je vroeg een test stopzet wanneer er een statistisch significant effect lijkt te zijn, is de kans op een vals positief resultaat groter. Dit kan onder anderen voorkomen worden door bijvoorbeeld een p-waarde[ [@p-waarde] ](#sec:bronnen) te definiëren, om zo de kans op het geschatte verschil tussen de test en controle varianten te bepalen.

Als voorbeeld: stel dat je een A/B-test uitvoert met een p-waarde van 0,05. Dit betekent dat er slechts 5% kans is dat de waargenomen verschillen tussen de groepen toeval zijn. 
Een lagere p-waarde duidt op een hogere statistische significantie. 
Het is belangrijk om de test niet voortijdig te stoppen, zelfs als er vroeg in het proces significante verschillen lijken te zijn. 
Door te wachten tot het einde van de testperiode, verminder je het risico op valse positieven en zorg je voor meer betrouwbare resultaten.

\newpage
# Het Ontwerp {#sec:ontwerp}
De integratie van het A/B testen met de webshop van PLNTS is een belangrijk onderdeel van dit onderzoek. 
In dit hoofdstuk wordt er gekeken naar de impact van het A/B testen op het huidige systeem en naar de verschillende manieren waarop het A/B testen geïntegreerd kan worden in de webshop.

## Impact op het huidige systeem {#sec:impact}
In overleg met de andere developers van PLNTS, en verder onderzoek naar de implementatie van A/B testen zijn er een aantal punten die van extra belang zijn met betrekking tot de integratie met het huidige systeem.

### Het tonen van de verschillende varianten aan de gebruikers
Het tonen van de verschillende varianten aan de gebruikers is één van de belangrijkste functionaliteiten van het A/B-test systeem. Er moet een variant van een experiment getoond worden aan de gebruikers. De variant wordt in het geval van PLNTS bepaald zodra de gebruiker de pagina bezoekt. De gebruiker wordt per experiment in een groep ingedeeld en deze indeling wordt lokaal bij de gebruiker opgeslagen in de cookie. 

### Impact op het huidige cookie beleid
A/B-testen zal mogelijk een aanpassing of toevoeging nodig hebben op het huidige cookie beleid van PLNTS. Dit komt omdat er cookies worden gebruikt om de gebruikers te identificeren. Deze cookies worden gebruikt om de gebruikers in een variant te plaatsen. In eerste instantie lijkt het huidige cookie beleid[^cookie-beleid] voldoende te zijn voor de implementatie van A/B testen, wat wordt weergegeven in [@fig:cookie].
Ik raad aan om dit nogmaals te controleren met een juridisch expert om er zeker van te zijn dat het huidige cookie beleid voldoet aan de eisen van de AVG.

[^cookie-beleid]: Cookie beleid: https://plnts.com/nl/legal/cookies

![Cookie beleid PLNTS](./images/cookie.png){#fig:cookie width=60%}

### Impact SEO
Het A/B-testen heeft mogelijk impact op de SEO van PLNTS. Dit kan komen door de manier van de implementatie van het A/B testen.
Wanneer de SEO negatief wordt, beïnvloedt zorgt dit voor een verlaging van rangschikking in zoekmachines en verminderd dus het totaal bezoekersaantal, wat voorkomen kan worden door rekening te houden met een aantal aandachtspunten beschreven in een artikel van Google Optimizely over A/B testen[ [@impact-seo] ](#sec:bronnen) moet voornamelijk gekeken worden naar [Cloaking](#sec:cloaking), [Redirection](#sec:redirection), [Duplication](#sec:duplication), en [Performance](#sec:performance)


### Cloaking {#sec:cloaking}
Cloaking[ [@dont-cloak-your-test-pages] ](#sec:bronnen) in SEO verwijst naar de praktijk waarbij verschillende inhoud of URL's worden gepresenteerd aan gebruikers en zoekmachines.
Cloaking gebeurt vaak via serverlogica of een robots.txt bestand.
Deze techniek kan een negatieve invloed hebben op de page ranking van de site, omdat het door zoekmachines als misleidend wordt beschouwd.

Om dit te voorkomen, moet ervoor gezorgd worden dat zowel gebruikers als zoekmachines dezelfde pagina zien. Cloaking wordt beschouwd als een overtreding van Google's Richtlijnen[ [@google-spam-policy] ](#sec:bronnen), en kan leiden tot het bestraffen of zelfs verwijderen van je site uit zoekresultaten.

Het is belangrijk te onthouden dat Googlebot over het algemeen geen cookies ondersteunt. Dit betekent dat het alleen de contentversie zal zien die toegankelijk is voor gebruikers wiens browsers geen cookies accepteren. Daarom, als cookies worden gebruikt om de test te beheersen, zal Googlebot alleen de versie zonder cookie zien.
Dit aspect moet worden overwogen bij het ontwerpen van A/B-tests om te voorkomen dat onbedoelde cloaking plaatsvindt.

### Redirection {#sec:redirection}
Redirection in SEO verwijst naar het doorsturen van gebruikers van de ene URL naar een andere.
Dit kan worden gedaan met behulp van een 301-redirect, die permanent is, of een 302-redirect, die tijdelijk is.
Het gebruik van een 302-redirect kan een negatieve invloed hebben op de SEO van de site, omdat het door zoekmachines zoals Google als misleidend wordt beschouwd.
Om dit te voorkomen, moet ervoor gezorgd worden dat zowel gebruikers als zoekmachines dezelfde pagina zien.
Permanente redirection wordt beschouwd als een overtreding van Google's Richtlijnen[ [@use-302-not-301] ](#sec:bronnen), en kan wederom leiden tot het bestraffen of zelfs verwijderen van je site uit zoekresultaten.
Dit methode die dit project gebruikt is geen omleiding (redirect), maar herschrijft (rewrite) de URL op middleware niveau.
Herschrijvingen (rewrites) geeft de mogelijkheid om een inkomend verzoekpad (request path) te koppelen aan een ander bestemmingspad (destination path).
Herschrijvingen dienen als een URL-proxy en maskeren het bestemmingspad, waardoor het lijkt alsof de gebruiker zijn locatie op de site niet heeft veranderd.
Dit in tegenstelling tot omleidingen (redirects), die doorverwijzen naar een nieuwe pagina en de URL-wijzigingen tonen[ [@next-rewrites] ](#sec:bronnen).

### Duplication {#sec:duplication}
Duplication in SEO verwijst naar het hebben van dezelfde inhoud op meerdere URL's. In dit project zal hier rekening mee gehouden worden door de URL's van de verschillende varianten van een pagina te herschrijven (rewrite) naar dezelfde URL.

Bij het beheren van contentduplicatie in SEO is het belangrijk om te zorgen dat zoekmachines begrijpen welke versie van de content de voorkeursversie is. Dit kan gedaan worden met de rel="canonical" link tag. Deze tag wordt gebruikt om aan te geven welke URL de originele of voorkeursversie van de content is. Dit is vooral nuttig bij het testen van meerdere URL's of bij het hebben van dezelfde content in verschillende talen.

Door de rel="canonical" tag toe te passen, geef je zoekmachines aan dat, hoewel er verschillende versies van een pagina kunnen bestaan (zoals bij een A/B-test of vertaalde versies), wordt er aangegeven welke versie de hoofdpagina is. Dit zorgt ervoor dat de SEO-waarde van de pagina's wordt geconcentreerd op de hoofdpagina, terwijl de alternatieve pagina's nog steeds toegankelijk blijven voor gebruikers.

### Performance {#sec:performance}
Het A/B-test systeem moet een minimale impact hebben op de laad tijd van de pagina. Dit is belangrijk omdat de laad tijd van de pagina een grote impact heeft op veel velden, zoals conversie ratio, page views, en ook op SEO. Een vertraging van 100 milliseconde kan al leiden tot een verlaging van de conversie ratio met 7%[ [@akamai-ecommerce-performance] ](#sec:bronnen) en een vertraging van 2 seconden kan de bounce rate verhogen met 103%[ [@akamai-ecommerce-performance] ](#sec:bronnen).

### Cumulative Layout Shift (CLS) {#sec:cls}
Verder is het van belang dat er geen cumulatieve indeling verschuiving aanwezig is, ofwel de meer gangbare Engelse term "Zero Cumulative Layout Shift (CLS)". Dit betekend grofweg dat de er geen verspringingen zijn bij het inladen van componenten, wat de gebruikers ervaring negatief beïnvloedt. \newline

De bovenstaande punten worden onder anderen opgelost door gebruik te maken van de technologieën die Vercel met Next.js biedt. Om bijvoorbeeld de laad tijd en CLS te verbeteren, worden pagina's van tevoren opgebouwd. Dit houdt in dat een enkele pagina meerdere keren wordt voorbereid en opgeslagen in de cache voor de verschillende combinaties van experimenten op de pagina. Dit wordt in meer detail beschreven in [@sec:opzet] [Opzet integratie met het huidige systeem](#sec:opzet).

Bij het kiezen tussen een zelfgebouwd A/B-testplatform en een oplossing van derden, zullen er verschillende factoren moeten worden overwogen. Een zelfgebouwd platform biedt flexibiliteit en een naadloze integratie met bestaande systemen. Het vereist echter significante investeringen in tijd, middelen en voortdurend onderhoud. Aan de andere kant heeft het gebruik maken van een derde partij als voordeel dat deze sneller geïmplementeerd kan worden en dat er professionele ondersteuning beschikbaar is in vorm van documentatie en support. Derde partijen hebben als nadeel dat deze soms beperkt kunnen zijn voor specifiek maatwerk, en er kunnen hoge kosten op lange termijn aan verbonden zijn.

## Bestaande A/B-testsystemen {#sec:bestaande-systemen}
Natuurlijk is het mogelijk om zelf een A/B-testsysteem te bouwen voor het meten van events en voor de weergave van de resultaten. Dit zijn complexe systemen die veel tijd en geld kosten om te bouwen en te onderhouden. Daarom zal er voor dit onderzoek gebruik gemaakt worden van bestaande systemen gemaakt door derde partijen. Deze worden vervolgens geconfigureerd zodat ze voldoen aan de wensen en eisen van PLNTS. Er zijn veel verschillende A/B-testsystemen beschikbaar, onder anderen Optimizely, Split.io en Statsig.

Optimizely[^optimizely] staat bekend om het uitgebreide assortiment als experimenten platform, het heeft krachtige vormen van analyses.
Echter, is Optimizely vergeleken met de concurrentie erg prijzig.
Split.io[^split-io] richt zich op feature flagging gecombineerd met A/B testen en is bedoeld voor technische teams die op zoek zijn naar flexibiliteit en controle over hun experimenten.
Statsig[^statsig] lijkt een voordelig alternatief aan te bieden en richt zich op snelle deployment. Bovendien heeft Statsig uitstekende integratie met Vercel en Next.js[^vercel-statsig]. 

Er zijn nog veel meer A/B testplatformen beschikbaar, of andere oplossingen zoals configcat[^configcat] en LaunchDarkly[^launchdarkly]. 

De opzet van de proof of concept zal gebruik maken van Statsig, gezien de snelheid van deployment en de uitstekende integratie met Vercel en Next.js. 
Echter, is de opzet van de proof of concept niet afhankelijk van de keuze van het A/B testplatform.
De opzet kan ook gebruikt worden voor andere A/B testplatformen, zoals Optimizely en Split.io.
Wel zal er dan gekeken moeten worden naar de correcte integratie met Vercel Edge Config. 

[^optimizely]: Optimizely: https://www.optimizely.com/
[^split-io]: Split.io: https://www.split.io/
[^statsig]: Statsig: https://www.statsig.com/
[^vercel-statsig]: Statsig integratie voor Vercel : https://vercel.com/integrations/statsig
[^configcat]: Configcat: https://configcat.com/
[^launchdarkly]: LaunchDarkly: https://launchdarkly.com/

\newpage
## Opzet integratie met het huidige systeem {#sec:opzet}
Om A/B testen te integreren met het huidige systeem van PLNTS is er een opzet en ontwerp gemaakt die aansluit bij de technologie stack. Deze opzet houdt rekening met de wensen en eisen van PLNTS. Bij deze opzet wordt rekening gehouden met het mogelijk veranderen van de A/B test provider. Vooralsnog blijkt Statsig de betere optie voor PLNTS en zal dus gebruikt worden voor de rest van dit hoofdstuk.

PLNTS heeft de fronted applicatie draaien op Vercel[^vercel], waarin onder anderen gebruik gemaakt wordt van Next.js[^next], en React[^react]. Welke onder anderen communiceert met de backend service Magento[^magento-2] via graphql[^graphql], en strapi[^strapi] als Content Management Sytem (CMS).

[^vercel]: Vercel: https://vercel.com/
[^next]: Next.js: https://nextjs.org/
[^react]: React: https://reactjs.org/
[^magento-2]: Magento 2: https://magento.com/
[^graphql]: GraphQL: https://graphql.org/
[^strapi]: Strapi: https://strapi.io/

Vercel in combinatie met Next.js, is goed geschikt voor A/B testen vanwege de functies en integraties die dit platform beschikbaar heeft. Vercel biedt een krachtige infrastructuur die geoptimaliseerd is voor front-end frameworks zoals hun eigen framework Next.js, wat zorgt voor snelle laadtijden en efficiënte levering van webpagina's[^what-is-vercel].

[^what-is-vercel]: What is Vercel? https://vercel.com/blog/what-is-vercel

Het ontwerp voor de infrastructuur om A/B testen te implementeren is grotendeels gebaseerd op de opzet die het artikel [_How to build zero-CLS A/B tests with Next.js and Vercel Edge Config_](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config) [ [@zero-cls-experiments] ](#sec:bronnen) beschreven wordt.
Waarbij wel gezegd moet worden dat dit ontwerp gebruik maakt van de App router in Next.js i.p.v. de oudere Pages router in dit artikel.

### Achtergrond informatie
Voordat we verder gaan met het ontwerp van de infrastructuur is het belangrijk om een begrippen en processen te begrijpen.

Vercel's Edge Network verbetert de prestaties van webapplicaties door inhoud te cachen op de edge-locaties, waardoor data snel aan gebruikers geleverd kan worden. Dit netwerk biedt twee soorten caching[^edge-caching]:

[^edge-caching]: Edge Caching: https://vercel.com/docs/edge-network/caching

Het Statisch cachen van bestanden
: &nbsp;
: Dit proces vindt automatisch plaats voor alle implementaties en vereist geen handmatige configuratie. Het zorgt voor het snel laden van statische inhoud zoals afbeeldingen en stylesheets.\newline

Het Dynamische cachen van inhoud
: &nbsp;
: Dit betreft het cachen van dynamische inhoud, waaronder content die via SSR (Server-Side Rendering) gegenereerd wordt. Dynamisch cachen vereist specifieke configuratie om te zorgen dat actuele inhoud correct wordt opgehaald en weergegeven, terwijl de laadtijden geoptimaliseerd blijven.

Next.js biedt verschillende render strategieën om de prestaties van webapplicaties te optimaliseren. Deze strategieën zijn:

Server-Side Rendering (SSR)
: &nbsp;
: Hierbij genereert de server de HTML voor elke aanvraag.

Static Site Generation (SSG)
: &nbsp;
: HTML-pagina's worden tijdens het bouwproces gegenereerd.

Incremental Static Regeneration (ISR)
: &nbsp;
: Combineert de voordelen van SSR en SSG. Pagina's worden statisch gegenereerd tijdens het bouwen, met de mogelijkheid om individuele pagina's te herbouwen zonder dat dit nodig is voor de gehele applicatie.

### Overzicht ontwerp
![Diagram van de infrastructuur voor A/B testen](./images/diagram.png){#fig:diagram width=90%}

In [@fig:diagram] wordt een globaal overzicht gegeven van de werking van de infrastructuur voor A/B testen. 

Request
: &nbsp;
: Het proces start wanneer een gebruiker een verzoek doet naar de server. \newline

Bucket Cookie
: &nbsp;
: Het systeem controleert of de gebruiker al een cookie heeft voor de ingedeelde experimenten. Als deze niet bestaat, wordt een nieuwe cookie gecreëerd en de gebruiker aan een experimentbucket toegewezen. \newline

```json
{
  "userId":"f4dbb912-47d3-47f4-b9f1-7a2bd8be46e8",
  "experiments":[
    {"name":"rps","group":"Test"},
    {"name":"shop","group":"Test"},
    {"name":"footer","group":"Control"}
  ]
}
```

Get Path For Experiment
: &nbsp;
: Experimenten kunnen beschikbaar zijn op verschillende routes. Geen path betekend op elke route. Hieronder is een experiment object te zien waarin de `params` key variabelen gedefinieerd staan met elk een array van waardes. De Control varianten zijn de waardes met een index van 0, en de Test varianten zijn de waardes met een index van 1.

```ts
export const EXPERIMENTS: Experiment[] = [
  {
    name: 'rps',
    params: {
      icons: [
        ['rock', 'paper', 'scissors'],
        ['snail', 'turtle', 'rabbit'],
      ],
      imageSize: [50, 100],
    },
    paths: ['/blog'],
  },
  {
    name: 'shop',
    params: {
      layout: ['grid', 'flex'],
      bgColor: ['red', 'green'],
      defaultSort: ['price', 'name'],
    },
    paths: ['/shop'],
  },
  {
    name: 'footer',
    params: {
      bgColor: ['blue', 'purple'],
    },
  },
];
```

Encode URL Based on Experiments
: &nbsp;
: De URL wordt gecodeerd op basis van de combinatie van de toegewezen experimenten. In[@fig:encode-url] en in de code daaronder wordt een voorbeeld gegeven van verschillende versies van een experiment binnen een URL.

![Url encoding](./images/encode-url.png){#fig:encode-url width=50%}


```ts
/*
 * Generate a bucket URL based on combination of different experiment groups.
 * The bucket URL is used to determine which experiment group the user is in and will be decoded on
 * the in generateStaticParms
 */
function generateBucketUrl(userExperiments: COOKIE_EXPERIMENT_TYPE, req: NextRequest) {
  const requestPath = req.nextUrl.pathname;

  let bucketUrl = '';

  for (let i = 0; i < EXPERIMENTS.length; i++) {
    const experiment = EXPERIMENTS[i];
    const paths = experiment.paths;
    if (!paths || (paths.length !== 0 && paths.includes(requestPath))) {
      const currentUserExperiment = userExperiments.experiments.find(
        (userExperiment) => userExperiment.name === experiment.name,
      );

      const groupIndex = currentUserExperiment?.group === 'Test' ? 1 : 0;

      bucketUrl += `e${i}g${groupIndex}`;
    }
  }

  return bucketUrl;
}
```

Rewrite Response
: &nbsp;
: De middleware herschrijft (rewrite) de response door de bron-URL (gecodeerde URL) te vervangen door het request pad (de URL die de gebruiker heeft aangevraagd). De url blijft voor de gebruiker hetzelfde terwijl er een request wordt gedaan naar een pagina met de gecodeerde url (de combinatie van experimenten op een pagina). \newline

Build Step
: &nbsp;
: De verschillende combinaties van experimenten krijgen tot een maximum van standaard 100 elk hun eigen pagina met elk een eigen gecodeerde url, zie [@fig:encode-url]. 
Wanneer een gebruiker een pagina opvraagt die nog niet is voorbereid of opgeslagen in de Vercel Edge-cache, wordt deze on-demand gegenereerd via Incremental Static Regeneration (ISR) en vervolgens gecached voor toekomstige verzoeken. \newline

Generate Static Params
: &nbsp;
: Tijdens de build step worden statische parameters gegenereerd door het decoderen van de URL, zoals geïllustreerd in de code op de volgende pagina. In de app-router van Next.js duidt [bucket] in het pad op een dynamische route[^dynamic-routes], die de combinatie van experimenten op een bepaald pad representeert. Elk van deze paden kan tot een maximum van 100 worden voorbereid, elk met zijn eigen unieke set parameters. \newline

[^dynamic-routes]: Dynamic Routes: ttps://nextjs.org/docs/pages/building-your-application/routing/dynamic-routes

Request with Encoded URL 
: &nbsp;
: De server verwerkt het verzoek met de gecodeerde URL. \newline

Serve the Pre-build Page
: &nbsp;
: De server levert de vooraf gebouwde pagina aan de gebruiker. \newline

`app/shop/[bucket]/page.tsx`
```ts
export function generateStaticParams() {
  const encodedUrls = generateStaticParamsBuckets('/shop');
  return encodedUrls.map((url) => ({ bucket: url }));
}

export default function ShopPage({ params }: { params: { bucket: string } }) {
  const decoded = getParamsFromCombination(params.bucket);
  return (
    <div
      className={cn({
        'bg-red-600': decoded?.shop?.bgColor === 'red',
        'bg-green-600': decoded?.shop?.bgColor === 'green',
      })}
    >
      {decoded.shop?.layout === 'grid' ? (
        <div className="grid grid-cols-3 gap-4">
          <p>Product 1</p>
          <p>Product 2</p>
          <p>Product 3</p>
        </div>
      ) : decoded.shop?.layout === 'flex' ? (
        <div className="flex flex-row gap-4">
          <p>Product 1</p>
          <p>Product 2</p>
          <p>Product 3</p>
        </div>
      ) : (
        <p>No layout</p>
      )}
    </div>
  );
}
```


\newpage
# Aanbeveling {#sec:aanbeveling}
De implementatie van een intern A/B test systeem bij PLNTS biedt veelbelovende mogelijkheden voor datagestuurde besluitvorming en optimalisatie van de gebruikerservaring.
Gezien de positieve resultaten van de proof of concept, wordt aanbevolen om het A/B test systeem verder te integreren en te ontwikkelen binnen de omgeving van PLNTS.
Statsig blijkt een effectieve keuze voor de huidige behoeften van PLNTS, gezien de naadloze integratie met Vercel en Next.js.
Toch is het belangrijk om flexibel te blijven en open te staan voor toekomstige aanpassingen of verbeteringen aan het systeem, afhankelijk van de evoluerende eisen en technologische trends.

# Conclusie {#sec:conclusie}
Dit onderzoek heeft aangetoond dat de implementatie en integratie van A/B testen een grote rol rol spelen in het verbeteren van de e-commerce ervaring bij PLNTS.
Door het succesvol testen en analyseren van verschillende website elementen, kan PLNTS zijn digitale strategie effectiever afstemmen op de behoeften en voorkeuren van zijn gebruikers.
Dit leidt niet alleen tot een betere gebruikerservaring maar ook tot een hogere conversie en klanttevredenheid.
PLNTS kan met behulp van het ontwerp en de opgeleverde broncode de juiste stappen zetten voor een succesvolle implementatie binnen hun website.

A/B testen blijft een essentiële tool voor elk bedrijf dat streeft naar continue verbetering, innovatie en data gedreven besluitvorming in een steeds veranderende digitale wereld.

\newpage
# Bijlagen

## Notion artikel {#sec:notion-artikel}
> \LARGE A/B Testing \
> 
> 
> \small
> One of the most effective methods to obtain actionable insights from user behavior is A/B testing. This technique involves comparing two versions of a webpage or app against each other to determine which one performs better in terms of driving desired user actions. In the subsequent sections, we delve deep into categorized A/B testing ideas tailored for [plnts.com](http://plnts.com/), aiming to shed light on potential areas of optimization and the unique metrics that can help gauge their success.
> 
> \large Categorized A/B Testing Ideas for [plnts.com](http://plnts.com/) \
> 
> \small
> 1. Product Listings and Display:
>   - Test: Different layouts (grid view vs. list view) or product image sizes.
>   - Metrics:
>     - Click-through rate
>     - Product views
>     - Time spent on product pages
>     - Add-to-cart rate \newline
>     - *Misschien hier AOV toevoegen?*
>     - *Misschien hier Aantal producten per bestelling toevoegen?*
>
> \normalsize
> **Average orde value (AOV) -> Helps understand purchasing behavior, because it gives a better understanding of how much a customer is willing to spend on a single purchase.**
>
> **Number of products per order -> Similar to AOV, this metric helps understand purchasing behavior.**
>
> \small
> 2. Product Descriptions:
>   - Test: Different description lengths, formats, or user reviews vs. professional descriptions.
>   - Metrics:
>     - Time spent on product page
>     - Add-to-cart rate
>     - Conversion rate \newline
>     - *Misschien hier voor CS ook iets meetbaar maken? Aantal vragen over een specifiek product? Dan zou je echt een integratie moeten maken met Zendesk en dat is een andere fase denk ik*
>
> \normalsize
> **Customer satisfaction (CS) -> Helps understand how satisfied customers are with the product.**
>
> \small
> 3. Call-to-Action (CTA) Buttons:
>   - Test: Different button colors, sizes, text (e.g., "Buy Now" vs. "Add to Cart").
>   - Metrics:
>     - Click-through rate of the CTA
>     - Conversion rate \newline
>     - *Misschien exit % toevoegen? Hoeveel mensen haken af door deze aanpassing (mogelijk te veel push)*
>
> \normalsize
> **Exit rate -> Helps understand how many people leave the site after viewing a specific page.**
> 
> \small
> 4. Pricing and Promotions:
>   - Test: Different pricing strategies or promotional offers (e.g., "20% off" vs. "Buy One Get One Free").
>   - Metrics:
>     - Conversion rate
>     - Average order value
>     - Total sales \newline
>     - *Misschien exit % toevoegen? Hoeveel mensen haken af door deze aanpassing (mogelijk te veel push)*
>     - *Misschien add-to-cart % toevoegen*
> 
> \normalsize
> **Exit rate -> see above**
>
> **Add-to-cart rate -> Helps understand how many people add a product to their cart after viewing it.**
> 
> \small
> 5. Checkout Process:
>   - Test: Single-page vs. multi-step checkout or different checkout page designs.
>   - Metrics:
>     - Cart abandonment rate
>     - Conversion rate
>     - *Misschien exit % toevoegen? Hoeveel mensen haken af door deze aanpassing (mogelijk te veel push)*
>
> \normalsize
> **Exit rate -> see above**
>     - *Mogelijk kan je de AOV nog omhoog krikken door in de check-out upsells toe te voegen?*
>
> **Average order value (AOV) -> see above**
> 
> \small
> 6. Landing Pages
>   - Test: Different designs, images, headlines, or content structures.
>   - Metrics:
>     - Bounce rate
>     - Time spent on page
>     - Conversion rate
> 7. Navigation and Menu:
>   - Test: Different menu structures or navigation layouts.
>   - Metrics:
>     - Bounce rate
>     - Time spent on site
>     - Pages viewed per session
> 8. Search Functionality:
>   - Test: Search bar placement, predictive search suggestions, or filter options.
>   - Metrics:
>     - Use of search functionality
>     - Conversion rate from search results
>     - User satisfaction with search results
> 9. Email Sign-Up Prompts:
>   - Test: Pop-up vs. embedded sign-up forms or different incentives for signing up (e.g., discount codes vs. care guides).
>   - Metrics:
>     - Email sign-up rate
>     - Bounce rate
>     - Subsequent open and click rates of emails
> 10. Product Recommendations:
>   - Test: Algorithmic recommendations vs. curated ones.
>   - Metrics:
>     - Click-through rate on recommended products
>     - Average order value
>     - Conversion rate
> 11. Mobile vs. Desktop Experience:
>   - Test: Different mobile layouts or features.
>   - Metrics:
>     - Mobile conversion rate
>     - Bounce rate
>     - Average session duration
> 12. Testimonials and User Feedback: → *gebruiken we nu Hotjar voor*
>
> \normalsize
> **Hotjar -> Helps understand how users interact with the site.**
> 
> \small
>   - Test: Exploring various positions and formats for reviews, ratings, or user testimonials.
>   - Metrics:
>     - Trust metrics
>     - Conversion rate
>     - Time spent on pages with testimonials
> 13. Content and Blog: → *deze zou ik er persoonlijk uit halen, op content zit bij ons niet veel volume*
>   - Test: Different content formats (e.g., videos, articles, infographics) or different topics.
>   - Metrics:
>     - Engagement metrics like time spent on page
>     - Shares (For the future, currently not a feature)
>     - Comments (For the future, currently not a feature)
>     - Return visits
> 
> \large Unique Metrics from A/B Testing Ideas for [plnts.com](http://plnts.com/):\
> 
> \small
> 1. Click-through rate (CTR):
>   - Description: The percentage of people who clicked on an element (like an ad, link, or button) out of the total who viewed it. It's a primary measure of user engagement and the effectiveness of calls-to-action.
> 2. Product page views:
>   - Description: The number of times a product page is viewed. It helps understand product interest.
> 3. Add-to-cart rate:
>   - Description: The percentage of visitors who add a product to the cart after viewing it. It's an initial step towards conversion.
> 4. Conversion rate:
>   - Description: The percentage of visitors who take a desired action, typically making a purchase. It indicates the effectiveness of the site in persuading visitors to become customers.
> 5. Average order value (AOV):
>   - Description: The average amount of money each customer spends per transaction. It helps understand purchasing behavior.
> 6. Total sales:
>   - Description: The complete number of sales made within a specific time frame.
> 7. Bounce rate:
>   - Description: The percentage of visitors who navigate away from the site after viewing only one page. A high bounce rate can indicate irrelevant content or poor user experience.
> 8. Pages per session:
>   - Description: Average number of pages viewed during a single session. It helps measure user engagement.
> 9. Search usage rate:
>   - Description: The percentage of visitors who use the site's search function. A higher rate can indicate navigation problems or users looking for specific products.
> 10. Cart abandonment rate:
>   - Description: The percentage of shoppers who add items to their cart but do not complete the purchase. It helps identify potential issues in the checkout process.
> 11. Email sign-up rate:
>   - Description: The percentage of visitors who subscribe to the email list. Higher rates can indicate effective incentives or interest in staying connected.
> 12. Email open and click rates:
>   - Description: Respectively, the percentage of recipients who open an email and the percentage of those who click on a link within it. These rates measure the effectiveness of email campaigns.
> 13. Time on testimonial pages:
>   - Description: Average duration users spend on pages containing testimonials or reviews. It can indicate the influence of social proof on buying decisions.
> 14. Page engagement (duration, return visits):
>   - Description: Measures like time spent on a page and the frequency of return visits. They help gauge the effectiveness and relevance of content to users.
> 
> \large Combining Click Path with Other Metrics: \
> 
> \small
> 1. Click Path + Time Spent:
>   - Analyze the duration users spend on each page in their click path to see which content keeps them engaged and which doesn’t.
> 2. Click Path + Conversion Rate:
>   - Understand which navigation paths are most likely to lead to conversions. This can help in streamlining the user journey for higher conversions.
> 3. Click Path + Bounce Rate:
>   - If specific click paths have a high bounce rate, investigate those paths or pages for possible issues.
> 4. Click Path + Exit Rate:
>   - Identify pages where users frequently exit. This might show pages that are not meeting user expectations.
> 5. Click Path + Cart Abandonment Rate:
>   - Understand at which step users are abandoning their carts. This can help refine the checkout process.
> 6. Click Path + CTR:
>   - For paths that include promotional or CTA elements, checking the click-through rates can help evaluate the effectiveness of those elements in the user journey.
> 7. Click Path + Search Usage Rate:
>   - If users are frequently using search in their paths, it may indicate they're having trouble finding what they need through regular navigation.
> 8. Click Path + Product Page Views/Add-to-Cart Rate:
>   - Understand the sequence of products viewed and how often they lead to a product being added to the cart. This can provide insights into cross-selling or upselling opportunities.
> 
> \large Things to Note \
> 
> \small
> - Not all metrics are equally easy to measure. While metrics like click-through rate or bounce rate can be directly captured through most analytics tools, metrics like "trust" or "user satisfaction" may require more indirect methods, such as surveys or user feedback sessions.
> - To measure specific metrics, integration with our other utilized platforms is essential. For example, to gauge the effectiveness of email campaigns, we need to integrate our analytics tool with our email marketing platform. Additionally, integration with Magento and Tweakwise might be necessary to gain deeper insights into e-commerce behavior and search functionalities.
> - When combining metrics, such as Click Path with others, it's vital to consider the user's journey's broader context. For instance, a longer time spent on a page could indicate interest, but it could also suggest confusion.
> 
> \large Conclusion \
> 
> \small
> A/B testing is a powerful method to optimize the user experience and improve conversion rates. By systematically experimenting with various elements of the website, from product displays to CTA buttons, we can make data-driven decisions about the most effective design and content strategies.
> 
> Furthermore, by coupling traditional metrics like conversion rates and bounce rates with more detailed analytics, such as click paths, we can gain a comprehensive understanding of user behavior. This, in turn, allows us to tailor the user experience more closely to our audience's preferences and needs.
> 
> However, as with all data-driven approaches, the key to success lies in meticulous execution and interpretation. Integration with other platforms, careful choice of metrics, and an understanding of the broader user journey are essential to ensure that our tests yield actionable insights. Only then can we truly harness the full potential of A/B testing to refine and elevate the user experience on [plnts.com](http://plnts.com/).

\newpage
# Bronnen {#sec:bronnen}
&nbsp;

--- 
END FILE ONDERZOEKSRAPPORT
BEGIN FILE PRESENTATIE
---

---
title: "Integratie van A/B-testen bij PLNTS: Een Stage- en Onderzoeksverslag"
author: "Jouw Naam"
date: "Datum van Presentatie"
institute: "PLNTS & Hogeschool"
theme: "metropolis"
colortheme: "beaver"
header-includes:
  - \usecolortheme{dove}
  - \setbeamercolor{background canvas}{bg=black}
  - \setbeamercolor{normal text}{fg=white}
  - \usefonttheme{serif}
---

# Inleiding

## Welkom

- Welkom bij mijn presentatie
- Overzicht van de presentatie

# Stage Ervaring bij PLNTS

## Introductie tot PLNTS

- **PLNTS**: E-commerce voor plantenliefhebbers
- Missie: Toegankelijkheid van plantenverzorging

## Doelstellingen en Verwachtingen

- Persoonlijke doelstellingen: Groeien in A/B-testen en data-analyse
- Professionele doelstellingen: Bijdragen aan PLNTS door A/B-testen

## Uitgevoerde Werkzaamheden

- **A/B-testingsysteem**: Ontwerp en implementatie
- **Analyse**: Evaluatie van A/B-testtools

## Leerervaringen en Competenties

- **Groei**: Kennis in A/B-testen en data-analyse
- **Vaardigheden**: Technische en communicatieve vaardigheden ontwikkeld
  

# Onderzoek

## Onderzoeksvraag

- Hoe kan A/B-testen geïntegreerd worden binnen PLNTS?

## Methodologie

- **Onderzoeksmethoden**: Literatuuronderzoek, interviews, enquêtes

## Resultaten

- **Bevindingen**: Geschikte A/B-testtools en methoden

## Conclusies en Aanbevelingen

- **Aanbevelingen**: Toekomstige strategieën voor A/B-testen bij PLNTS

# Demonstratie

- *Demonstratie*: Korte demo van het A/B-testingsysteem

# Afsluiting en Q&A

## Samenvatting

- **Samenvatting**: Kernpunten van stage en onderzoek
- **Dankwoord**: Aan PLNTS, begeleiders en collega's

## Q&A

- Uitnodiging voor vragen

--- 
END FILE PRESENTATIE
BEGIN FILE SCRIPT
---

# Presentatie script.
// 



