---
link-citations: true
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
  \fancyhead[L]{\leftmark}
  \fancyhead[R]{}
  \fancyfoot[L]{Benjamin Shawki | s1096865}
  \fancyfoot[R]{Concepten in Programmeertalen}
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
date: April 2024
output: 
  pdf_document:
    template: template.tex
lang: nl
figureTitle: "Figuur"
figPrefix: "figuur"
secPrefix: ""
bibliography: ref.bib
csl: apa.csl
---

\begin{center}
\Huge Concepten in Programmeertalen
\end{center}

\vfill

\begin{center}
\huge ICPT Verslag
\end{center}

\begin{center}
\LARGE Benjamin Shawki
\end{center}

\begin{center}
\Large April - Juni 2024
\end{center}

\vfill

\begin{center}
Versie 1.0 definitief - 24 Juni 2024
\end{center}

\vfill

\newpage

\tableofcontents

\newpage
# Inleiding {- .unnumbered}
In dit verslag worden de concepten in programmeertalen besproken die zijn behandeld in de module ICPT. Dit verslag is bedoeld om een overzicht te geven van de belangrijkste concepten in programmeertalen.
De concepten die in dit verslag worden besproken zijn onder andere datatypes, compiler en toolchain, memory management, en subprogramma's. Deze concepten worden in de context van verschillende programmeertalen behandeld, namelijk Fortran, C, C++, en C#, en go.

Dit gehele verslag is gebaseerd op de stof van het vak ICPT, de bijbehorende literatuur [@sebesta2019] en de door mij opgedane kennis tijdens de colleges en zelfstudie.

\newpage
# Historie
De verandering van datatypes in een historische context is een interessant onderwerp, omdat dit een belangrijk onderdeel in de evolutie van programmeertalen weerspiegelt. Deze veranderingen zijn vaak het gevolg van nieuwe technologische ontwikkelingen, zoals de introductie van nieuwe hardware, nieuwe programmeerparadigma's, of nieuwe toepassingen van programmeertalen. In dit hoofdstuk zullen we de historie van de ontwikkeling van datatypes in programmeertalen sinds 1980 bespreken. 

## Inleiding Data Types
In de eerste jaren van de computer geschiedenis was men vooral bezig met de logica van het programmeren. De eerste programmeurs waren vaak wiskundigen en logici die de computer gebruikten om berekeningen te maken. De eerste programmeertalen waren dan ook vooral gericht op het maken van berekeningen en het uitvoeren van logische operaties.

Al snel merkte men op dat het bij het programmeren voornamelijk ging over data, en niet perse over de logica van hoe een computer werkt.
Een belangrijke factor bij het manipuleren van data is het gemak voor een programmeur om deze data te verwerken voor scenario's in het echte leven. Een belangrijk aspect van een programmeer taal is dus ook het gemak van het werken met data.

Een data type is een collectie van waarden die een programmeur kan gebruiken om data te representeren. Een data type kan bijvoorbeeld een getal zijn, een tekst, een datum, een lijst van getallen, een linked list, een boom structuur, of een door de gebruiker gedefinieerde structuur.

## Kort woord over pre-1980
Voordat we de ontwikkelingen sinds 1980 bespreken, is het belangrijk om te begrijpen hoe data types in de jaren daarvoor werden behandeld. In vroege programmeertalen zoals de voorgangers van Fortran 90, moesten programmeurs complexe datastructuren zoals linked lists en binaire bomen zelf implementeren met basis structuren zoals arrays en pointers. Deze benadering was arbeidsintensief en foutgevoelig, maar legde de basis voor latere innovaties. 
Ook kijken we naast Fortran naar verschillende versies van C en C++, omdat deze talen een belangrijke rol hebben gespeeld in de ontwikkeling van data types.

## Fortran
Fortran, ontwikkeld in de jaren 50, was een van de eerste programmeertalen die werd ontworpen voor wetenschappelijke en technische berekeningen. Het evolueerde door de jaren heen om beter aan de behoeften van programmeurs te voldoen, vooral op het gebied van data types.

### Fortran 77
Fortran IV werd vervangen door Fortran 77, welke de standaard werd in 1978 [@ansi1978]. Fortran 77 introduceerde `complex numbers`, ondersteunde `Character data types`, en verbeterde `logical data types`. `complex numbers` bestaan uit een echte en een denkbeeldige componenten. Dit maakte het mogelijk om complexere wiskundige berekeningen uit te voeren, vooral op het gebied van wetenschappelijke en technische toepassingen. `character data types` maakten het eenvoudiger om tekst en karakters te verwerken, terwijl `logical data types` het schrijven van logische beslissingen en condities vereenvoudigde.

