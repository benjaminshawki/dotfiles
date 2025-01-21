# Concurrency

## Why concurrency?
Moor's Law is dead. The speed of a single core is not increasing anymore.
Instead, the number of cores is increasing.
To take advantage of this, we need to write programs that can run on multiple cores.
This is called concurrency.

### Levels of Concurrency
- Computers in a network (Servers, High Performance Computing)
- Multiple applications in a computer (Operating System)
- Multiple threads in an application (Java, C#)

### Hoe wordt concurency ingezet?
Opsplitsen van een taak in verschillende stukjes
- Image converteren, sorteren, berekeningen op grote tabellen

Reageren op een reqquest/input zonder het hele systeem stop te zetten

## Processes vs Threads
### Process
- Process is een apart afgesloten stuk 
- process delen geen data/geheugen met elkaar
- kost meer resources om op te zetten 

### Thread
- Threads zijn onderdeel van een process
- Threads delen data/geheugen met elkaar

#### Time slicing

### Race conditions

#### Locking
- solved by locking
- implemented by mutexes
- een thread kan een waarde "claimen" en de andere threads moeten wachten tot de waarde weer vrijgegeven wordt

#### Semaphores
Alternatief voor mutexes

### Lockinging overhead
- Locking is niet gratis, het kan impact hebben op de performance

#### Lock contention
- Als er veel threads zijn die een lock willen hebben, dan kan dit een bottleneck worden

#### Locking granularity
- Trade-off between lock overhead and lock contention

### Deadlocks
- Deadlocks zijn situaties waarbij twee threads op elkaar wachten


## Kinds of Concurrency

## Concepts and terms

## Mechanisms

