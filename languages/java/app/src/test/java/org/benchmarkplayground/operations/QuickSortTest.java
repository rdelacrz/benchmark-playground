package org.benchmarkplayground.operations;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

public class QuickSortTest {
    @ParameterizedTest
    @MethodSource("provideStringListsForQuickSort")
    public void quickSortTest_StringLists(List<String> unsorted, List<String> expectedResult, String testMessage) {
        List<String> actualResult = QuickSort.quickSort(unsorted);
        assertArrayEquals(expectedResult.toArray(), actualResult.toArray(), testMessage);
    }

    @Test
    public void quickSortTest_IntegerLists() {
        List<Integer> unsorted = new ArrayList<>(List.of(4, -54, 40, 400, 2, -7, 0, 1, 4));
        List<Integer> expectedResult = new ArrayList<>(List.of(-54, -7, 0, 1, 2, 4, 4, 40, 400));
        List<Integer> actualResult = QuickSort.quickSort(unsorted);
        assertArrayEquals(expectedResult.toArray(), actualResult.toArray(), "QuickSort: Integer Test");

    }

    private static Stream<Arguments> provideStringListsForQuickSort() {
        return Stream.of(
            // Zero elements
            Arguments.of(new ArrayList<>(), new ArrayList<>(), "QuickSort: Zero Elements Test"),
            // One elements
            Arguments.of(
                new ArrayList<>(List.of("badger")),
                new ArrayList<>(List.of("badger")),
                "QuickSort: One Element Test"
            ),
            // Multiple odd elements
            Arguments.of(
                new ArrayList<>(List.of("zinc", "trap", "tree", "trait", "badger", "apple", "chemistry", "pig", "zoo")),
                new ArrayList<>(List.of("apple", "badger", "chemistry", "pig", "trait", "trap", "tree", "zinc", "zoo")),
                "QuickSort: Multiple Odd Elements Test"
            ),
            // Multiple even elements
            Arguments.of(
                new ArrayList<>(List.of("trap", "apple", "chemistry", "pig", "zoo", "tree", "trait", "badger", "zinc", "crack")),
                new ArrayList<>(List.of("apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo")),
                "QuickSort: Multiple Even Elements Test"
            )
        );
    }
}