Daarnaast werden er verschillende nieuwe functies en subroutines geïntroduceerd die het werken met deze data types eenvoudiger maakten, zoals string manipulatie functies voor character en wiskundige functies voor complex.

### Fortran 90
Fortran 90 was drastisch anders dan zijn voorganger [@ansi1992]. Het introduceerde `dynamic arrays`, `records`, `pointers`, `modules`, en `recursive subroutines`. `Dynamic arrays` maakten het mogelijk om arrays van variabele lengte te maken, wat handig was voor het verwerken van datastructuren zoals linked lists en bomen, en `Records` maakten het mogelijk om complexe datastructuren te definiëren, zoals een structuur met verschillende velden. `Pointers` maakten het vervolgens mogelijk om naar deze datastructuren te verwijzen, wat handig was voor het maken van complexe datastructuren zoals bomen en grafen. `Modules` bracht de mogelijkheid om code te organiseren. Ook maakten `Recursive subroutines` het mogelijk om subroutines te maken die zichzelf aanroepen.

### Fortran 95, 2003
Elke nieuwe versie van Fortran heeft de taal verder verfijnd. Snel gezegd introduceerde Fortran 95 de Forall constructie [@iso1997], wat parallel programmeren vergemakkelijkte, Fortran 2003 voegde ondersteuning voor objectgeoriënteerd programmeren toe [@metcalf2004].

## C
Ook C heeft een belangrijke rol gespeeld in de ontwikkeling van datatypes. C werd in de jaren 70 ontwikkeld door Dennis Ritchie bij Bell Labs en is een van de meest invloedrijke programmeertalen aller tijden.

### C89
C89, werd gestandaardiseerd in 1990 [@ansi1990]. Het introduceerde de concepten van function prototypes, wat het mogelijk maakte om functies beter te definiëren en te controleren, en standard libraries, die een reeks gestandaardiseerde functies en subroutines introduceerden die in verschillende programma's konden worden gebruikt.

### C99
C99 bracht verbeteringen, zoals `inline functions`, `variable length arrays`, en nieuwe data types zoals `complex` en `boolean` [@iso1999]. 

### C11
C11 bracht verbeterde de taal door atomic operations, threading support, en enhanced unicode support toe te voegen [@iso201x]. Atomic operations en threading support maakten het eenvoudiger om concurrerende programma's te schrijven, terwijl enhanced unicode support het werken met internationale tekensets verbeterde.

## C++
C++ is een taal die verder bouwt op de fundamenten van C door het introduceren van `object-oriented` en `generic programming`.

### C++98
De eerste standaard van C++, gestandaardiseerd in 1998, introduceerde belangrijke concepten zoals `classes`, `inheritance`, `polymorphism` en `templates` [@iso1998]. Deze concepten maakten het mogelijk om complexe, herbruikbare en efficiënte softwarecomponenten te ontwikkelen.

### C++11
C++11 was een grote update die vele nieuwe functies introduceerde, waaronder `auto keyword`, `lambdas`, `nullptr`, `strongly-typed enums`, `rvalue references`, en `concurrency support` [@iso2013]. 

### C++14 en C++17
C++14 en C++17 brachten verdere verbetering en nieuwe functies zoals `generic lambdas`, `optional`, `variant` en `any`.

## Historische Ontwikkeling
De ontwikkeling van datatypes in programmeertalen sinds 1980 laat zien hoe programmeertalen zich hebben aangepast aan de veranderende behoeften van programmeurs en de technologische vooruitgang. Door de jaren heen hebben programmeertalen steeds meer geavanceerde datatypes en structuren geïntroduceerd om zo programmeurs te helpen code te schrijven die efficiënt, leesbaar en onderhoudbaar is.

\newpage
# Compiler en Toolchain (C)
In dit hoofdstuk duiken we dieper in op de werking van een compiler en de componenten van een toolchain in de context van C. Een compiler vertaalt broncode, geschreven in een high level taal zoals C, naar machinecode welke door een computer kan worden uitgevoerd. Deze vertaling gebeurt in verschillende fasen, elk verantwoordelijk voor een specifiek deel van het vertaalproces. Een typische compiler bestaat uit de volgende fasen:

1. Lexical Analysis
1. Syntax Analysis
1. Semantic Analysis
1. Intermediate Code Generation
1. Code Optimization
1. Code Generation

## Compiler {#sec:compiler}
![[@rao2018]](img/phases-of-a-compiler.png){width=60%}

