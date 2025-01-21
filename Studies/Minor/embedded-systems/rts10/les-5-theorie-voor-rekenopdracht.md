# Schedulability and response time analysis
Doel van schedulabillity is het garanderen van response time, er bestaat een heel vakgeboed over response time analysis.

## Task scheduling
In Realtime systems is het bijna altijd statisch.

Wrost-case executie tijd is erg ingewikkeld om te berekenen.


Statisch voor reatltime systems, dynamish voor general purpose

## Scheduling Real-time systems
Most common used is Preemtive Priority Based scheduling

Vindt deze methode ook 

We can calculate the Utalization for each cyclic executived

## Fixed Priority Scheduling
Prioriteit moet je afleiden op basis van timing requiremnts

### Rate Monotonic Priority Assignment (RMPA)
`Ti < Tj => Pi > Pj`


#### Slide pagina 17
Cealing functie in de wiskunde is naar boven afronden
Er is geen inverse bewerking voor de cealing functie
Recurrence relation is een wiskundige formule die een functie beschrijft in termen van zijn waarde op eerder momenten


Als er timing req zijn gebriuk unieke prioriteiten

### Date Monotonic Priority Assignment (DMPA)
`Di < Dj => Pi > Pj`

Sporadic task (interrupts)

Maak een taak die sporadic is periodiek 

## Priority Inversion
Als een lage prioriteit taak een hoge prioriteit taak blokkeert, (zat bvb in de eerste mars rover)

## Priority Inheritance
Priority inheritance can not be implemented for semaphores and message queues, solution e.g. Priority Ceiling Protocol

Pthread lib has priority ceiling


