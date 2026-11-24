require_relative '../lib/benchmarkers/impl/quick_sort_benchmarker'

RSpec.describe QuickSortBenchmarker do
  it 'starts each in-place sort with a fresh copy of the original input' do
    fixture = File.expand_path('../../../inputs/random_string_list.json', __dir__)
    original = JSON.parse(File.read(fixture))
    sorted = original.sort
    benchmarker = described_class.new
    benchmarker.consume_file_input(fixture)

    arrays = []
    expect(QuickSortOperation).to receive(:quick_sort).twice.and_wrap_original do |sort, array|
      expect(array).to eq(original)
      arrays << array
      sort.call(array)
      expect(array).to eq(sorted)
    end

    2.times { benchmarker.get_operation_execution_time }
    expect(arrays.first).not_to equal(arrays.last)
  end
end
