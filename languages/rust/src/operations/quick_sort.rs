/**
 * Contains the implementation of QuickSort.
 */

pub fn partition<T: Ord>(arr: &mut [T]) -> usize {
    let len = arr.len();
    let pivot = len - 1;
    let mut store_index = 0;

    for i in 0..len - 1 {
        if arr[i] < arr[pivot] {
            arr.swap(i, store_index);
            store_index += 1;
        }
    }
    arr.swap(store_index, pivot);
    store_index
}

pub fn quick_sort<T: Ord>(arr: &mut [T]) -> &mut [T] {
    if arr.len() > 1 {
        let pivot = partition(arr);
        quick_sort(&mut arr[0..pivot]);
        quick_sort(&mut arr[pivot + 1..]);
    }
    arr
}

/*******************************************************
 * Unit Tests
 ******************************************************/

#[test]
fn test_quick_sort_zero_elements() {
    // Arrange
    let mut unsorted: Vec<i32> = Vec::new();
    let expected_result: Vec<i32> = Vec::new();

    // Act
    let actual_result = quick_sort(&mut unsorted);

    // Assert
    assert_eq!(expected_result, actual_result);
}

#[test]
fn test_quick_sort_single_element() {
    // Arrange
    let mut unsorted: [&str; 1] = ["badger"];
    let expected_result: [&str; 1] = ["badger"];

    // Act
    let actual_result = quick_sort(&mut unsorted);

    // Assert
    assert_eq!(expected_result, actual_result);
}

#[test]
fn test_quick_sort_multiple_odd_elements() {
    // Arrange
    let mut unsorted: [&str; 9] = ["zinc", "trap", "tree", "trait", "badger", "apple", "chemistry", "pig", "zoo"];
    let expected_result: [&str; 9] = ["apple", "badger", "chemistry", "pig", "trait", "trap", "tree", "zinc", "zoo"];

    // Act
    let actual_result = quick_sort(&mut unsorted);

    // Assert
    assert_eq!(expected_result, actual_result);
}

#[test]
fn test_quick_sort_multiple_even_elements() {
    // Arrange
    let mut unsorted: [&str; 10] = ["trap", "apple", "chemistry", "pig", "zoo", "tree", "trait", "badger", "zinc", "crack"];
    let expected_result: [&str; 10] = ["apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo"];

    // Act
    let actual_result = quick_sort(&mut unsorted);

    // Assert
    assert_eq!(expected_result, actual_result);
}

#[test]
fn test_quick_sort_already_sorted() {
    // Arrange
    let mut unsorted: [&str; 10] = ["apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo"];
    let expected_result: [&str; 10] = ["apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo"];

    // Act
    let actual_result = quick_sort(&mut unsorted);

    // Assert
    assert_eq!(expected_result, actual_result);
}

#[test]
fn test_quick_sort_integers() {
    // Arrange
    let mut unsorted: [i16; 9] = [4, -54, 40, 400, 2, -7, 0, 1, 4];
    let expected_result: [i16; 9] = [-54, -7, 0, 1, 2, 4, 4, 40, 400];

    // Act
    let actual_result = quick_sort(&mut unsorted);

    // Assert
    assert_eq!(expected_result, actual_result);
}