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
