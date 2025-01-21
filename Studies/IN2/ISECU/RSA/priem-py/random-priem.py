import random
from sympy import isprime

def generate_prime():
    min_value = 10_000_000
    max_value = 99_999_999

    while True:
        n = random.randint(min_value, max_value)
        if isprime(n):
            return n

prime = generate_prime()
print(f"Prime number: {prime}")
