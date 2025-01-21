7 Test principles

# Blackbox Testing
Testen zonder de code te kennen

## Toepassing blackbox testen
- API
- Libraries

## Technieken
- input/output driven
- Requirements ( buisness value )
- Technieken
- Ervaring (sql injection, escape codes)


### Test Design Techniques

#### Equivalence Partitioning
Separate in ranges

From these ranges derive test cases

Example: Test the password requirements 

##### Opdracht
xxxxx
480 % 15 = 0 -> Expect 0
481 % 15 = 1 -> Expect 1 

480 % -15 ? What happens
481 & -15 ? What happens

-480 % 15 ? What happens
-481 % 15 ? What happens

Wat gebeurt er als je meerdere barakken hebt en tegelijkertijd units trained?
Wat gebeurt er als er geen units meer zijn?
xxxx
Barraken 15 per unit, 480 vooraad 

invalid < 0 | valid 1-32 | invalid > 32
--- | --- | ---
-18? | 18 | 41

#### Boundary Value Analysis
Expansion on Equivalence Partitioning

What are the boundaries of the ranges?

##### Opdracht

invalid < 0 | valid 1-32 | invalid > 32
--- | --- | ---
0, -1, -2 | 1, 2, 31, 32 | 33, 34

#### Table testing
Testen van gedrag verschilllende input combinaties

| Conditions    | Column2    | Column3    | Column4    | Column5    |
|---------------- | --------------- | --------------- | --------------- | --------------- |
| Username    | Item2.1    | Item3.1    | Item4.1    | Item5.1   |
| Password   | Item2.2   | Item3.2   | Item4.2   | Item5.2   |
| output   | Item2.3   | Item3.3   | Item4.3   | Item5.3   |

#### State Transition Testing
- Testen van de overgangen tussen verschillende states
- Vaak gebruikt in transacties

S1 <-> S2 <-> S3

States in pint and pillage, (logged in / logged out), (Building upgrade or done)

Boten in PaP (Harbor, Sail, Pillage)
A voyage()
B Pillaging()
C homeVoyage()
D moveintoHarbor()

#### Fuzzing
- Infinite monkey theorem
- Random input to see what happens
- On error -> log, alert devs and continue

#### Fuzzing generating input
-  Parameters, in methods
- Files
- UI
- Command line input

##### Ways to give input
- Total random
- Generate random input based on requirements
- list of "known to be dangerous" input

# Whitebox Testing`

2 Vormen van whitebox testing Static, Dynamic. 
Ook hebben we het over code coverage

## Static
Code wordt niet uitgevoerd, zondder te draaien

- Reviews
- Statische analyse

### Statische analyse
We lezen de code niet, dat automatiseren we

Zoeken naar veelvookomende fouten/patronen (best practises)

- Sonar cube `TODO: look into sonar qube! loks good`
- linters
- semgrep
- Wiskundig formal methods (formal verification) (e.g. Check if the compiler is correct)

## Dynamic

## Code coverage
- Hoeveel van de code is getest
- Waarom is het wel of niet belangrijk
- Zien hoveel van onze testen mijn code rakt

### Statement coverage
Gaat puur om de regels code

### Decision coverage
Gaat om het afvangen van elke keuze in de code

### Branch Coverage
Gaat om het afvangen van elke branch in de code (Niet git branch)

Lijkt op decision coverage, maar dan met een andere focus.
Het gaat om het afvangen van alle mogelijke paden in de code.

Branch coverage vefrschilt van decision coverage in het feit dat het niet gaat om de keuzes, maar om de paden.
Niet elke keuze leidt tot een nieuwe branch. dus decision coverage is niet altijd gelijk aan branch coverage.