### Lexical Analysis
In deze fase wordt de source code gelezen en omgezet naar een reeks tokens. Een token is een logische eenheid van de text, zoals een `keyword`, `identifier`, `operator`, of `literal`.
De lexical analyzer is verantwoordelijk voor het identificeren van deze tokens en het doorgeven van deze informatie aan de volgende fase, de syntax analyzer.

### Syntax Analysis
De `syntax analysis` stap is het hart van de compiler, dit omdat verschillende andere componenten inclusief de `semantic analysis` stap en de `intermediate code generator` gedreven zijn door de syntax analyzer.

### Semantic Analysis
De `semantic analysis` stap is verantwoordelijk voor het controleren van de betekenis van de code, waarbij de volgende controles worden uitgevoerd:

- **Type Checking**: De compiler controleert of de types van variabelen en expressies correct worden gebruikt.
- **Scope Checking**: De compiler controleert of variabelen correct worden gedeclareerd en gebruikt binnen hun scope.
- **Function Checking**: Controleert of de functies correct worden aangeroepen met het juiste aantal en type argumenten.

De compiler controleert bijvoorbeeld of variabelen correct worden gedeclareerd en gebruikt, of dat functies correct worden aangeroepen.

### Intermediate Code Generation
Na de `semantic analysis` stap wordt de code omgezet naar een tussenvorm, de `intermediate code`. Deze tussenvorm is een abstracte representatie van de broncode, die gemakkelijker te optimaliseren en te vertalen is naar machinecode.

### Code Optimization
De `code optimization` stap is verantwoordelijk voor het verbeteren van de prestaties van de code door het verwijderen van redundante code, het verminderen van de complexiteit van expressies, en het optimaliseren van geheugen gebruik.

### Code Generation
De `code generation` stap vertaalt dan de geoptimaliseerde code naar assembly code.

## Toolchain
Vervolgens gaan we verder de toolchain stappen in C doorlopen. In deze stappen zit ook de compiler stap, en hierbij worden de stappen eerder in dit hoofdstuk uitgevoerd. De stappen zijn:

1. Preprocessor
1. Compiler
1. Assembler
1. Linking

Ook te zien in [@fig:rao2018]

