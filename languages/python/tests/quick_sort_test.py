import pytest

from src.operations.quick_sort import quick_sort

@pytest.mark.parametrize("unsorted,expected", [
    ([], []),
    (["badger"], ["badger"]),
    (
        ["zinc", "trap", "tree", "trait", "badger", "apple", "chemistry", "pig", "zoo"], 
        ["apple", "badger", "chemistry", "pig", "trait", "trap", "tree", "zinc", "zoo"]
    ),
    (
        ["trap", "apple", "chemistry", "pig", "zoo", "tree", "trait", "badger", "zinc", "crack"],
        ["apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo"]
    ),
    (
        ["trap", "apple", "chemistry", "pig", "zoo", "tree", "trait", "badger", "zinc", "crack"],
        ["apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo"]
    ),
    (
        ["apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo"],
        ["apple", "badger", "chemistry", "crack", "pig", "trait", "trap", "tree", "zinc", "zoo"]
    ),
    (
        [4, -54, 40, 400, 2, -7, 0, 1, 4],
        [-54, -7, 0, 1, 2, 4, 4, 40, 400]
    )
])
def test_quick_sort(unsorted, expected):
    actual = quick_sort(unsorted, 0, len(unsorted) - 1)
    assert expected == actual