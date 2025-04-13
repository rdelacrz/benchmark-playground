# benchmark-playground

> [!WARNING]  
> DO NOT EDIT THIS README DIRECTLY. It will be overridden every time the `readme_generator.py` file is executed. Edit the `README_TEMPLATE.md` file instead within the **templates** folder. Do NOT create any new references or modify the existing **language_link** and **benchmark_table** variables prededed by dollar sign characters, as they are used by the aforementioned Python script to generate updated content for the `README.md` file.

This is a passion project that seeks to benchmark various algorithms using different programming languages. I use this project to not only discover the difference in performances between different programming languages, but also to learn how to write code in newer languages by building the different benchmarking infrastructures in each language.

Benchmarking infrastructure has been set up using the following languages so far:

* [C](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/c)
* [Go](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/go)
* [Java](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/java)
* [Python](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/python)
* [Rust](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/rust)
* [Zig](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/zig)

## Benchmarked Operations

The following tables contains the most recent benchmark data for each operation that has been performed for each programming language in this package. This benchmark can updated by running the following command (assuming Python is installed):

```
python3 readme_generator.py
```

### QuickSort
Language | Benchmark Time (1000 executions)
--- | ---
c | 79.049200 ms
go | 115.050740 ms
java | 194.968827 ms
python | 1006.726027 ms
rust | 104.331705 ms
zig | 89.481709 ms

