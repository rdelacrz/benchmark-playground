package org.benchmarkplayground.benchmarkers;

import org.benchmarkplayground.utils.GeneralUtilities;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public abstract class Benchmarker {
    private static short MILLI_TO_NANO_FACTOR = 6;
    private static double NANO_PER_MILLI = Math.pow(10, MILLI_TO_NANO_FACTOR);

    protected String operationName;

    public abstract Long getOperationExecutionTime();

    public abstract void consumeInputFile(String inputFilePath) throws IOException;

    public String getOperationName() {
        return operationName;
    }

    public List<Long> getOperationExecutionResults(int executionCount) {
        List<Long> executionResults = new ArrayList<>(executionCount);
        for (int i = 0; i < executionCount; i++) {
            executionResults.add(getOperationExecutionTime());
        }
        return executionResults;
    }

    public void printBenchmarkAnalysis(int executionCount) {
        List<Long> executionResults = getOperationExecutionResults(executionCount);
        Long total = executionResults.stream().reduce(Long.valueOf(0), Long::sum);
        double formattedTime = GeneralUtilities.roundToDecimals(total / NANO_PER_MILLI, MILLI_TO_NANO_FACTOR);
        System.out.println(String.format("Java's %s execution time (over %d loops): %.6f ms", operationName, executionCount, formattedTime));
    }
}
