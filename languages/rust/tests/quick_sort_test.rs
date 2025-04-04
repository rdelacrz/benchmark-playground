use rust_benchmark_runner::operations::quick_sort::quick_sort;

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