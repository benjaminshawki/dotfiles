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
  \fancyhead[C]{RSA Portfolio}
  \fancyhead[R]{\leftmark}
  \fancyfoot[C]{Page \thepage}
  \usepackage{float}
  \usepackage{hyperref}
  \setcounter{tocdepth}{4}
  \let\origfigure\figure
  \let\endorigfigure\endfigure
  \usepackage{fvextra}
  \DefineVerbatimEnvironment{Highlighting}{Verbatim}{breaklines,commandchars=\\\{\}}
  \renewenvironment{figure}[1][2] {
      \expandafter\origfigure\expandafter[H]
  } {
      \endorigfigure
  }
date: Juni 2024
output: 
  pdf_document:
    template: template.tex
lang: nl
figureTitle: "Figuur"
figPrefix: "Figuur"
secPrefix: ""
---

# RSA portfolio som ISECU

## Stap 1-6:
Voorbeeld output van de code:
```
Stap 1: Kies 2 grote priemgetallen (minstens 7 digits)
P = 67726429
Q = 11752597
Stap 2: Bereken N.  -> N = P x Q
N = 795961426286113
Stap 3: Bepaal het kleinste gemene veelvoud van (P-1,Q-1)
I = 66330112233924
Stap 4: Kies een willekeurig getal E, relatief priem t.o.v. de hiervoor berekende i.
E = 3459929027089
Stap 5: Stap 5: Los op voor D: D * E  mod i = 1. ( zie slides ).
D = 36775110839101
Stap 6: Geef de sleutelparen. Welke is de public key en welke is de private key?
Public Key: (E, N) = (3459929027089, 795961426286113)
Private Key: (D, N) = (36775110839101, 795961426286113)
```

## Stap 7: 
_Welke sleutels geef je aan jouw ontvangende partij?_

Je geeft de public key aan de ontvangende partij.

## Stap 8: 
_Is het erg als je per ongeluk de verkeerde stuurt? Leg uit waarom niet of wel._ 

Het is niet erg als je per ongeluk de verkeerde stuurt, zolang je één van de twee sleutels maar geheim houdt. Gezien beide sleutels nodig zijn om de encryptie te ontcijferen.

# Bronnen
[Bron LCM](https://stackoverflow.com/a/51716959)

# Code
```python
import random
from math import gcd
from sympy import isprime,mod_inverse

def generate_prime():
    min_value = 10_000_000
    max_value = 99_999_999

    while True:
        n = random.randint(min_value, max_value)
        if isprime(n):
            return n

def lcm(a, b):
    return abs(a * b) // gcd(a, b)

def generate_relativ_prime(lcm_value):
    while True:
        e = random.randint(2, lcm_value - 1)
        if gcd(e, lcm_value) == 1:
            return e

print("Stap 1: Kies 2 grote priemgetallen (minstens 7 digits)")
P = generate_prime()
Q = generate_prime()

print(f"P = {P}")
print(f"Q = {Q}")

print("Stap 2: Bereken N.  -> N = P x Q")
N = P * Q
print(f"N = {N}")

print("Stap 3: Bepaal het kleinste gemene veelvoud van (P-1,Q-1)")
P_minus_1 = P - 1
Q_minus_1 = Q - 1

I = lcm(P_minus_1, Q_minus_1)
print(f"I = {I}")

print("Stap 4: Kies een willekeurig getal E, relatief priem t.o.v. de hiervoor berekende i.")
E = generate_relativ_prime(I)
print(f"E = {E}")

print("Stap 5: Stap 5: Los op voor D: D * E  mod i = 1. ( zie slides ).")
D = mod_inverse(E, I)
print(f"D = {D}")

print("Stap 6: Geef de sleutelparen. Welke is de public key en welke is de private key?")
print(f"Public Key: (E, N) = ({E}, {N})")
print(f"Private Key: (D, N) = ({D}, {N})")
```
