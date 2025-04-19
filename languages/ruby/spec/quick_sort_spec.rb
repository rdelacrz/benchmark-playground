require_relative '../lib/operations/quick_sort'

describe 'QuickSort' do
  it 'should sorts list with zero elements' do
    # Arrange
    unsorted = []
    expected_result = []

    # Act
    actual_result = QuickSortOperation.quick_sort(unsorted)

    # Asset
    expect(actual_result).to eq expected_result
  end

  it 'should sort list with one element' do
    # Arrange
    unsorted = ['badger']
    expected_result = ['badger']

    # Act
    actual_result = QuickSortOperation.quick_sort(unsorted)

    # Asset
    expect(actual_result).to eq expected_result
  end

  it 'should sort list with multiple odd elements' do
    # Arrange
    unsorted = ['zinc', 'trap', 'tree', 'trait', 'badger', 'apple', 'chemistry', 'pig', 'zoo']
    expected_result = ['apple', 'badger', 'chemistry', 'pig', 'trait', 'trap', 'tree', 'zinc', 'zoo']

    # Act
    actual_result = QuickSortOperation.quick_sort(unsorted)

    # Asset
    expect(actual_result).to eq expected_result
  end

  it 'should sort list with multiple even elements' do
    # Arrange
    unsorted = ['trap', 'apple', 'chemistry', 'pig', 'zoo', 'tree', 'trait', 'badger', 'zinc', 'crack']
    expected_result = ['apple', 'badger', 'chemistry', 'crack', 'pig', 'trait', 'trap', 'tree', 'zinc', 'zoo']

    # Act
    actual_result = QuickSortOperation.quick_sort(unsorted)

    # Asset
    expect(actual_result).to eq expected_result
  end

  it 'should sort already sorted list' do
    # Arrange
    unsorted = ['apple', 'badger', 'chemistry', 'crack', 'pig', 'trait', 'trap', 'tree', 'zinc', 'zoo']
    expected_result = ['apple', 'badger', 'chemistry', 'crack', 'pig', 'trait', 'trap', 'tree', 'zinc', 'zoo']

    # Act
    actual_result = QuickSortOperation.quick_sort(unsorted)

    # Asset
    expect(actual_result).to eq expected_result
  end

  it 'should sort integer list' do
    # Arrange
    unsorted = [4, -54, 40, 400, 2, -7, 0, 1, 4]
    expected_result = [-54, -7, 0, 1, 2, 4, 4, 40, 400]

    # Act
    actual_result = QuickSortOperation.quick_sort(unsorted)

    # Asset
    expect(actual_result).to eq expected_result
  end
end