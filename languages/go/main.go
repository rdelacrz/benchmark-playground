package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"math"
	"os"
	"strings"
	"time"

	"github.com/benchmark-playground/go/operations"
)

var nanoPerMilli int64 = 1000000

type String string

func (a String) CompareTo(b String) int {
	return strings.Compare(string(a), string(b))
}

func RoundToDecimals(value float64, precision int) float64 {
	factor := math.Pow(10, float64(precision)) // Calculate 10 ^ precision
	return math.Round(value*factor) / factor   // Round and divide
}

// go build -ldflags="-s -w" -o main
// ./main
func main() {
	inputFile, err := os.Open("../../inputs/random.json")
	if err != nil {
		log.Fatal(err)
	}

	defer inputFile.Close()

	inputValue, _ := io.ReadAll(inputFile)
	var stringList []String

	// Unmarshal the JSON data into the slice
	err = json.Unmarshal(inputValue, &stringList)
	if err != nil {
		log.Fatal(err)
	}

	total := int64(0)

	loopCount := 1000
	for range make([]struct{}, loopCount) {
		listCopy := make([]String, len(stringList))
		copy(listCopy, stringList)

		start := time.Now()
		operations.QuickSort(listCopy)
		elapsed := time.Since(start)

		total += elapsed.Nanoseconds()
	}

	totalMilli := RoundToDecimals(float64(total)/float64(nanoPerMilli), 4)

	fmt.Printf("Go's %s execution time (over %d loops): %.4f ms\n", "QuickSort", loopCount, totalMilli)
}
