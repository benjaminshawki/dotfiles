from sympy import mod_inverse

P = 88841947
Q = 15720959
E = 380978847102779

P_minus_1 = P - 1
Q_minus_1 = Q - 1

def gcd(a, b):
    while b:
        a, b = b, a % b
    return a

def lcm(a, b):
    return abs(a * b) // gcd(a, b)

lcm_pq = lcm(P_minus_1, Q_minus_1)
print("lcm(P-1, Q-1) =", lcm_pq)

assert lcm_pq == 698340250852134, "lcm(P-1, Q-1) waarde klopt niet."

D = mod_inverse(E, lcm_pq)
print("D =", D)
