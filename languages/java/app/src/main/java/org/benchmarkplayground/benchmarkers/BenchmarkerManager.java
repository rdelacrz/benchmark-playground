package org.benchmarkplayground.benchmarkers;

import java.security.InvalidKeyException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.benchmarkplayground.benchmarkers.impl.*;

public final class BenchmarkerManager {
    private static BenchmarkerManager BENCHMARKER_RUNNER = null;

    public static final BenchmarkerManager getBenchmarkerRunner() {
        // Guarantees that BenchmarkerRunner is only set once per application run
        if (BENCHMARKER_RUNNER == null) {
            BENCHMARKER_RUNNER = new BenchmarkerManager();
        }

        return BENCHMARKER_RUNNER;
    }

    private Map<String, Benchmarker> benchmarkers;

    private BenchmarkerManager() {
        benchmarkers = List.of(
            new QuickSortBenchmarker()
        ).stream()
        .collect(Collectors.toMap(Benchmarker::getOperationName, b -> b));
    }

    public Benchmarker getOperationBenchmarker(String operationName) throws InvalidKeyException {
        if (benchmarkers.containsKey(operationName)) {
            return benchmarkers.get(operationName);
        } else {
            String validNames = String.join(", ", getValidOperations());
            throw new InvalidKeyException(
                String.format("Operation name '%s' not found. Operation must be one of the following: %s", operationName, validNames)
            );
        }
    }

    private List<String> getValidOperations() {
        return benchmarkers.keySet().stream().sorted().toList();
    }
}