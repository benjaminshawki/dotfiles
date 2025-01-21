package main

import (
	"crypto/rand"
	"fmt"
	"math/big"
)

// Functie om de GCD van twee getallen te berekenen
func gcd(a, b *big.Int) *big.Int {
	return new(big.Int).GCD(nil, nil, a, b)
}

// Functie om de LCM van twee getallen te berekenen
func lcm(a, b *big.Int) *big.Int {
	g := gcd(a, b)
	absProduct := new(big.Int).Mul(a, b).Abs(new(big.Int).Mul(a, b))
	return absProduct.Div(absProduct, g)
}

// Functie om een willekeurig getal E te genereren dat relatief priem is ten opzichte van lcm
func generateRelativelyPrime(lcm *big.Int) (*big.Int, error) {
	for {
		// Genereer een willekeurig getal kleiner dan lcm
		e, err := rand.Int(rand.Reader, lcm)
		if err != nil {
			return nil, err
		}
		// Controleer of gcd(e, lcm) gelijk is aan 1
		if gcd(e, lcm).Cmp(big.NewInt(1)) == 0 {
			return e, nil
		}
	}
}

func main() {
	// P en Q zijn gegeven
	P := big.NewInt(88841947)
	Q := big.NewInt(15720959)

	// Bereken P-1 en Q-1
	PMinus1 := new(big.Int).Sub(P, big.NewInt(1))
	QMinus1 := new(big.Int).Sub(Q, big.NewInt(1))

	// Bereken lcm(P-1, Q-1)
	lcmPQ := lcm(PMinus1, QMinus1)
	fmt.Println("lcm(P-1, Q-1) =", lcmPQ)

	// Genereer een willekeurig getal E dat relatief priem is ten opzichte van lcm
	E, err := generateRelativelyPrime(lcmPQ)
	if err != nil {
		fmt.Println("Error:", err)
		return
	}
	fmt.Println("E =", E)
}