![[@rao2018]](img/language-processing-system.png){#fig:rao2018 width=60%}

Laten wij de volgende code door de toolchain volgen, te beginnen bij de source code [@icpt-c-factorial] in `factorial.c`:

```c
  for (i = 1; i <= which; ++i) {
    result *= i;
  }
```

### Preprocessing
Voordat we met de bovenstaande code verder kunnen gaan is het van belang dat we de preprocessor stap doorlopen. De preprocessor is verantwoordelijk voor het verwerken van preprocessor directives, zoals `#include` en `#define`. De preprocessor zal de code transformeren naar een vorm die de compiler kan verwerken.

We vervangen dus de `#include` directive met de inhoud van de file die geïncludeerd wordt. In dit geval is dat de `stdio.h` file, welke de standaard input/output functies bevat.
```c
  #include <stdio.h>
```

Daarnaast vervangen we de `#define` directive met de waarde die gedefinieerd is. In dit geval is dat de waarde van `ZERO` en `NEWLINE`.

```c
#define ZERO 0
#define NEWLINE "\n"
```

Om de preprocessor stap uit te voeren kunnen we bijvoorbeeld het volgende commando uitvoeren:

```sh
gcc -E factorial.c -o factorial.i
```

Hier wordt de GNU Compiler Collection [@gcc] gebruikt om de preprocessor stap uit te voeren. GCC compileert de code in `factorial.c` en schrijft de output naar `factorial.i`. De output van de preprocessor stap is de code waarin alle preprocessor directives zijn vervangen door de bijbehorende code. De inhoud van `studio.h` staat bijvoorbeeld op mijn systeem in `/usr/include/stdio.h`.

Ook de `printf(NEWLINE);` statement wordt vervangen door `printf("\n");` te zien helemaal onderaan in `factorial.i`.

De code die we volgen (de eerder gegeven `for loop`) is niet veranderd door de preprocessor stap, dus we kunnen verder gaan met de volgende stap.

### Compiling
In de compiler stap worden de eerder beschreven stappen in [@sec:compiler] [Compiler](#sec:compiler) uitgevoerd. De compiler vertaalt de broncode naar assembly code, welke vervolgens in de volgende stap [@sec:assembler] [Assembling](#sec:assembler) wordt omgezet naar machine code.

Om de compiler stap uit te voeren kunnen we bijvoorbeeld het volgende commando uitvoeren:

```sh
gcc -S factorial.i -o factorial.s
```

Hier wordt GCC gebruikt om de compiler stap uit te voeren. GCC compileert de code in `factorial.i` en schrijft de output naar `factorial.s`. De output van de compiler stap is de assembly code die de broncode vertegenwoordigt.

De eerder gegeven `for loop` wordt bijvoorbeeld vertaald naar de volgende assembly code:

```as
...
	jmp	.L2
.L3:
	movl	-12(%rbp), %eax
	cltq
	movq	-8(%rbp), %rdx
	imulq	%rdx, %rax
	movq	%rax, -8(%rbp)
	addl	$1, -12(%rbp)
.L2:
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jle	.L3
...
```

De assembly code is moeilijk te lezen en te begrijpen, maar het vertegenwoordigt de machinecode die door de computer kan worden uitgevoerd. De intructie `jmp .L2` bijvoorbeeld, springt naar het label `.L2`, wat het begin van de `for loop` representeert. De instructies `movl -12(%rbp), %eax` en `cmpl -20(%rbp), %eax`, vergelijken de waarde van `i` met de waarde van `which` en springt vervolgens met `jle .L3` [@x86-jle] naar het label `.L3` als `i` kleiner of gelijk is aan `which`.

### Assembling {#sec:assembler}
In de assembler stap wordt de assembly code omgezet naar machine code. De assembler vertaalt de assembly instructies naar de binaire instructies.

Om de assembler stap uit te voeren kunnen we bijvoorbeeld het volgende commando uitvoeren:

```sh
as factorial.s -o factorial.o
```

Om vervolgens de machine code te bekijken kunnen we objectdump gebruiken:

```sh
objdump -d factorial.o
```

Ook hier kunnen we onze for loop in terug vinden:

```as
  16:   eb 15                   jmp    2d <factorial+0x2d>
  18:   8b 45 f4                mov    -0xc(%rbp),%eax
  1b:   48 98                   cltq
  1d:   48 8b 55 f8             mov    -0x8(%rbp),%rdx
  21:   48 0f af c2             imul   %rdx,%rax
  25:   48 89 45 f8             mov    %rax,-0x8(%rbp)
  29:   83 45 f4 01             addl   $0x1,-0xc(%rbp)
  2d:   8b 45 f4                mov    -0xc(%rbp),%eax
  30:   3b 45 ec                cmp    -0x14(%rbp),%eax
  33:   7e e3                   jle    18 <factorial+0x18>
```

Hierin is de aanroep van de `for loop` te zien. De `jmp` instructie bijvoorbeeld, springt naar het adres `0x2d`, wat het begin van de `for loop` representeert. De `mov` instructie `mov -0xc(%rbp),%eax` laadt de waarde van `i` in het register `eax`, en de `cmp` instructie `cmp -0x14(%rbp),%eax` vergelijkt de waarde van `i` met de waarde van `which`.

### Linking
In de link stap worden verschillende object files en libraries samengevoegd tot één uitvoerbaar programma. De linker zorgt ervoor dat alle verwijzingen naar functies en variabelen correct worden gezet.

Om de linker stap uit te voeren doen we:
```sh
gcc factorial.o -o factorial
```

Hier wordt de object file `factorial.o` gelinkt tot een uitvoerbaar programma `factorial`. Dit programma kan vervolgens worden uitgevoerd om de faculteit van een getal te berekenen.

```sh 
$ ./factorial 29
Factorial of 29 = 11390785281054474240
```

## Toolchain in C samengevat
De toolchain in C bestaat uit verschillende stappen, waaronder de preprocessor, compiler, assembler, en linker. Elke stap heeft zijn eigen verantwoordelijkheden en helpt bij het vertalen van broncode naar een uitvoerbaar programma.

\newpage
# Memory Management (C)
Memory Managment is een belangrijk onderdeel van het programmeren in C. In dit hoofdstuk zullen we de verschillende aspecten hiervan in C bespreken, zoals de werking en doel van de stack en de heap, het verschil tussen de stack en de heap, en de functie, voor- en nadelen van static memory.

Om dit beter te kunnen begrijpen zullen we kijken naar een implementatie van zeeslag in C, en dit hoofdstuk wordt het volgende code fragment uit `battleships.c` [@icpt-c-battleship] bestudeert.
```c
void init_grid(Grid *grid) {
  grid->cells = calloc(GRID_SIZE, sizeof(char *));
  if (grid->cells == NULL) {
    fprintf(stderr, "Failed to allocate memory for grid cells.\n");
    exit(EXIT_FAILURE);
  }
  for (int i = 0; i < GRID_SIZE; ++i) {
    grid->cells[i] = calloc(GRID_SIZE, sizeof(char));
    if (grid->cells[i] == NULL) {
      fprintf(stderr, "Failed to allocate memory for grid->cells[%d].\n", i);
      exit(EXIT_FAILURE);
    }
  }
}
```

In C zijn er verschillende soorten geheugen.

- **Static Memory**: Variabelen die buiten een functie worden gedeclareerd, worden opgeslagen in `static memory`. Deze variabelen blijven bestaan gedurende de `lifetime` van een programma.
- **Automatic Memory**: Lokale variabelen die binnen een functie worden gedefinieerd, worden toegewezen op de stack en worden automatisch vrijgegeven wanneer de functie returns.
- **Dynamic Memory**: Dit wordt toegewezen tijdens de `runtime` van een programma. Dit type memory bevindt zich op de heap en vereist expliciete toewijzing en vrijgave.

## Werking en doel van de Stack 
De stack is een geheugen model dat wordt gebruikt om lokale variabelen en function calls op te slaan. Wanneer een functie wordt aangeroepen, wordt deze functie weliswaar op de "stapel" gelegd. Elke individuele onderdeel van de stack wordt ook wel een "frame" genoemd. Elke frame bevat de lokale variabelen van de functie, de return address, en de waarden van de registers. Wanneer de functie klaar is met uitvoeren, wordt het frame van de stack verwijderd. De stack is een LIFO (Last In First Out) datastructuur, wat betekent dat het laatste frame dat op de stack is geplaatst, als eerste wordt verwijderd.

Bij het code fragment `init_grid` in de for loop wordt bijvoorbeeld de variabele `i` op de stack geplaatst, omdat deze lokaal is voor de functie.

## Werking en doel van de Heap 
De heap is een model waarbij memory worden toegewezen en vrijgegeven tijdens de runtime van een programma met behulp van functies zoals `malloc`, `calloc`, en `free` in C. Dit type memory wordt gebruik voor het opslaan van data die niet bekend is tijdens het compileren, zoals arrays van variabele lengte of complexe datastructuren welke groeien of krimpen tijdens `rutime`. Vaak willen deze complexe datastructuren gebruik maken van pointers en referenties naar andere variabelen in de heap.

Hieronder wordt bijvoorbeeld de `cells` array van de `Grid` structuur toegewezen op de heap met behulp van de `calloc` functie.

```c
grid->cells = calloc(GRID_SIZE, sizeof(char *));
for (int i = 0; i < GRID_SIZE; ++i) {
  grid->cells[i] = calloc(GRID_SIZE, sizeof(char));
}
```

Deze geheugen toewijzingen moeten worden vrijgegeven met behulp van de `free` functie om `memory leaks` te voorkomen.
```c
  for (int i = 0; i < GRID_SIZE; ++i) {
    free(grid.cells[i]);
  }
  free(grid.cells);
```

Memory leaks treden op wanneer geheugen wordt toegewezen op de heap, maar niet wordt vrijgegeven wanneer het niet langer nodig is. In het beste geval leidt dit tot een verspilling van geheugen, maar in het ergste geval kan dit leiden tot een crash van het programma of een beveiligingslek.

## Verschil stack en heap 
De stack en de heap verschillen op verschillende manieren, zoals:

- **Lifetime**: Variabelen op de stack hebben een korte levensduur en worden automatisch vrijgegeven wanneer de functie returns, terwijl variabelen op de heap een langere levensduur hebben en handmatig moeten worden vrijgegeven.
- **Foutgevoeligheid**: De stack is minder foutgevoelig dan de heap, omdat variabelen op de stack automatisch worden vrijgegeven, terwijl variabelen op de heap handmatig moeten worden vrijgegeven.
- **Beheer**: De stack wordt beheerd door de compiler en, terwijl de heap handmatig moet worden beheerd.

## Functie, voor- en nadelen van static memory
Zoals eerder is aangegeven, worden variabelen die buiten een functie zijn gedeclareerd opgeslagen in `static memory`. Deze variabelen blijven bestaan gedurende de `lifetime` van een programma.

In zeeslag bijvoorbeeld, kunnen we bijvoorbeeld globale variabele declareren, zodat deze beschikbaar is voor alle functies in het programma.
```c
#define GRID_SIZE 10
#define NUM_SHIPS 3
```

Hierboven zijn `GRID_SIZE` en `NUM_SHIPS` static constants.

### Voordelen

- **Efficiëntie**: Static memory is efficiënt omdat het geheugen wordt toegewezen tijdens de compile time en blijft bestaan gedurende de `lifetime` van een programma. Dit maakt het sneller dan het toewijzen van geheugen tijdens de `runtime`.
- **Persistentie**: Static memory blijft bestaan gedurende de `lifetime`, wat handig is voor variabelen die gedurende het hele programma moeten worden gebruikt.

### Nadelen

- **Flexibiliteit**: Beperkt omdat het geheugen niet opnieuw kan worden toegewezen tijdens runtime.
- **Geen ondersteuning voor recursie**: Recursieve functies kunnen geen statische variabelen gebruiken voor lokale opslag.

\newpage
# Data Types (C++)
Gezien het **één na laatste cijfer** van mijn studenten nummer `6` is, zal ik slechts het hoofdstuk[@sec:expression] [Expression and Assignment Statements (C++)](#sec:expression) behandelen.

# Expression and Assignment Statements (C++) {#expression}
Gezien het **één na laatste cijfer** van mijn studenten nummer `6` wordt dit hoofdstuk behandeld.

## Relational and Boolean Expressions 
Ook wel bekend als `comparison operators` [@cpp-comparison-operators], deze operators worden gebruikt om de relatie tussen twee waarden te evalueren. De resultaten van deze operaties zijn `true` of `false`.

De relationele operatoren zijn:

- `==` (gelijk aan)
- `!=` (niet gelijk aan)
- `< `(kleiner dan)
- `> `(groter dan)
- `<=` (kleiner dan of gelijk aan)
- `>=` (groter dan of gelijk aan)

De logische operatoren zijn:

- `&&` (logical AND)
- `||` (logical OR)
- `!` (logical NOT)

Een uitgebreide lijst van de operatoren is te zien in [@fig:common-operatorss].

![[@cpp-comparison-operators]](img/common-operatorss.png){#fig:common-operatorss} 

## Expression Evaluation 
Expressie operaties worden uitgevoerd volgens de regels [@cpp-eval-order] van de programmeertaal. De volgorde van evaluatie van expressies is belangrijk, omdat deze de uitkomst van de expressie kan beïnvloeden.

Kort gezegd, de volgorde van evaluatie van expressies in C++ is als volgt:

1. `()` (parentheses)
1. `*`, `/`, `%` (vermenigvuldigen, delen, modulo)
1. `+`, `-` (optellen, aftrekken)
1. `<`, `<=`, `>`, `>=` (relational operators)
1. `==`, `!=` (equality operators)
1. `&&` (logical AND)
1. `||` (logical OR)

De expressies hierboven geven een idee van de volgorde van evaluatie van expressies in C++. De regels hierboven missen wel de `assignment operators` en `increment/decrement operators`, `bitwise operators`, en `conditional operators` maar deze zullen voor dit verslag buiten de scope worden gezet.

## Type Casting 
Type casting is het proces van het converteren van een waarde van het ene datatype naar het andere datatype [@cpp-typecasting]. In standaard C zijn er twee soorten type casting:

1. **Implicit Type Casting**: Dit gebeurt automatisch door de compiler wanneer een waarde van het ene datatype naar het andere datatype wordt geconverteerd. Bijvoorbeeld, een `int` kan worden geconverteerd naar een `float` zonder expliciete type casting.
1. **Explicit Type Casting**: Dit gebeurt handmatig door de programmeur met behulp van type casting operatoren. Bijvoorbeeld, `(float) x` converteert de waarde van `x` naar een `float`.

```c
int a = 10;
double b = (double) a;
```

In C++ zijn er vier soorten type casting:

1. **static_cast**: Dit is de meest gebruikte vorm van type casting in C++. Het wordt gebruikt om expliciet te casten tussen verschillende datatypes.
1. **dynamic_cast**: Dit wordt gebruikt voor casting van polymorphic classes.
1. **const_cast**: Wordt gebruikt om `const` en `volatile` qualifiers te verwijderen.
1. **reinterpret_cast**: Wordt gebruikt om een pointer of referentie van het ene datatype naar het andere datatype te casten.

```cpp
int a = 10;
double b = static_cast<double>(a);
```

Het grootste verschil tussen `static_cast` en `C-style` type casting is dat `static_cast` compile time type checking uitvoert, terwijl `C-style` type casting dat niet doet.

## Overloaded Operators
Operator overloading [@cpp-operator-overloading] houdt in dat een operator een andere betekenis krijgt wanneer deze wordt toegepast op objecten van een bepaald datatype. 

In C++ kunnen de meeste operators worden overladen, zoals `+`, `-`, `*`, `/`, `==`, `!=`, `<`, `>`, `<=`, `>=`, `&&`, `||`, `++`, `--`, `+=`, `-=`, `*=`, `/=`, `<<`, `>>`, `&`, `|`, `^`, `~`, `!`, `=`, `[]`, `()`, `->`, `->*`, en `,`.

Operator overloading kan handig zijn om complexe datatypes te maken die zich gedragen als bestaande datatypes. Bijvoorbeeld, een `Vector` klasse kan worden gedefinieerd met overloaded operatoren voor optellen, aftrekken, en vermenigvuldigen [@yt-operator-overloading].

```cpp
class Vector {
public:
  Vector operator + (const Vector& v) {
    Vector result;
    result.x = this->x + v.x;
    result.y = this->y + v.y;
    return result;
  }
};
```

In dit voorbeeld wordt de `+` operator overgeladen voor de `Vector` klasse, zodat twee `Vector` objecten kunnen worden opgeteld met behulp van de `+` operator.

# Statement-Level Control Structures (C++)
Gezien het **één na laatste cijfer** van mijn studenten nummer `6` is, zal ik slechts het hoofdstuk[@sec:expression] [Expression and Assignment Statements (C++)](#sec:expression) behandelen.

\newpage
# Subprograms & Implementing subprograms Abstract Data Types and Encapsulation Constructs (C#)

Nu gaan we dieper in C# duiken.


## Parameter-Passing Methods 

In C# zijn er verschillende manieren om parameters door te geven. [@csharp-parameter-passing]

1. **By Value**: De waarde van de variabele wordt gekopieerd en doorgegeven aan de functie. Eventuele wijzigingen in de parameter binnen de functie hebben *geen* invloed op de oorspronkelijke variabele.
1. **By Reference**: Een referentie naar de variabele wordt doorgegeven aan de functie. Eventuele wijzigingen in de parameter binnen de functie hebben *wel* invloed op de oorspronkelijke variabele.
1. **Out Parameters**: Wordt gebruikt om meerdere waarden terug te geven vanuit een functie.

## Stacks & Recursion aspects 
Elke recursieve call voegt een nieuwe stack frame toe. In `RpnEvaluator.cs` [@icpt-cs-generic-stack-recursion] wordt recursie toegepast om een Reverse Polish Notation (RPN) expressie [@rpn] te evalueren.

```csharp
private void EvaluateRecursive(int currentIndex)
{
    if (currentIndex < 0)
    {
        return;
    }

    string rpnChar = rpnChars[currentIndex];

    if (double.TryParse(rpnChar, out double number))
    {
        stack.Push(number);
    }
    else
    {
        EvaluateRecursive(currentIndex - 1);
        double operand2 = stack.Pop();
        double operand1 = stack.Pop();
        
        double result = rpnChar switch
        {
            "+" => operand1 + operand2,
            "-" => operand1 - operand2,
            "*" => operand1 * operand2,
            "/" => operand1 / operand2,
            _ => throw new InvalidOperationException("Invalid operator")
        };

        stack.Push(result);
        return;
    }

    EvaluateRecursive(currentIndex - 1);
}
```

Er wordt een RPN-expressie geëvalueerd door de waarden van de expressie te `poppen` van de stack en de operatoren toe te passen op de waarden. De functie roept zichzelf recursief aan totdat de hele expressie is geëvalueerd.

## Closures 
Closures in C# zijn functies of lambda's die variabelen opvangen vanuit de omsluitende scope [@closures-c], waardoor ze toegang hebben tot deze variabelen zelfs nadat de oorspronkelijke scope is verlaten.

## User-defined Abstract Data types 
Gebruikers kunnen natuurlijk ook zelf abstracte datatypes definiëren in C#. Zoals bijvoorbeeld in `Stack.cs`.

```csharp
public class GenericStack<T> {
    private List<T> elements = new List<T>();

    public void Push(T item) {
        elements.Add(item);
    }

    public T Pop()
...
```

Hier is de `GenericStack` een abstract datatype dat een generieke stack implementeert.

## Parameterized Abstract Data Types
In de constructor van `RpnEvaluator` staat hetvolgende:

```csharp
    private string[] rpnChars;
    private GenericStack<double> stack;

    public RpnEvaluator(string expression)
    {
        rpnChars = expression.Split(' ');
        stack = new GenericStack<double>();
    }
```

Hier wordt een instantie van de `GenericStack` klasse gemaakt met het type `double`, maar net zo goed kan dit ergens anders een ander type zijn.


\newpage
# Concurrency (Go)
Concurrency is een veel voorkomend concept in moderne programmeertalen, zoals Go. Go realiseert concurrency door middel van `goroutines`, `channels`, en `select statements` [@go-concurrency].

## Subprogram-Level Concurrency
Dit wordt in Go voornamelijk bereikt door `goroutines`. `Goroutines` zijn lightweight threads die worden beheerd door de Go runtime, waardoor functies tegelijkertijd kunnen worden uitgevoerd. 

In `client.go` [@icpt-go-webshop] wordt bijvoorbeeld een `goroutine` gebruikt om meerdere een clients tegelijkertijd te draaien requests naar een webshop te sturen.

```go
for i := 0; i < numClients; i++ {
  waitGroup.Add(1)
  go func(clientID int) {
    defer waitGroup.Done()
    for {
      product := products[rand.Intn(len(products))]
      if checkStockAndOrder(client, product, clientID, outputChan) {
      	outputChan <- fmt.Sprintf("Client %d: Ordered %s successfully", clientID, product)
      } else {
      	outputChan <- fmt.Sprintf("Client %d: Failed to order %s", clientID, product)
      }
      time.Sleep(time.Duration(rand.Intn(400)+800) * time.Millisecond)
    }
  }(i)
}
```

Hier maakt de regel `go func(clientID int)` een nieuwe `goroutine` voor elke client, waardoor er meerdere operaties tegelijkertijd kunnen worden uitgevoerd.

## Thread Concepts and Implementation 
Het concurrency model van Go is gebaseerd op goroutines en channels in plaats van traditionele threads [@go-multithreading]. Goroutines zijn eenvoudiger en lichter vergeleken met kernel threads, en ze worden door de Go runtime `gemultiplexed` op meerdere kernel threads [@go-multiplexing].

In `server.go` wordt de `replenishStock` functie uitgevoerd als een `goroutine`, die om de zoveel tijd de voorraad van producten aanvult.

```go
go replenishStock()
```

De `replenishStock` functie wordt uitgevoerd als een `goroutine`, waardoor de server tegelijkertijd verzoeken kan verwerken en de voorraad kan aanvullen.

## Co-operative processing
`Co-operative processing` is een vorm van concurrency waarbij processen samenwerken om taken uit te voeren [@go-parallelism-concurrency]. Hierbij worden `channels` gebruikt om gegevens tussen goroutines uit te wisselen en de sync package gebruik `sync.WaitGroup` [@go-sync] om te wachten tot de goroutines klaar zijn.

In `client.go` wordt `sync.WaitGroup` gebruikt om ervoor te zorgen dat de functie wacht tot alle goroutines klaar zijn voordat deze afsluit:

```go
var waitGroup sync.WaitGroup

...
// meerdere client m.b.v goroutines
for i := 0; i < numClients; i++ {
  waitGroup.Add(1)
  go func(clientID int) {
    defer waitGroup.Done()
    ...
  }(i)
}

...

waitGroup.Wait()
close(outputChan)
```

## Synchronisation methods
Synchronisatie in Go wordt bereikt de sync package te gebruiken, welke dat mutexen en wait groups bevat [@go-sync].
Een mutex is `een mutual exclusion lock` die wordt gebruikt om te voorkomen dat meerdere goroutines tegelijkertijd toegang krijgen tot gedeelde gegevens.
In `server.go` wordt bijvoorbeeld een mutex gebruikt om ervoor te zorgen dat voorraad operaties thread-safe zijn:

```go
var mu sync.Mutex

...

func stockHandler(responseWriter http.ResponseWriter, request *http.Request) {
  mu.Lock()
  defer mu.Unlock()
  ...
}

func orderHandler(responseWriter http.ResponseWriter, request *http.Request) {
  mu.Lock()
  defer mu.Unlock()
  ...
}
```

Hier wordt de `mu.Lock()` functie gebruikt om de mutex te vergrendelen voordat de voorraad operaties worden uitgevoerd, en `mu.Unlock()` wordt gebruikt om de mutex te ontgrendelen nadat de operaties zijn voltooid.

<!---->
<!-- # Concluderend -->
<!-- Programmeertalen zijn geëvolueerd om te voldoen aan de behoeften van programmeurs en de technologische vooruitgang. De ontwikkeling van datatypes, compilers, geheugenbeheer, en concurrency zijn enkele van de belangrijkste aspecten van programmeertalen die in de loop der jaren zijn verbeterd.  -->
<!---->
<!-- Deze verbeteringen hebben het mogelijk gemaakt om efficiëntere, leesbaardere, en onderhoudbare code te schrijven, en hebben bijgedragen aan de ontwikkeling van complexe softwaretoepassingen. Door de ontwikkeling van programmeertalen te begrijpen, kunnen programmeurs betere software schrijven en zich aanpassen aan de veranderende behoeften van de industrie. -->


\newpage
# Referenties {#sec:ref}
<div id="refs"></div>
