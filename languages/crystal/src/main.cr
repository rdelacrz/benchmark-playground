require "json"
require "./operations/quick_sort"

file_content = File.read("../../inputs/random_string_list.json")
json_content = JSON.parse(file_content)
arr = json_content.as_a.map(&.to_s)

total_time = Int128.new(0)
1000.times do |i|
  arr_copy = arr.clone

  start_time = Time.monotonic
  a = QuickSortOperation.quick_sort(arr_copy)
  end_time = Time.monotonic

  # Calculate elapsed time in nanoseconds
  elapsed_time_nanoseconds = (end_time - start_time).nanoseconds

  # Assuming total_time is defined as Int64
  total_time += elapsed_time_nanoseconds
end

# Convert to milliseconds
total_time_milliseconds = total_time.to_f / 1_000_000.0

# Format to six decimal places
formatted_time = sprintf("%.6f", total_time_milliseconds)

puts "Crystal's QuickSort execution time (over 1000 loops): #{formatted_time} ms"
