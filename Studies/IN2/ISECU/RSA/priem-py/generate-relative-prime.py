import random
from math import gcd

def generate_relatively_prime(lcm_value):
    while True:
        e = random.randint(2, lcm_value - 1)
        if gcd(e, lcm_value) == 1:
            return e

def main():
    E = generate_relatively_prime(698340250852134)
    print("E =", E)

if __name__ == "__main__":
    main()
