import random
from math import gcd

def lcm(a, b):
    return abs(a * b) // gcd(a, b)

def generate_relatively_prime(lcm_value):
    while True:
        e = random.randint(2, lcm_value - 1)
        if gcd(e, lcm_value) == 1:
            return e

def main():
    P = 88841947
    Q = 15720959

    P_minus_1 = P - 1
    Q_minus_1 = Q - 1

    lcm_pq = lcm(P_minus_1, Q_minus_1)
    print("lcm(P-1, Q-1) =", lcm_pq)

    E = generate_relatively_prime(lcm_pq)
    print("E =", E)

if __name__ == "__main__":
    main()
