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
  \fancyhead[C]{Test Rapport}
  \fancyhead[R]{\leftmark}
  \fancyfoot[C]{Page \thepage}
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
date: Februari - April 2024
output: 
  pdf_document:
    template: template.tex
lang: nl
figureTitle: "Figuur"
figPrefix: "Figuur"
secPrefix: ""
---

\begin{center}
\Huge Pint and Pillage
\end{center}

\vfill

\begin{center}
\huge Test Rapport
\end{center}

\begin{center}
\LARGE Benjamin Shawki
\end{center}

\begin{center}
\Large Februari - April 2024
\end{center}

\vfill

\begin{center}
Versie 1.0 definitief - 21 April 2024
\end{center}

\vfill

\newpage

\tableofcontents

\newpage

# Inleiding

Dit testrapport is opgesteld voor de module ITSTEN, waarbij de focus ligt op het testen van de software `Pint and Pillage`. Dit testrapport bevat een overzicht van de teststrategie, testcases, testresultaten en aanbevelingen voor de verdere ontwikkeling van de software.

## Notitie over Automatisering
In de bijgeleverde codebase is ook een development pipeline opgezet voor de module IPSENH die automatisch de tests uitvoert bij elke push naar de repository. Dit is een belangrijke stap in het testproces, omdat het van belang is dat op elke nieuwe release de testen uitgevoerd dienen te worden voordat deze naar de productie omgeving wordt overgezet. Deze verandering zijn in de codebase opgenomen, en zitten voornamelijk in de root van de repository. Er zijn ook een paar aanpassingen gemaakt zodat dit project via docker en via de originele manier kan worden opgestart. De bijkomende vereiste is wel dat er een .env file aanwezig is in de Frontend.

# ISTQB? Wat en Waarom?

## Wat is testen en waarom testen we?

Het testen van software is uiterst noodzakelijk om te garanderen dat de ontwikkelde software aan verwachtingen van stakeholders voldoet, functioneel correct is, en helpt bij het voorkomen van kritieke fouten.
Het belang van testen is niet altijd even groot, in omgevingen waar de impact van fouten in software direct grote gevolgen heeft het leven van mensen, is testen van cruciaal belang.
Denk aan medische applicaties, zoals de software die een chirurg gebruikt, vliegtuig software of bank applicaties.
Als er fouten in deze software zitten, kan dit leiden tot ernstige gevolgen, zoals het verlies van mensenlevens of grote financiële schade.

## ISTQB

