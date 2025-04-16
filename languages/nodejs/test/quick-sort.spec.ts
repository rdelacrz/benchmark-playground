import { describe, expect, test } from '@jest/globals';
import { quickSort } from '@operations/quick-sort';
import { ComparableNumber, ComparableString } from '@utils/comparable';

describe("QuickSort algorithm", function() {
    test("Sorts list with zero elements.", function () {
        // Arrange
        let unsorted: ComparableString[] = [];
        const expectedResult: ComparableString[] = [];

        // Act
        const actualResult = quickSort(unsorted);

        // Arrange
        expect(expectedResult).toEqual(actualResult);
    });

    test("Sorts list with one element.", function () {
        // Arrange
        let unsorted: ComparableString[] = [new ComparableString("badger")];
        const expectedResult: ComparableString[] = [new ComparableString("badger")];

        // Act
        const actualResult = quickSort(unsorted);

        // Arrange
        expect(expectedResult).toEqual(actualResult);
    });

    test("Sorts list with multiple odd elements.", function () {
        // Arrange
        let unsorted: ComparableString[] = [
            "zinc", "trap", "tree", "trait", "badger", "apple", "chemistry", "pig", "zoo"
        ].map(s => new ComparableString(s));
        const expectedResult: ComparableString[] = [
            "apple", "badger", "chemistry", "pig", "trait", "trap", "tree", "zinc", "zoo"
        ].map(s => new ComparableString(s));

        // Act
        const actualResult = quickSort(unsorted);

        // Arrange
        expect(expectedResult).toEqual(actualResult);
    });

    test("Sorts list with multiple even elements.", function () {
        // Arrange
        let unsorted: ComparableString[] = [
            "trap", "apple", "chemistry", "pig", "zoo", "tree", "trait", "badger", "zinc", "crack"
        ].map(s => new ComparableString(s));
        const expectedResult: ComparableString[] = [
            "apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo"
        ].map(s => new ComparableString(s));

        // Act
        const actualResult = quickSort(unsorted);

        // Arrange
        expect(expectedResult).toEqual(actualResult);
    });

    test("Sorts already sorted list.", function () {
        // Arrange
        let unsorted: ComparableString[] = [
            "apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo"
        ].map(s => new ComparableString(s));
        const expectedResult: ComparableString[] = [
            "apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo"
        ].map(s => new ComparableString(s));

        // Act
        const actualResult = quickSort(unsorted);

        // Arrange
        expect(expectedResult).toEqual(actualResult);
    });

    test("Sorts already sorted list.", function () {
        // Arrange
        let unsorted: ComparableNumber[] = [
            4, -54, 40, 400, 2, -7, 0, 1, 4
        ].map(n => new ComparableNumber(n));
        const expectedResult: ComparableNumber[] = [
            -54, -7, 0, 1, 2, 4, 4, 40, 400
        ].map(n => new ComparableNumber(n));

        // Act
        const actualResult = quickSort(unsorted);

        // Arrange
        expect(expectedResult).toEqual(actualResult);
    });
});