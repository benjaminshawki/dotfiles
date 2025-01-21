package main

import (
	"crypto/rand"
	"fmt"
	"math/big"
)

func GeneratePrimeWithLength(length int) (*big.Int, error) {
	if length <= 0 {
		return nil, fmt.Errorf("length must be greater than 0")
	}

	min := new(big.Int).Exp(big.NewInt(10), big.NewInt(int64(length-1)), nil)
	max := new(big.Int).Exp(big.NewInt(10), big.NewInt(int64(length)), nil)
	max.Sub(max, big.NewInt(1))

	for {
		n, err := rand.Int(rand.Reader, new(big.Int).Sub(max, min))
		if err != nil {
			return nil, err
		}
		n.Add(n, min)

		if n.ProbablyPrime(20) {
			return n, nil
		}
	}
}

func main() {
	length := 8
	prime, err := GeneratePrimeWithLength(length)
	if err != nil {
		fmt.Println("Error:", err)
		return
	}

	fmt.Println("Prime number with", length, "digits:", prime)
}