De [International Software Testing Qualifications Board (ISTQB)](https://www.istqb.org/)[^istqb-org], heeft een aantal principes opgesteld die de basis vormen voor effectief testen.

[^istqb-org]: ISTQB, "International Software Testing Qualifications Board," [Online]. Available: https://www.istqb.org/. [Accessed 20 April 2024].

### Testing Shows The Presence Of Defects, Not Their Absence

Dit principe benadrukt dat het doel van testen is om defecten te vinden, niet om aan te tonen dat de software vrij van fouten is. Het is onmogelijk om alle mogelijke problemen in software uit te sluiten; daarom moet testen gericht zijn op het effectief opsporen van defecten.

**Voorbeeld uit de codebase:**
```java
@Test
void shouldThrowExceptionWhenInsufficientResources() {
    buildingMock.setResourcesRequiredLevelUp(resourceHelper.generateResource(ResourceType.Stone, 100));
    buildingMock.setVillage(villageMock);

    when(villageMock.getVillageResources())
        .thenReturn(resourceHelper.generateResource(ResourceType.Stone, 10));

    BuildingConditionsNotMetException thrown = assertThrows(BuildingConditionsNotMetException.class,
        () -> buildingMock.levelUp());

    assertThat(thrown.getMessage(), is("Not enough resources available"));
}
```

Deze test illustreert het zoeken naar defecten door te bevestigen dat het systeem fouten correct afhandelt wanneer er onvoldoende resources aanwezig.

### Exhaustive Testing Is Impossible
Volledige testdekking is onpraktisch en onhaalbaar; in plaats daarvan moet risico-gebaseerde prioritisering van tests plaatsvinden om de meest kritische functionaliteiten te dekken. Dit vereist het maken van keuzes over wat belangrijk is om te testen op basis van de waarschijnlijkheid van fouten en de potentiële impact van die fouten.

### Early Testing Saves Time And Money

Vroegtijdig testen helpt bij het sneller identificeren van fouten, wat kosten bespaart doordat fouten minder complex zijn om op te lossen wanneer ze vroeg worden ontdekt. Het is veel kostenefficiënter om fouten te corrigeren in de ontwerpfase dan na de implementatie, wanneer wijzigingen in de code duurder en tijdrovender kunnen zijn.

**Voorbeeld uit de codebase:**
```java
@Test
void shouldFinishConstructionOnLevelUp() {
    LocalDateTime expectedFinishTime = LocalDateTime.now().plusSeconds(10);

    setupVillageStub();
    buildingMock.setConstructionTimeSeconds(10);
    buildingMock.levelUp();

    LocalDateTime actualFinishTime = buildingMock.getLevelupFinishedTime();

    assertThat(actualFinishTime.withNano(0), is(expectedFinishTime.withNano(0)));
}
```
Deze test, die vroegtijdig controleert of de bouwtijd correct wordt bijgewerkt na een upgrade, bespaart potentieel tijd en geld door grote problemen in latere fasen te voorkomen.

### Defects Cluster Together
Defecten clusteren vaak samen rondom bepaalde functionaliteiten. Door te focussen op specifieke gebieden kan de inspanning een tester optimaal gebruikt worden, daar waar de impact het grootst is. Dit vereist een goed begrip van de applicatie om te weten waar deze defecten waarschijnlijk zullen voorkomen. In de codebase van `Pint and Pillage`, kunnen defecten zich concentreren rond complexe spelmechanismen zoals resource management of het bouwen van gebouwen. Dit zijn kritieke onderdelen van het spel waar kleine fouten grote impact kunnen hebben op de speelervaring. 

### Beware Of The Pesticide Paradox
Het regelmatig vernieuwen van testcases is noodzakelijk om aanpassing aan de geteste software te voorkomen, wat zou kunnen resulteren in het missen van nieuwe fouten. Net als insecten die resistentie ontwikkelen tegen pesticiden, kunnen tests die steeds opnieuw worden gebruikt hun effectiviteit verliezen. Nu is dit voor Pint and Pillage niet van groot belang, gezien dat dit legacy software is waaraan geen nieuwe content wordt toegevoegd. Echter, stel dat nieuwe content en features regelmatig worden geïntroduceerd, zoals nieuwe gebouwen of upgrades, en als dezelfde tests steeds opnieuw worden uitgevoerd zonder deze aan te passen aan de nieuwe functionaliteiten, kunnen sommige fouten onopgemerkt blijven. Het is essentieel om de testcases regelmatig te herzien en bij te werken, om ervoor te zorgen dat ze nog steeds effectief zijn en nieuwe defecten kunnen onthullen.

### Testing Is Context Dependent
De context van de applicatie bepaalt de testaanpak. Wat werkt voor het ene type software is mogelijk niet effectief voor een ander. Elk softwareproject vereist een unieke benadering die past bij de specifieke technische en zakelijke eisen van dat project.
De testaanpak voor Pint and Pillage, wat een complexe interactie tussen verschillende spelcomponenten bevat zoals handel, gevechten en wereldopbouw, verschillen significant van die voor de software dammen en dijken rondom de kust monitoren. 

### Absence-Of-Errors Is A Fallacy
Het is een misvatting om te denken dat software die vrijwel foutloos is getest, ook daadwerkelijk bruikbaar is. Software kan technisch correct zijn maar toch falen om aan de zakelijke vereisten of gebruikersbehoeften te voldoen. Dit principe benadrukt het belang van het testen van de software tegen de werkelijke eisen en verwachtingen van de eindgebruiker.

## Test Coverage

Test coverage is een belangrijke maatstaf in softwaretesten. Een hoge test coverage helpt te garanderen dat de meeste, zo niet alle, functies van de applicatie zijn gecontroleerd onder verschillende condities.

### Het belang van Test Coverage
In theorie zou perfecte test coverage betekenen dat elke lijn code en elke mogelijke pad in de run time wordt uitgevoerd. Dit zou een enorme zekerheid bieden, omdat vrijwel elk scenario dat zou kunnen voorkomen bij gebruik van de software, al is getest. De realiteit is echter dat volledige coverage praktisch onhaalbaar is gezien de vaak exponentiële hoeveelheid aantal paden bij complexe systemen.

### Pint and Pillage Test Coverage
De test coverage waar ik me op gefocust heb in Pint and Pillage zijn de gameplay elementen zoals resource management, het maken van gebouwen, de algehele logica van hoe een dorp zich moet gedragen. Verder heb ik ook de authenticatie grondig getest.

- **Resource Management Tests:** Verzekeren dat spelers niet meer resources kunnen gebruiken dan ze beschikbaar hebben en dat de resource aantallen correct worden bijgewerkt na elke game actie.
- **Buliding Tests:** Controleren of gebouwen alleen kunnen worden geüpgraded of gebouwd als aan alle voorwaarden is voldaan, zoals voldoende middelen en het vrijspelen van benodigde technologieën.
- **Village Logic Tests:** Testen van de algehele logica van het dorp, zoals het updaten van de tijd die nodig is om een gebouw te bouwen of te upgraden, het updaten van de resources en het verwerken van acties van de speler.
- **Authentication Tests:** Verifiëren dat gebruikers correct kunnen inloggen en dat onjuiste inloggegevens worden geweigerd.

### Teststrategie
Voor Pint and Pillage zijn er verschillende typen testen toegepast om een brede coverage te bereiken:

- **Unit Tests voor Backend en Frontend:** Deze tests zijn gericht op individuele functies en componenten om te verzekeren dat ze correct functioneren binnen hun eigen scope. 

- **End-to-End (E2E) Tests:** Simuleren de gebruikers interacties van begin tot eind. Deze tests zijn waardevol voor het valideren van de werking het spel als algemeen geheel, inclusief de interacties tussen alle componenten en de gebruikersinterface.

# Unit Tests

## Frontend

### tests/unit/window.spec.js

#### Tests:
- Should render village properly
- Should display tutorial when first logged in
- Should not show tutorial modal when it is the first login

#### Waarom:
Belangrijke elementen moeten correct weer worden gegeven op de tijd dat ze nodig zijn.

#### Toegevoegde waarde:
Deze tests helpen bij het valideren van de correcte weergave van de tutorial modals en zorgen ervoor dat ze alleen worden weergegeven wanneer dat nodig is.

#### User Story: 1, 2

#### Dependencies: 
- Vue.js
- Vuex
- Jest

#### Refactored code:

PintAndPillageFrontend/src/views/Village.vue:2
```js
  <div id="village" class="village">
```

PintAndPillageFrontend/src/components/ui/modals/TutorialModal.vue:2
```js
  <div id="tutorial-modal" class="tutorialBaseModal" @click="close">
```

## Backend

### src/test/java/nl/duckstudios/pintandpillage/entity/BuildingTest.java

#### Tests:
- shouldFinishConstructionOnLevelUp
- shouldBeUnderConstructionWhenLevelingUp
- shouldThrowExceptionWhenInsufficientResources
- shouldThrowExceptionWhenInsufficientPopulation

#### Waarom: 
Gebouwen zijn de kern van het spel en moeten correct worden geüpgraded en gebouwd.

#### Toegevoegde waarde:
Deze tests controleren of de bouw van gebouwen correct verloopt en of de juiste exceptions worden gegenereerd wanneer er onvoldoende resources of population beschikbaar zijn.

#### User Story: 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17

#### Dependencies: 
- JUnit 5
- Mockito
- Hamcrest

#### Test theorie:
- Mocking: Village en ResourceManager worden gemockt om de test te isoleren van externe afhankelijkheden.
- Stubbing: De mock village wordt gestubd om de test te voorzien van de juiste resources en populatie.
- Exception Testing: De tests controleren of de juiste exceptions worden gegenereerd wanneer aan de voorwaarden niet wordt voldaan.
- Spy: De ResourceManager wordt gespied om te controleren of de juiste methoden worden aangeroepen.

#### Refactored code:{#sec:resource-building-refactor}
- src/main/java/nl/duckstudios/pintandpillage/entity/Building.java:25
```java
  // Changed: removed final for testing
  @Transient
  protected ResourceManager resourceManager;
```

- src/main/java/nl/duckstudios/pintandpillage/entity/Village.java:90
```java
  // Changed: private to protected for testing
  @OneToMany(mappedBy = "village", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
  @JsonManagedReference
  protected Set<Building> buildings;
```

### src/test/java/nl/duckstudios/pintandpillage/entity/DefenseBuildingTest.java

#### Tests:
- testWallDefenseIncreaseOnLevelUp
- testDefenceTowerDefenseIncreaseOnLevelUp

#### Waarom: 
Defence buildings zijn cruciaal voor de verdediging van het dorp en moeten correct worden geüpgraded.

#### Toegevoegde waarde:
Deze tests controleren of de verdedigingspunten van de muur en de defence toren correct worden bijgewerkt bij het upgraden van het gebouw.

#### User Story: 10, 14

#### Requirements: 6, 17

#### Dependencies: 
- JUnit 5
- Mockito
- Hamcrest

#### Test theorie:
- Mocking: Village en ResourceManager worden gemockt om de test te isoleren van externe afhankelijkheden.
- Stubbing: De mock village wordt gestubd om de test te voorzien van de juiste resources en populatie.

#### Refactored code:
- src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Wall.java:20
```java
  // Changed: Add the headquarters requirement
  @Getter @Setter @Transient
  private Map<String, Integer> buildingLevelRequiredToLevelup =
      new HashMap<>() {
        {
          put("Headquarters", 3);
        }
      };
```

- src/main/java/nl/duckstudios/pintandpillage/entity/buildings/DefenceTower.java:23
```java
  // Changed: Add the headquarters, barracks and smith requirement
  @Getter
  @Setter
  @Transient
  private Map<String, Integer> buildingLevelRequiredToLevelup = new HashMap<>() {
    {
      put("Headquarters", 5);
      put("Barracks", 5);
      put("Smith", 3);
    }
  };
```

- De refactored Village en ResourceManager te vinden in  [@sec:resource-building-refactor]

### src/test/java/nl/duckstudios/pintandpillage/entity/HouseTest.java

#### Tests:
- testPopulationCapacityIncreasesWithLevelUp

#### Waarom:
Populatie is een belangrijke bron in het spel en moet correct worden bijgewerkt bij het upgraden van het huis.

#### Toegevoegde waarde:
Deze test controleert of de populatiecapaciteit van het huis correct wordt bijgewerkt bij het upgraden van het gebouw.

#### User Story: 4

#### Requirements: 4

#### Dependencies: 
- JUnit 5
- Mockito
- Hamcrest

#### Test theorie:
- Mocking: Village en ResourceManager worden gemockt om de test te isoleren van externe afhankelijkheden.
- Stubbing: De mock village wordt gestubd om de test te voorzien van de juiste resources en populatie.
- Voorbeeld van Arrange Act Assert (AAA) patroon.

#### Refactored code:
- src/main/java/nl/duckstudios/pintandpillage/entity/buildings/House.java:34
```java
    // Changed: Should be `Math.pow(super.getLevel(), 1.32)` and not `Math.pow(1.32,
    // super.getLevel())`
    this.populationCapacity = super.getLevel() == 0 ? 0
        : (int) (8 * (super.getLevel() * super.getLevel()) + 10 * Math.pow(super.getLevel(), 1.32));
```

- De refactored Village en ResourceManager te vinden in  [@sec:resource-building-refactor]

### srs/test/java/nl/duckstudios/pintandpillage/entity/LumberyardTest.java

#### Tests:
- shouldIncreaceWoodProductionWhenLevelingUp

#### Waarom:
Hout is een key resource in het spel en moet correct worden bijgewerkt bij het upgraden van de houtzagerij.

#### Toegevoegde waarde:
Deze test controleert of de houtproductie van de houtzagerij correct wordt bijgewerkt bij het upgraden van het gebouw.

#### User Story: 5, 15

#### Requirements: 3

#### Dependencies:
- JUnit 5
- Mockito
- Hamcrest

#### Test theorie:
- Mocking: Village en ResourceManager worden gemockt om de test te isoleren van externe afhankelijkheden.
- Stubbing: De mock village wordt gestubd om de test te voorzien van de juiste resources en populatie.

#### Refactored code:
- src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Lumberyard.java:25
```java
  // Changed:
  private int updateResourcesPerHour() {
    return (int)(20 + 12 * Math.pow(super.getLevel(), 1.2));
  }
  // private int updateResourcesPerHour() {
  //   return 1000000;
  // }
```

- De refactored Village en ResourceManager te vinden in  [@sec:resource-building-refactor]

### src/test/java/nl/duckstudios/pintandpillage/entity/MineTest.java

#### Tests:
- shouldBeInstantceOfResourceBuilding
- shouldHaveLevelUpResources
- shouldlevelUp
- shouldHaveIncreasedCostOnLevelUp

#### Waarom:
De mijn is een belangrijk resource gebouw en moet correct worden geüpgraded.

#### Toegevoegde waarde:
Deze tests controleren of de mijn correct wordt geüpgraded en of de kosten correct worden bijgewerkt bij het upgraden van het gebouw.

#### User Story: 6, 15

#### Requirements: 3

#### Dependencies:
- JUnit 5
- Mockito
- Hamcrest

#### Test theorie:
- Mocking: Village en ResourceManager worden gemockt om de test te isoleren van externe afhankelijkheden.
- Stubbing: De mock village wordt gestubd om de test te voorzien van de juiste resources en populatie.

#### Refactored code:
- De refactored Village en ResourceManager te vinden in  [@sec:resource-building-refactor]

### src/test/java/nl/duckstudios/pintandpillage/entity/ProductionBuildingTest.java

#### Tests:
- shouldThrowExceptionForLockedUnit
- shouldThrowExceptionForLockedResearch
- shouldThrowExceptionForInsufficientPopulation
- shouldThrowExceptionWhenInsufficientResources
- shouldSubtractResourcesWhenConditionsAreMet
- shouldIncreaseQueueLimitByOneEveryFiveLevelsForBarracks

#### Waarom:
Productiegebouwen zijn essentieel voor het maken van units en moeten correct functioneren.

#### Toegevoegde waarde:
Deze tests controleren of de productie van units correct verloopt en of de juiste exceptions worden gegenereerd wanneer aan de voorwaarden niet wordt voldaan.

#### User Story: 9, 18, 28

#### Requirements: 9, 10

#### Dependencies
- JUnit 5
- Mockito
- Hamcrest

#### Test theorie:
- Mocking: Village, ResourceManager, Barracks en ProductionBuilding worden gemockt om de test te isoleren van externe afhankelijkheden.
- Stubbing: De mock village wordt gestubd om de test te voorzien van de juiste resources en populatie.
- Exception Testing: De tests controleren of de juiste exceptions worden gegenereerd wanneer aan de voorwaarden niet wordt voldaan.

#### Refactored code:{#sec:barracks-refactor}
- src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:66
```java
    // Changed: instead of setting the queue limit directly, we call a method to set
    // it based on the
    // level of the building
    setQueueLimitBasedOnLevel(super.getLevel());
    super.setResourcesRequiredLevelUp(
        new HashMap<>() {
          {
            int level = Barracks.super.getLevel();
            put(ResourceType.Wood.name(), 1000 + 25 * level + 8 * level * level);
            put(ResourceType.Stone.name(), 800 + 20 * level + 6 * level * level);
          }
        });
    super.checkProduction();
```
- src/main/java/nl/duckstudios/pintandpillage/entity/buildings/Barracks.java:53
```java
  // Changed: Added this method to set the queue limit based on the level of the
  // building
  private void setQueueLimitBasedOnLevel(int level) {
    int baseQueueLimit = 5;
    int additionalUnits = level / 5;
    super.setQueueLimit(baseQueueLimit + additionalUnits);
  }
```
- De refactored Village en ResourceManager te vinden in  [@sec:resource-building-refactor]

### src/test/java/nl/duckstudios/pintandpillage/entity/ResearchBuildingTest.java

#### Tests:
- shouldThrowExeptionWhenResearchAlreadyInProgress
- shouldThrowExeptionWhenInsufficientResourcesForResearch
- shouldThrowExeptionWhenResearchBuildingIsToLowLevel
- shouldSubtractResourcesWhenResearching
- shouldIncreaseResearchTimeForHigherLevels
- shouldDecreseResearchTimeForHigherBuildingLevel
- shouldIncereaseResourceCostForHigherResearchLevels

#### Waarom:
Researches en research gebouwen zijn een belangrijk onderdeel van het spel en moet correct worden uitgevoerd.

#### Toegevoegde waarde:
Deze tests controleren of de researches correct worden uitgevoerd en of de juiste exceptions worden gegenereerd wanneer aan de voorwaarden niet wordt voldaan.

#### User Story: 17, 18

#### Requirements: 7, 8, 9

#### Dependencies:
- JUnit 5
- Mockito
- Hamcrest

#### Test theorie:
- Mocking: Village, ResourceManager en ResearchBuilding worden gemockt om de test te isoleren van externe afhankelijkheden.
- Stubbing: De mock village wordt gestubd om de test te voorzien van de juiste resources en populatie.
- Exception Testing: De tests controleren of de juiste exceptions worden gegenereerd wanneer aan de voorwaarden niet wordt voldaan.

#### Refactored code:
- De refactored Village en ResourceManager te vinden in  [@sec:resource-building-refactor]

### src/test/java/nl/duckstudios/pintandpillage/entity/ResearchTest.java

#### Tests:
- shouldIncreaseResourceCostWithIncreasedResearchLevel

#### Waarom:
Researches zijn een belangrijk onderdeel van het spel en moeten correct worden uitgevoerd.

#### Toegevoegde waarde:
Deze test controleert of de kosten van researches correct worden bijgewerkt bij het verhogen van het research level.

#### User Story: 17, 18
 
#### Requirements: 7

#### Dependencies:
- JUnit 5
- Mockito
- Hamcrest

#### Test theorie:
- Mocking: Village en ResourceManager worden gemockt om de test te isoleren van externe afhankelijkheden.
- Stubbing: De mock village wordt gestubd om de test te voorzien van de juiste resources en populatie.

#### Refactored code:
- De refactored Village en ResourceManager te vinden in  [@sec:resource-building-refactor]

### src/test/java/nl/duckstudios/pintandpillage/entity/ResourceBuildingTest.java

#### Tests:
- shouldPutLastCollectedWhenUpdateVillageState
- shouldNotCallAddResourcesWhenLastCollectResourcesIsInTheFuture
- shouldNotCallAddResourcesWhenNotGeneratingResources

#### Waarom:
Resource gebouwen zijn een belangrijk onderdeel van het spel en moeten correct functioneren.

#### Toegevoegde waarde:
Deze tests controleren of de resources correct worden bijgewerkt en of de juiste exceptions worden gegenereerd wanneer aan de voorwaarden niet wordt voldaan.

#### User Story: 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17

#### Requirements: 1, 2, 3

#### Dependencies:
- JUnit 5
- Mockito
- Hamcrest

#### Test theorie:
- Mocking: Village en ResourceManager worden gemockt om de test te isoleren van externe afhankelijkheden.
- Stubbing: De mock village wordt gestubd om de test te voorzien van de juiste resources en populatie.

#### Refactored code:
- src/main/java/nl/duckstudios/pintandpillage/entity/buildings/ResourceBuilding.java:14
```java
  // Changed: Fixed nullpointer exception
  @Getter
  @Setter
  private LocalDateTime lastCollected = LocalDateTime.MAX;
```
- De refactored Village en ResourceManager te vinden in  [@sec:resource-building-refactor]

### src/test/java/nl/duckstudios/pintandpillage/entity/StorageTest.java

#### Tests:
- shouldIncreaseResourceCostWithHigherBuildingLevel
- shouldIncreaseConstructionTimeWithHigherBuildingLevel

#### Waarom:
Storage buildings zijn een belangrijk onderdeel van het spel en moeten correct functioneren.

#### Toegevoegde waarde:
Deze tests controleren of de kosten en constructietijd van storage buildings correct worden bijgewerkt bij het upgraden van het gebouw.

#### User Story: 12

#### Requirements: 18

#### Dependencies:
- JUnit 5
- Mockito
- Hamcrest

#### Test theorie:
- Mocking: Village en ResourceManager worden gemockt om de test te isoleren van externe afhankelijkheden.
- Stubbing: De mock village wordt gestubd om de test te voorzien van de juiste resources en populatie.

#### Refactored code:
- De refactored Village en ResourceManager te vinden in  [@sec:resource-building-refactor]

### src/test/java/nl/duckstudios/pintandpillage/entity/VillageTest.java

#### Tests:
- shouldThrowExceptionWhenStorageIsFull

#### Waarom:
De opslag van resources is een belangrijk onderdeel van het spel en moet correct functioneren.

#### Toegevoegde waarde:
Deze test controleert of het dorp correct omgaat met de opslag van resources en de juiste exceptions genereert wanneer de opslag vol is.

#### User Story: 12

#### Requirements: 18

#### Dependencies:
- JUnit 5
- Mockito
- Hamcrest

#### Test theorie:
- Mocking: ResourceManager wordt gemockt om de test te isoleren van externe afhankelijkheden.
- Stubbing: De mock village wordt gestubd om de test te voorzien van de juiste resources en populatie.

#### Refactored code:
- De refactored Village en ResourceManager te vinden in  [@sec:resource-building-refactor]

### src/test/java/nl/duckstudios/pintandpillage/service/AccountServiceTest.java

#### Tests:
- throwsUnauthorizedExceptionForIncorrectUserId

#### Waarom:
Gebruikers moeten slechts toegang hebben tot hun eigen dorpen en niet die van anderen.

#### Toegevoegde waarde:
Deze test controleert of de correcte exceptions worden gegenereerd wanneer een gebruiker probeert toegang te krijgen tot een dorp dat niet van hem is.

#### Dependencies:
- JUnit 5
- Mockito
- Hamcrest

#### Test theorie:
- Mocking: Village en User worden gemockt om de test te isoleren van externe afhankelijkheden.
- Exception Testing: De test controleert of de juiste exceptions worden gegenereerd wanneer aan de voorwaarden niet wordt voldaan.

#### Refactored code:
- src/main/java/nl/duckstudios/pintandpillage/service/AccountService.java:12
```java
      // Changed: typo in exception message
      throw new UnauthorizedException("Not the owner of this village");
```
- De refactored Village en ResourceManager te vinden in  [@sec:resource-building-refactor]

### src/test/java/nl/duckstudios/pintandpillage/service/CombatServiceTest.java

#### Tests:
- shouldThrowExceptionWhenUnitListIsEmpty
- shouldThrowExceptionWhenNotEnoughUnitsAvailable
- shouldNotThrowExceptionWhenHasEnoughUnitsAvailable

#### Waarom:
Om te kunnen aanvallen moeten er voldoende units beschikbaar zijn en moet er minstens één unit worden meegestuurd.

#### Toegevoegde waarde:
Deze tests controleren of de juiste exceptions worden gegenereerd wanneer aan de voorwaarden niet wordt voldaan.

#### User Story: 25

#### Requirements: 9

#### Dependencies:
- JUnit 5
- Mockito
- Hamcrest

#### Test theorie:
- Mocking: Village en UnitFactory worden gemockt om de test te isoleren van externe afhankelijkheden.
- Exception Testing: De tests controleren of de juiste exceptions worden gegenereerd wanneer aan de voorwaarden niet wordt voldaan.

#### Refactored code:
- De refactored Village is te vinden in  [@sec:resource-building-refactor]

# End-to-End Tests
End-to-End tests zijn een belangrijk onderdedeel van de teststrategie voor Pint and Pillage. Deze tests simuleren de gebruikersinteracties van begin tot eind en helpen bij het valideren van de werking van het spel als geheel, inclusief de interacties tussen alle componenten en de gebruikersinterface.

## Tests:

### Authentication
- **Should not register when no username is provided:** Verifieert dat een gebruiker niet kan registreren zonder een gebruikersnaam.
- **Should not register when no email is provided:** Verifieert dat een gebruiker niet kan registreren zonder een e-mailadres.
- **Should not register when no password provided:** Verifieert dat een gebruiker niet kan registreren zonder een wachtwoord.
- **Should not register with short password:** Verifieert dat een gebruiker niet kan registreren met een te kort wachtwoord.
- **Should not register when no repeat password is provided:** Verifieert dat een gebruiker niet kan registreren zonder een herhaald wachtwoord.
- **Should not register with no matching password and repeat password:** Verifieert dat een gebruiker niet kan registreren met een niet-overeenkomend wachtwoord en herhaald wachtwoord.
- **Should register when provided correct credentials:** Verifieert dat een gebruiker kan registreren met de juiste inloggegevens.
- **Should not login with incorrect username:** Verifieert dat een gebruiker niet kan inloggen met een onjuiste gebruikersnaam.
- **Should not log in with wrong password:** Verifieert dat een gebruiker niet kan inloggen met een verkeerd wachtwoord.
- **Should log in when profided correct credentials:** Verifieert dat een gebruiker kan inloggen met de juiste inloggegevens.

De meerwaarde van deze tests is dat ze de correcte werking van de authenticatie functionaliteit van het spel valideren en ervoor zorgen dat gebruikers correct kunnen registreren en inloggen.

### Environmental variables
- **Should visit frontend when given correct environmental variables:** Verifieert dat de frontend correct wordt bezocht wanneer de juiste omgevingsvariabelen worden mee gegeven.

Deze test is van belang omdat het controleert of de omgevingsvariabelen correct worden ingesteld en de frontend correct wordt bezocht.

### Window
- **Should show tutorial when first logging in:** Verifieert dat de tutorial wordt weergegeven wanneer een gebruiker voor het eerst inlogt.
- **Should not show tutorial when not first logging in:** Verifieert dat de tutorial niet wordt weergegeven wanneer een gebruiker niet voor het eerst inlogt.
- **Should be open settings window:** Verifieert dat het instellingen venster kan worden geopend.
- **Should be able to logout:** Verifieert dat een gebruiker kan uitloggen.

Deze tests zijn van belang omdat ze de correcte werking van de gebruikersinterface valideren en ervoor zorgen dat de gebruiker de juiste interacties kan uitvoeren.

## Dependencies:
- Cypress
- Vue.js

## Test theorie:
- **User Interaction Testing:** De tests simuleren de gebruikersinteracties om te controleren of de gebruikersinterface correct reageert op de acties van de gebruiker.
- **End-to-End Testing:** De tests valideren de werking van het spel als geheel, inclusief de interacties tussen alle componenten en de gebruikersinterface.
- **Table Testing:** De tests controleren de verschillende scenario's en randgevallen om ervoor te zorgen dat er geregistreerd en ingelogd kan worden met de juiste inloggegevens.

## Refactored code:
Veel testen hebben een id nodig om de juiste elementen te selecteren en interacties uit te voeren. Deze id's zijn toegevoegd aan de frontend code om de testen correct uit te voeren. Dit betekend dat het niet volledig whitebox testing is, maar een combinatie van whitebox en blackbox testing. Echter zou het ook mogelijk zijn om de testen volledig blackbox te maken door geavanseerde selectors te gebruiken.

# Test Coverage

# Whitebox en Blackbox Testing

Whitebox en Blackbox Testing zijn twee verschillende benaderingen van software testing die elk hun eigen voordelen en toepassingen hebben. In dit hoofdstuk zullen we de verschillen tussen deze twee benaderingen bespreken en hoe ze zijn toegepast op de ITSTEN codebase.

## Blackbox Testing
Blackbox testing richt zich op de functionaliteit van het softwareproduct zonder kennis van de interne structuren of de werking van de applicatie.
Het test de functionaliteiten volgens de business requirements en gebruikersverwachtingen.
Deze vorm van testing kijkt alleen naar de inputs en de verwachte outputs, en verifieert of de applicatie zich gedraagt zoals verwacht zonder rekening te houden met de interne code. Enkele technieken die onder blackbox testing vallen zijn:

- Equivalence Partitioning
- Boundary Value Analysis
- State Transition Testing
- Table Testing
- Fuzzing

Elk van deze technieken helpt bij het identificeren van specifieke fouten die vaak voorkomen aan de randgevallen van de software of bij specifieke gebruiksvoorwaarden.

### Equivalence Partitioning
is een blackbox testmethode waarbij de input data van een softwareapplicatie wordt opgedeeld in delen die gelijk gedrag vertonen. Het idee is dat als een enkel item uit een partitie werkt zoals verwacht, dan alle andere items in die partitie dat ook zullen doen. Dit helpt bij het effectief verminderen van het aantal testgevallen dat nodig is om de software grondig te testen.

### Boundary Value Analysis
is een testmethode die erg lijkt op equivalence partitioning. Deze methode focust specifiek op de randwaarden van een bereik, gezien dat de meeste fouten juist op deze grenzen voorkomen. Je test niet alleen de grenswaarden, maar ook de waarden net binnen en net buiten de grenzen.

### State Transition Testing
zich op de statusveranderingen die een applicatie ondergaat in reactie op bepaalde events. Deze testmethode is erg relevant in systemen waar de status van een object een significante impact heeft op de functionaliteit van de applicatie.

### Table Testing
wordt gebruikt om gedrag van systemen te begrijpen en te testen op basis van een combinatie van inputs. Elke rij in een tabel vertegenwoordigt een unieke combinatie van voorwaarden en de corresponderende actie die moet worden genomen.

### Fuzzing
is een testtechniek waarbij automatisch of semi-automatisch grote hoeveelheden willekeurige data naar een softwareprogramma worden gestuurd in een poging om fouten en beveiligingslekken te ontdekken. De library [Chaos Monkey](https://netflix.github.io/chaosmonkey/)[^chaos-monkey] is een voorbeeld van een tool die fuzzing toepast om de veerkracht van systemen te testen.

[^chaos-monkey]: https://netflix.github.io/chaosmonkey/ [Accessed: 20 April 2024]

## Whitebox Testing
Whitebox testing, in tegenstelling tot blackbox testing, vereist gedetailleerde kennis van de interne werking van de applicatiecode. Het is gericht op het testen van de interne structuren of logica van de applicatie. Whitebox testing kan worden onderverdeeld in statische en dynamische tests.

### Statische Whitebox Testing
Statische tests worden uitgevoerd zonder dat de code wordt uitgevoerd. Deze tests zijn gericht op het analyseren van de code om fouten te vinden zonder de programma's daadwerkelijk te draaien. Technieken die gebruikt worden bij statische whitebox testing zijn onder andere:

- Code Reviews: Peer reviews waarbij meerdere ontwikkelaars samen de code doornemen om fouten en verbeterpunten te identificeren.
- Statische Analyse: Geautomatiseerde tools zoals SonarQube, Linters, of Semgrep worden gebruikt om de code te scannen op veelvoorkomende foutpatronen en best practices.

### Dynamische Whitebox Testing
Dynamische tests betreffen het uitvoeren van de code en het observeren van het gedrag en de output. Het helpt bij het valideren van de flow en de logica van de code tijdens de uitvoering. Unit tests en integratie tests zijn voorbeelden van dynamische whitebox tests.


Verder zijn er verschillende niveaus van whitebox testing, zoals:

### Code Coverage
is een meting die gebruikt wordt om te bepalen hoeveel code wordt uitgevoerd terwijl de geautomatiseerde tests draaien. Het helpt bij het identificeren van delen van een softwareprogramma die niet worden geraakt door een set tests. 

### Statement Coverage
meet het percentage van uitvoerbare statements in de broncode die zijn uitgevoerd tijdens een testproces. Het doel is om ervoor te zorgen dat alle codepaden worden getest en dat er geen deel van de code is dat ongetest blijft. Dit helpt bij het ontdekken van fouten in de basislogica van de codeblokken.

### Decision/Branch Coverage
gaat een stap verder dan statement coverage door te vereisen dat elke mogelijke route of vertakking op beslispunten (zoals if-else en switch-case statements) tijdens het testproces wordt uitgevoerd. Dit type dekking zorgt ervoor dat de tests alle conditionele logica verifiëren, wat helpt om subtielere fouten in de code die alleen onder specifieke voorwaarden voorkomen, op te sporen.

## Toepassing op de Codebase
De implementatie van zowel whitebox als blackbox testen binnen de codebase geven de specifieke teststrategieën weer en hoe deze zijn toegepast op verschillende onderdelen van de applicatie.

### Whitebox met Unit Tests van de Building Classes:
In de BuildingTest klasse worden verschillende scenario's getest waarin de applicatie moet controleren of er voldoende resources of population beschikbaar zijn om een actie uit te voeren, zoals het upgraden van een gebouw. Hier wordt Statement Coverage op toegepast, waarbij ervoor gezorgd wordt dat de uitkomsten van een beslissingspunt wordt getest.

### Blackbox Testing Toepassingen: Table Testing bij het Registratieproces: 
Table Testing is bijzonder nuttig voor het valideren van het gedrag van systemen gebaseerd op verschillende combinaties van inputs. Bij het registratieproces van de Pint and Pillage website is deze methode toegepast om te verzekeren dat alle mogelijke scenario's correct worden afgehandeld.
Hieronder een voorbeeld van een Table Test voor het registratieproces:


#### Table Test Registratieproces:

| Gebruikersnaam | Email          | Wachtwoord      | Herhaal Wachtwoord | Verwachte Reactie                        |
|----------------|----------------|-----------------|--------------------|------------------------------------------|
| testuser       | -              | Password123!    | Password123!       | Foutmelding: 'Email is required'         |
| -              | user@mail.com | Password123! | Password123!       | Foutmelding: 'Username is required'      |
| testuser       | user@mail.com | -             | -                  | Foutmelding: 'Password is required'     |
| testuser       | user@mail.com | Short          | Short              | Foutmelding: 'Password must have at least' |
| testuser      | user@mail.com | Password123!  | -                  | Foutmelding: 'Password confirmation is required' |
| testuser | user@mail.com | Password123!  | Drowssap23!!      | Foutmelding: "The passwords don't match" |
| testuser       | user@mail.com | Password123!  | Password123!       | Success: 'Account successfully created, please login' |

#### Table Test Loginproces:

| Email          | Wachtwoord      | Verwachte Reactie      |
|----------------|-----------------|------------------------|
| foobar@mail.com | Foobar123!     | Foutmelding: 'Invalid credentials'       |
| test1@mail.com  | WrongPassword123! | Foutmelding: 'Invalid credentials'       |
| test1@mail.com  | SecureTest123! |  Success: Logged in                       |

# Test Driven Development (TDD)
In de bijgevoegde bestanden is de door mij gemaakte video te zien, waarin ik een voorbeeld geef van Test Driven Development op basis van de casus over het implenteren van een nieuw Trading Post gebouw in de Pint and Pillage codebase.

## Review TDD Lucas Philippi
De video van Lucas Philippi is een goed voorbeeld van hoe TDD correct wordt toegepast.
Ik zie weinig overtredingen en ik vind dat hij het erg goed gedaan heeft.

1. Write a failing test (0:00 - 1:30): 
Lucas begint met het schrijven van een test die faalt. Hij doet slechts het minimale om de test te laten runnen, namelijk de test aanmaken met de instantie check en de TradingPost classe aanmaken die nog niet `Building` extend. 
Daarna voert hij de test uit en ziet dat deze faalt, wat de verwachte uitkomst is.

2. Write the minimum code to pass the test (1:30 - 2:00):
Lucas extend de TradingPost klasse met `Building` en voert de test opnieuw uit. Wel voegt hij hier alvast een lege override functie `updateBuilding` aan toe wat een TDD overtreding is want hij moest slechts genoeg code schrijven zodat de test slaagt. Qua functionaliteit wordt er echter niets toegevoegd met de updateBuil. 
De test slaagt en we kunnen door naar de volgende stap.

3. All tests succeed, Refactor the code (2:00 - 2:15):
Lucas voert geen refactoring uit, wat in dit geval ook niet nodig is. De code is al schoon en leesbaar.

4. Iterate, write a failing test (2:15 - 3:15):
Lucas herhaalt het proces voor de volgende test. Hij schrijft een test `shouldRequireResourcesWhenBuilding()` zonder logica toe te voegen en verwacht dat deze faalt.

5. Run the tests (3:15 - 3:30):
De test faalt zoals verwacht.

6. Write the minimum code to pass the test (3:30 - 4:30):
Lucas voegt de constructor toe aan de TradingPost en zet de resourcesRequired op de jusite waarde. De test slaagt.

7. All tests succeed (4:30 - 4:45):
Hier maakt Lucas een overtreding door niet alle testen te runnen. Hij verondersteld dat de testen slagen en gaat door naar de volgende stap.

8. Refactor de test (4:45 - 5:00):
Lucas refactored de test code, hij zet de Tradingpost in de BeforeEach.

9. Run all tests (5:00 - 5:15):
Lucas runt alle testen en ziet dat ze slagen. Bij 9, 10 en 11 splits hij het refactoren van de code en het refactoren van de testen op, wat erg netjes is.

10. Refactor de code: (5:15 - 6:00):
Lucas voegt de functie setResourcesRequired toe aan de TradingPost haalt de code uit de constructor en zet deze in de functie. Hij runt de testen en ziet dat ze nog steeds slagen.

11. Iterate, write new test (6:00 - 6:45):
Lucas schrijft de test `shouldTakeTimeToBuild()` en verwacht dat deze faalt.

12. Run the tests (6:45 - 7:00):
De test faalt zoals verwacht.

13. Write the minimum code to pass the test (7:00 - 7:45):
Lucas voegt setConstructionTime toe aan de TradingPost constructor en zet deze op de juiste waarde. De test slaagt.

14. All tests succeed (7:45 - 8:00):
Lucas checkt of alle testen slagen. En dat doen ze.

15. Refactor the code (8:00 - 8:15):
Lucas ziet in de UML dat de TradingPost ook bij updateBuilding gedaan moet worden en voegt hetgeen dat in de constructor zit toe aan de `@Override public void updateBuliding()` en roept update building aan in de constructor.

16. Run all tests (8:15 - 8:30):
Lucas runt alle testen en ziet dat ze slagen. Hij is klaar met het demonstreren van TDD.

### Conclusie TDD Review
Lucas heeft een goede demonstratie gegeven van TDD. Hij heeft de stappen correct gevolgd en de testen goed opgezet. Er zijn enkele kleine overtredingen, zoals het toevoegen van extra code in de minimum code om de test te laten slagen en het niet runnen van alle testen na elke iteratie. Maar over het algemeen heeft hij het goed gedaan en een goed voorbeeld gegeven van hoe TDD werkt.

