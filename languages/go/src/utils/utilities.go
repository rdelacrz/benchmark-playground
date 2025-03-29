package utils

import (
	"fmt"
	"math"
)

func RoundToDecimals(value float64, precision int) float64 {
	factor := math.Pow(10, float64(precision)) // Calculate 10 ^ precision
	return math.Round(value*factor) / factor   // Round and divide
}

func Fatal(s string) {
	panic(s)
}

func Fatalf(s string, a ...any) {
	panic(fmt.Sprintf(s, a...))
}
