package org.benchmarkplayground.benchmarkers.impl;

import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.benchmarkplayground.benchmarkers.Benchmarker;
import org.benchmarkplayground.operations.QuickSort;
import org.benchmarkplayground.utils.Constants;

import com.fasterxml.jackson.core.type.TypeReference;
import com.google.common.base.Stopwatch;

public class QuickSortBenchmarker extends Benchmarker {
    private List<String> unsortedList;

    public QuickSortBenchmarker() {
        operationName = "QuickSort";
        unsortedList = null;
    }

    @Override
    public void consumeInputFile(String inputFilePath) throws IOException {
        String fileContent = Files.readString(Path.of(inputFilePath), Charset.defaultCharset());
        unsortedList = Constants.OBJECT_MAPPER.readValue(fileContent, new TypeReference<>() {});
    }

    @Override
    public Long getOperationExecutionTime() {
        List<String> arrCopy = new ArrayList<>(unsortedList);

        Stopwatch stopwatch = Stopwatch.createStarted();
        QuickSort.quickSort(arrCopy);
        stopwatch.stop();

        return stopwatch.elapsed(TimeUnit.NANOSECONDS);
    }
    
}
