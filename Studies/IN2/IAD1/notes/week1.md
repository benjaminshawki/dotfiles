Recursieve functie de stopcondie komt altijd voor de recursieve functie
    - Base case: 
        - Als de lijst leeg is, return 0
    - Recursive case:
        - Return 1 + de lengte van de lijst zonder het eerste element
        - return 1 + len(lst[1:])
        - return 1 + len(lst[1:]) + len(lst[1:])
        - return 1 + len(lst[1:]) + len(lst[1:]) + len(lst[1:])
        - return 1 + len(lst[1:]) + len(lst[1:]) + len(lst[1:]) + len(lst[1:])
        - return 1 + len(lst[1:]) + len(lst[1:]) + len(lst[1:]) + len(lst[1:]) + len(lst[1:])
        - return 1


## Bubbelsort
Start {1, 5, 3, 2, 9} 

{1, 5, |3, 2, 9} 
{1, 3, 5, 2, 9} 

{1, 3, 5, |2, 9} 
{1, 3, 2, 5, 9} 

{1, 3, |2, 5, 9} 
{1, 2, 3, 5, 9} 


{1, 2, 3, 5, |9} 

## Opdracchten

### Opdracht 1
- a. Leg in je eigen woorden uit wat de term Big-O inhoudt.

    Big O wordt gebruikte om de snelheids factor (tijdscomplexiteit) van een algoritme weer te geven.


- b. Waar gebruik je de Big-O notatie voor?

   Big O notatie wordt gebruikt om de snelheidsfacotr van een algoritme te meten, dit is een standaard die is opgezet om snel de snelheid te delen met mede informatici


- c. Wat betekende de termen slechtste, beste en gemiddelde geval als we het hebben over de Big-O notatie?
     
     De slechte betekend de langete looptijd (het meest aantal stappen) die een algoritme moet nemen om tot een eindoplossing te komen.
     De beste betekend de kortste looptijd (het minsta aantal stappen) die een algoritme moet nemen om tot een eindoplossing te komen.
     De gemiddelde is de gemiddelde looptijd van de slechtste en de beste.

- d. Wat is de tijdscomplexiteit in het slechtste en beste geval van de onderstaande code:

```java
	int i, j, tijdelijk;     
	for (j = 0; j < invoer.length; j++) {         
		for (i = 1; i < invoer.length - j; i++) {             
			if (invoer[i-1] > invoer[i]) { 
				tijdelijk = invoer[i]; 
				invoer[i] = invoer[i-1]; 
				invoer[i-1] = tijdelijk;
			}
        	}
	}
```

De tijdscomplexiteit van de bovenstaande code is `O(N^2)`, omdat het algoritme voor rij aan invoer 2 stappen doet.

### Opdracht 2

In deze opdracht maak je eerst een klasse “BigO” aan, maak vervolgens voor elke opdracht een nieuwe methode. Voer deze opdracht uit in Java of Python. 


    a. Schrijf zelf een stukje code dat complexiteit O(1) heeft.
    b. Schrijf zelf een stukje code dat complexiteit O(n) heeft.
    c. Schrijf zelf een stukje code dat complexiteit O(n2) heeft.
    d. Schrijf zelf een stukje code dat complexiteit O(n3) heeft.
    e. Schrijf zelf een stukje code dat complexiteit O(log n) heeft.
    f. Schrijf zelf een recursief stukje code dat complexiteit O(n) heeft.
    g. Schrijf zelf een recursief stukje code dat complexiteit O(n2) heeft.

**Zie week1.java**


### Opdracht 3

    a. Leg kort in je eigen woorden uit hoe het Selection Sort algoritme werkt.
    b. Wat is de complexiteit van dit algoritme? 

Bij een vraag naar complexiteit kun uitgaan van de tijdscomplexiteit, we zoeken dan de worst-case performance van het algoritme.

    c. Geef minimaal 1 voordeel en 1 nadeel van dit algoritme.
    d. Laat zien hoe je de getallen 2, 9, 8, 4, 3, 6, 7, 5 sorteert met behulp van het Selection Sort algoritme.
    e. Sorteer nu de volgende getallen met Selection Sort: 6, 1, 4, 12, 10, 7, 9, 2


Opdracht 4
    a. Maak een eigen implementatie van het Selection Sort algoritme.
    b. Maak minimaal 3 unit tests en test hiermee je implementatie.
    c. Hoe zou je de performance van dit algoritme kunnen meten? Hoe pak je dat aan in je code?
    d. Implementeer jouw meetmethode en meet hoe snel het sorteeralgoritme is.
Kijk vooral naar het gedrag als de input groeit van 1, 10, 100, 1000, etc getallen.

Opdracht 5
De Fibonaccireeks is een bekende reeks van getallen. De eerste getallen in de reeks zijn 0, 1, 1, 2, 3, 5, 8. Zoals je ziet is een nieuw getal in de reeks steeds de som van de twee voorgaande getallen in de reeks. Hieronder staat code waarmee je een getal in de Fibonaccireeks kan bereken door de locatie in de reeks (index) mee te geven aan de methode.
public long fib(int i) {
	if (i < 2) {
	  return i;
 }
	return fib(i - 1) + fib(i - 2);
}
    a. Wat is de worst-case tijdcomplexiteit van de bovenstaande code? Geef de Big-O notatie.
    b. Meet hoe veel tijd het kost om de bovenstaande code uit te voeren met als input 5, 10, 20, 40 en 80. Noteer je resultaten. Beschrijf wat deze meetresultaten zeggen.
    c. Hoe zou je bovenstaande code kunnen aanpassen zodat de Big-O notatie efficiënter wordt? Wat is de nieuwe Big-O notatie?

