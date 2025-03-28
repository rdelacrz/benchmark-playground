package utils

import (
	"math"
)

func RoundToDecimals(value float64, precision int) float64 {
	factor := math.Pow(10, float64(precision)) // Calculate 10 ^ precision
	return math.Round(value*factor) / factor   // Round and divide
}
