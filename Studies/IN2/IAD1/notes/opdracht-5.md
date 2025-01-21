**[Algoritmen & Datastructuren 1 (iad1) -- Opdrachten Week
5]{.underline}**

## Opdracht 1

a.  Wat is het verschil tussen de datastructuren graaf en boom?
Eeen boom is een soort graaf, een boom mag geen losse elementen bevatten en er mogen ook geen lussen voorkomen.

b.  Maak van de onderstaande twee adjacency matrix een graaf:

  -----------------------------------------------------------------------
              **0**       **1**       **2**       **3**       **4**
  ----------- ----------- ----------- ----------- ----------- -----------
  **0**                   5           6           7           8

  **1**       5                                               

  **2**       6                                   4           

  **3**       7                       4                       9

  **4**       8                                   9           
  -----------------------------------------------------------------------

> **\
> **

De volgende deelvragen gaan over deze Graaf:

> ![Dijkstra Algorithm \| Example \| Time Complexity \| Gate
> Vidyalay](media/image1.png){width="3.094303368328959in"
> height="1.7395833333333333in"}

c.  Maak van de bovenstaande graaf een adjacency matrix.
|x| A    | B    | C    | D    | E    | S |
|---------------- | --------------- | --------------- | --------------- | --------------- | --------------- | --------------- |
|A| |2|2|1| | |
|B| | | |2| | |
|C| | | |3|1| |
|D| | | | |2| |
|E| | | | | | |
|S|1|5| | | | |

d.  Maak van de bovenstaande graaf een adjacency list.

A: (B,2), (C,2), (D,1)
B: (D,2)
C: (D,3), (E,1)
D: (E,2)
E:
S: (A,1), (B,5)

e.  Maak van de bovenstaande graaf een edge list.

(A, B, 2), (A, C, 2), (A, D, 1), (B, D, 2), (C, D, 3), (C, E, 1), (D, E, 2), (S, A, 1), (S, B, 5)



## Opdracht 2

a.  Beschrijf in eigen woorden hoe het Dept First Search algoritme
    werkt.

Het depth first search algoritme werkt door een startknoop te kiezen en vanuit deze knoop een pad te volgen tot er geen nieuwe knopen meer zijn om te bezoeken.
Wanneer er geen nieuwe knopen meer zijn om te bezoeken wordt er teruggegaan naar de vorige knoop en wordt er gekeken of er nog andere knopen zijn die bezocht kunnen worden.
Dit proces wordt herhaald totdat alle knopen bezocht zijn.

b.  Wat is de worst-case complexiteit van Dept First Search? Wat
    betekent deze complexiteit?

De worst-case complexiteit van DFS is O(V+E), waarbij V het aantal knopen is en E het aantal verbindingen.

c.  Wanneer zou je dit algoritme willen gebruiken? Noem minimaal 1
    voorbeeld.

DFS zou je willen gebruiken wanneer je een pad wilt vinden in een graaf.
Een voorbeeld hiervan is het vinden van een route in een doolhof.

d.  Beschrijf in eigen woorden hoe het Breadth First Search algoritme
    werkt.

Het breadth first search algoritme werkt door een startknoop te kiezen en vanuit deze knoop alle directe buren te bezoeken.
Vervolgens worden de buren van deze buren (die nog niet bezocht zijn) bezocht.
Dit proces wordt herhaald totdat alle knopen bezocht zijn.

e.  Wat is de worst-case complexiteit van Breadth First Search? Wat
    betekent deze complexiteit?

De worst-case complexiteit van BFS is O(V+E), waarbij V het aantal knopen is en E het aantal verbindingen.

f.  Wanneer zou je dit algoritme willen gebruiken? Noem minimaal 1
    voorbeeld.

BFS zou je willen gebruiken wanneer je het kortste pad wilt vinden in een graaf. Een voorbeeld hiervan is het vinden van de kortste route van A naar B.

g.  Welk algoritme zou sneller zijn, DFS of BFS? Of hangt dat van de
    graaf af?

BFS is sneller dan DFS wanneer je het kortste pad wilt vinden in een graaf.
DFS is sneller dan BFS wanneer je een pad wilt vinden in een graaf.

Dijkstra's wordt altijd breath first

h.  Welk van de twee algoritmes heeft jouw voorkeur en waarom?

-

## Opdracht 3

We gaan verder met deze Graaf:

![](media/image2.png){width="3.181813210848644in"
height="1.8452898075240596in"}

a.  Schrijf op in welke volgorde het Depth First Search algoritme deze
    graaf doorloopt. Start bij knoop 1.

1-2-3-4-3-5-6-5-7

b.  Schrijf op in welke volgorde het Breadth First Search algoritme deze
    graaf doorloopt. Start bij knoop 1.

1-(2-4)-3-5-(6-7)

## Opdracht 4

a.  Beschrijf in je eigen woorden hoe Dijkstra's algoritme werkt.

b.  Wat is de complexiteit van dit algoritme?

c.  Kun je Dijkstra's algoritme gebruiken voor elke Graaf? Zo niet,
    wanneer niet?

d.  Pas Dijkstra's algoritme toe op deze Graaf. Je wilt het kortste pad
    weten van de meest linker knoop naar de meest rechter knoop.\
    Wat is de kortste route van "S" naar "E"? Laat ook de tussenstappen
    zien.![Dijkstra Algorithm \| Example \| Time Complexity \| Gate
    Vidyalay](media/image1.png){width="3.094303368328959in"
    height="1.7395833333333333in"}

e.  Pas Dijkstra's algoritme toe op deze Graaf. Je wilt het kortste pad
    weten van de meest linker knoop naar de meest rechter knoop.\
    Wat is de kortste route van "A" naar "E"? Laat ook de tussenstappen
    zien.![Dijkstra\'s Algorithm - Shortest paths with Dijkstra\'s
    Algorithm](media/image3.png){width="3.4166666666666665in"
    height="2.109792213473316in"}

f.  Kun je BFS en DFS ook toepassen op de Graaf hierboven? Waarom wel of
    niet?

g.  Pas Dijkstra's algoritme toe op deze Graaf. Je wilt het kortste pad
    weten van de meest linker knoop naar de meest rechter knoop.\
    Wat is de kortste route van "0" naar "4"?

![Dijsktra\'s algorithm](media/image4.jpeg){width="3.7083333333333335in"
height="1.7295166229221348in"}

## Extra Opdracht

Eerder hebben we gekeken naar het kortste-pad probleem in een graaf. Met
Dijkstra's algoritme kun je hier een oplossing voor vinden.

Een probleem dat hier op lijkt is het langste-pad probleem: Zoek het
langste pad in een graaf tussen twee knopen (bv van A naar B), zonder
dat je knopen dubbel bezoekt.

a.  Hoe zou je dit probleem kunnen oplossen?

b.  Hoe snel is je oplossing? Wat is de worst-case tijdcomplexiteit van
    je oplossing?

c.  Zijn het kortste-pad probleem en het langste-pad probleem even
    makkelijk? Zo niet, welk probleem is dan moeilijker om op te lossen?
