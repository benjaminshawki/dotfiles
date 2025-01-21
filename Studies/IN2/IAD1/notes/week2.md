---

Algoritmen & Datastructuren 1 (iad1) – Opdrachten Week 2
NB: Graag alle programmeer opdrachten van iad1 uitvoeren in Java of Python
Quicksort
Opdracht 1

    a. _Leg kort in je eigen woorden uit hoe het Quicksort algoritme werkt._

Het quicksort algoritme werkt door een pivot uit te kiezen in een lijst met getallen.
Het eerste getal van de pivot wordt gekozen, dit is meestal het laatste, het eerste of een willekeurig element in de lijst, deze wordt vervolgens in het midden geplaatst wat betekend dat het linker deel lagere waardes dan de pivot bevat en het rechter deel hogere waardes bevat dan de pivot.
Vervolgens wordt het algoritme recursief toegepast op de linker en rechter deel van de pivot totdat de lijst gesorteerd is.

    b. Leg uit wat een pivot is. 

Een pivot is een element in een lijst die wordt gekozen om de lijst te verdelen in twee delen, een linker deel met lagere waardes dan de pivot en een rechter deel met hogere waardes dan de pivot.

    c. Maakt het uit welk getal je kiest als pivot? Waarom wel of niet?

Ja de keuze van je getal als pivot heeft invoed omdat wanneer je een getal kiest dat al gesorteerd is, bijvoorbeeld het kleinste of grootste getal, dan zal het algoritme richting de worst case scenario gaan en zal het algoritme O(n^2) tijd kosten.
Als je een pivot kiest die in het midden van de lijst ligt dan zal het algoritme O(n log n) tijd kosten.

    d. Laat zien hoe je de getallen 2, 9, 8, 4, 3, 6, 7, 5 sorteert met behulp van het Quicksort algoritme.

{ 2, 9, 8, 4, 3, 6, 7, 5 } 

Kies een element uit als pivot bvb de laatse.

{ 2, 9, 8, 4, 3, 6, 7, |5| } 

Vervolgens wordt de lijst opnieuw opgebouwd met links getallen kleiner en recht getallen groter dan de pivot.

{ 2, 4, 3, 5, 9, 8, 6, 7 }

Hierna wordt dit recursief gedaan op de linker en rechter kant

Er wordt weer een pivot gekozen en wordt opdezelfde mannier gesorteerd

{ 2, 4, |3|,    5,    9, 8, 6, |7| }

{ 2, 3 , 4, 5 , 6, 7, 9, 8 }

{ 2, 3 , 4, 5 , 6, 7, 9, 8 }







    e. Leg uit wat de term in-place sorteren inhoud.
    f. Wat is de worst-case tijdscomplexiteit van Quicksort? En de best case? En de average case? Waar hangt dit vanaf?
    g. Laat zien hoe je de getallen 6, 5, 4, 3, 2, 1 sorteert met Quicksort. Kies steeds het laatste getal als pivot.
    h. Laat zien hoe je de getallen 5, 9, 12, 1, 4, 10, 6 sorteert met Quicksort. Kies steeds het laatste getal als pivot.


Opdracht 2
Implementeer het Quicksort algoritme door de onderstaande methode  te gebruiken in Quicksort.java. Een deel van de code is al gegeven, het is aan jou om nu ook de methode partition() werkend te krijgen.

private void quickSort(int[] array, int low, int high) {
	    //Schrijf hier je eigen quicksort implementatie
}


Opdracht 3
Schrijf minimaal 5 unit tests die verschillende scenario’s die het door jou geïmplementeerde Quicksort algoritme testen.

Denk bij verschillende scenario’s bijvoorbeeld aan: lege lijst, lijst met 1 element, 2 elementen, veel elementen, lijst die wel / niet al gesorteerd is, etc.

(In het 2e jaar bij IPRO2 heb je geleerd hoe unit testen werkt) 




Heapsort
Opdracht 4

    a. Leg kort uit hoe Heapsort werkt.

Heapsort is een algoritme dat een binary heap maakt om elementen te sorteren. Heapsort kan gedaan worden via een min-heap of max-heap. Het grootste of kleinste element wordt bovenaan de tree



$$
\begin{tikzpicture}[level/.style={sibling distance=60mm/#1}]
\node [circle,draw] (z){1}
  child {node [circle,draw] (a) {2}}
  child {node [circle,draw] (b) {3}};
\end{tikzpicture}
$$


    b. Sorteer de volgende getallen met Heapsort: 13, 9, 6, 8, 7, 3, 5, 2, 4, 1
Begin met het tekenen van de Heap (getallen representeren al een Heap)
    c. Sorteer de volgende getallen met Heapsort: 100, 40, 50, 10, 25, 30, 20
    d. Sorteer de volgende getallen met Heapsort: 1, 3, 2, 4, 5, 7
Dit is een min-heap, dus nu sorteer je van groot naar klein ipv klein naar groot.

    e. Geef minimaal 1 voordeel en 1 nadeel aan sorteeralgoritme Heapsort.
    f. Welk algoritme zou je liever zelf gebruiken? Selection Sort, Quicksort of Heapsort? Leg kort uit waarom je deze keuze maakt.
    g. Heeft Quicksort of Heapsort een slechtere space complexity? Of is de space complexity gelijk? Licht je antwoord toe.

Opdracht 5
    a. Maak een eigen implementatie van het Heapsort algoritme.
Tip: https://www.edureka.co/blog/binary-heap-in-java/#code
    b. Maak minimaal 5 unit tests en test hiermee je implementatie.




