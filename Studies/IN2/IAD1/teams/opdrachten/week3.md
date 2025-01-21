**[Algoritmen & Datastructuren 1 (iad1) -- Opdrachten Week
3]{.underline}**

## Opdracht 1

a.  Bedenk 5 toepassingen op waarin je een hash table zou kunnen
    gebruiken.
    
   1. Telefoonboek
   2. Postcode register
   3. Medewerkernummers
   4. Vluchtnummers
   5. Caching
   6. productnummers
   7. DNS

b.  Wanneer zou je een hash table juist **niet** willen gebruiken?

    Wanneer je een kleine dataset hebt, wanneer je key's gesorteerd moeten zijn, wanneer je specifiek de eerste en het laatste element nodig heb.

c.  Vergelijk de snelheid van lineair zoeken en binair zoeken met die
    van met een Hashtable. Wat is de worst-case zoektijd (Big O) voor
    deze manieren van opzoeken?

    Linear O(n)
    
    Binary O(log n)

    Hashtable O(1)

d.  Vergelijk nu deze zoektijden in de praktijk. Beschrijf je
    bevindingen voor 100, 1000, 10.000 en 100.000 random elementen op.

    

e.  Hoe bereken je hoe vol een hash table is?
   
Je berekend wat de load factor 

f.  Wat doe je als je hash table vol is?

    Er kan gebruik gemaakt worden van seperate chainging of linear probing.
    Of grotere tabel, en rehashen

## Opdracht 2

In deze opdracht ga je handmatig een hash table vullen. Voeg de volgende
\<key, value\> paren één voor één toe aan een hash table met 10 plekken:

\<22, appel\>, \<10, banaan\>, \<3, kers\>, \<2, druif\>, \<24, peer\>,
\<13, ananas\>

De hash functie zelf is simpel: f(x) = x modulo 10.

Tip: teken eerst de lege hash table.


a.  Gebruik een hash table waarin linear probing wordt toegepast

| Key   | Value |
|--------------- | --------------- |
| 10  | banaan  |
|   |   |
| 22  | appel |
| 3  | kers  |
| 2  | druif  |
| 24  | peer  |
| 13  | ananas  |
|   |   |
|   |   |
|   |   |

b.  Hoeveel collisions zijn er?

5

c.  Gebruik een hash table waarin separate chaining wordt toegepast

| Key   | Value    | .
|--------------- | --------------- | --------------- |
| 10  | banaan  |
|   |   |
| 22, 2  | appel | druif |
| 3, 13  | kers  | ananas |
| 24  | peer |
|   |   |
|   |   |
|   |   |
|   |   |
|   |   |

d.  Hoeveel collisions zijn er?

2

e.  Wat is nu de load factor van je hash table?
0.6

## Opdracht 3

a.  Maak een klasse Auto met de attributen merk, type, kenteken.

b.  Voeg aan de klasse Auto de methode public int hashCode() toe en
    implementeer de meest slechte implementatie toe.

c.  Test nu je code met een hash table met 100, 1000, 10.000 en 100.0000
    Auto's en schrijf je bevindingen op.

d.  Verbeter je methode en test je code opnieuw met 100, 1000, 10.000 en
    100.0000 elementen en schrijf je bevindingen op.

e.  Hoeveel sneller is je code geworden?

## Opdracht 4

a.  In Java heb je zowel een HashTable als een HashMap. Zoek uit wat
    hier de verschillen tussen zijn.

b.  Welk van de twee lijkt het meest op de Hash table die je in de les
    hebt geleerd?

c.  Welk van de twee zou je zelf het liefst gebruiken?
