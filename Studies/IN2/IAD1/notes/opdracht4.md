**[Algoritmen & Datastructuren 1 (iad1) -- Opdrachten Week
4]{.underline}**

## Opdracht 1

a.  Leg uit wat het verschil is tussen een boom en een binaire boom.

Het verschil tussen en boom een en binaire boom is dat in een binaire boom elke node maximaal 2 child elementen heeft.

b.  Leg uit wat het verschil is tussen een binaire boom en een binaire
    zoekboom.

Het verschil tussen een boom en een binaire boom is dat in een binaire boom de linker elementen kleiner zijn dan de parent en de rechter elementen groter zijn dan de parent. In een boom is dit niet het geval.

c.  Leg uit wat het verschil is tussen een binaire zoekboom en een
    gebalanceerde zoekboom.

In een gebalanceerde zoekboom is het verchil van diepte tussen een node's child elementen maximaal 1. Bij een binaire zoekboom hoeft dit niet perse.

d.  Leg uit wat het verschil is tussen een Heap en een AVL tree. Hoe kun
    je ze uit elkaar houden?

Een heap is een complete (of bijna complete) binaire boom waarbij de parent altijd groter is dan de child elementen. Een AVL tree is een gebalanceerde zoekboom waarbij het verschil van diepte tussen een node's child elementen maximaal 1 is.


## Opdracht 2

a.  Wat is de worst-case tijdscomplexiteit (Big O) van zoeken in een
    AVL-tree?

O(log(n))

b.  Wat is de worst-case tijdscomplexiteit van een element toevoegen in
    een AVL-tree?

O(log(n))

c.  Welke soorten rotaties zijn er in een AVL tree? Geef ook van elke
    rotatie een voorbeeld (tekening).

Er zijn 4 soorten rotaties in een AVL tree. Dit zijn de left-rotation, right-rotation, left-right-rotation en right-left-rotation.

d.  Wanneer is een AVL tree in balans? Leg uit in je eigen woorden.

Wanneer de diepte van de linker en rechter child elementen van een node maximaal 1 verschillen is de AVL tree in balans.

e.  Kun je ook een formule geven?

De formule is als volgt: |hL - hR| <= 1

## Opdracht 3

a.  Teken de AVL boom die ontstaat, als je de getallen 2, 6, 4, na
    elkaar toevoegt.

b.  Teken de boom die ontstaat, wanneer je volgende getallen
    achtereenvolgens aan een AVL-boom toevoegt. Teken minimaal de
    tussenliggende bomen nadat het derde, zesde, achtste en negende
    getal zijn toegevoegd. Deze getallen zijn dikgedrukt. De getallen
    zijn: 8, 6, **7**, 1, 2, **3**, 10, **11**, **12**

c.  Herhaal de bovenstaande opdracht met de getallen: 1, 2, **3**, 6, 5,
    **4**, 8, 10, **9**, **11**

d.  Herhaal de bovenstaande opdracht met de getallen: 9, 7, **3**, 2,
    **4**, 1, **8**, 14, 12, 11

## Opdracht 4

a.  Maak een ontwerp voor je eigen AVLTree klasse in Java. Denk aan het
    volgende:

    1.  Hoe zou je een binaire boom programmeren? Welke klassen en
        methodes zijn dan handig? Laat zien in een eerste
        klassendiagram.

    2.  Wat moet je veranderen om er een AVLTree van te maken? Heb je
        dan nieuwe klassen nodig, of niet? En welke dan?

    3.  Welke methodes heb je nodig bij een AVLTree? Laat zien in een
        nieuw klassendiagram.

b.  Als je wilt, kun je proberen om de AVL tree nu zelf uit te
    programmeren. Je kunt ook doorgaan naar de volgende opdracht .

c.  Ga naar <https://www.geeksforgeeks.org/avl-tree-set-1-insertion/> en
    scroll naar beneden tot je bij de code aankomt. Kijk bij de code in
    Java of Python (of kies een taal waar je het handigste mee bent) en
    probeer te begrijpen hoe het werkt.

d.  Klopt je ontwerp een beetje? Wat is er hetzelfde? Waar zitten de
    verschillen?

Tip: Ga naar
<https://www.cs.usfca.edu/~galles/visualization/AVLtree.html> en kijk
wat de juiste uitkomsten zijn. Licht toe of de visualisatietool van
internet overeenkomt met jouw uitwerkingen van opdracht 3.
