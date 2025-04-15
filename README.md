# benchmark-playground

> [!WARNING]  
> DO NOT EDIT THIS README DIRECTLY. It will be overridden every time the `readme_generator.py` file is executed. Edit the `README_TEMPLATE.md` file instead within the **templates** folder. Do NOT create any new references or modify the existing **language_link** and **benchmark_table** variables preceded by dollar sign characters, as they are used by the aforementioned Python script to generate updated content for the `README.md` file.

This is a passion project that seeks to benchmark various algorithms using different programming languages. I use this project to not only discover the difference in performances between different programming languages, but also to learn how to write code in newer languages by building the different benchmarking infrastructures in each language.

Benchmarking infrastructure has been set up using the following languages so far:

* [C](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/C)
* [Go](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/Go)
* [Java](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/Java)
* [Python](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/Python)
* [Rust](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/Rust)
* [Zig](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/Zig)

## Benchmarked Operations

The following tables contains the most recent benchmark data for each operation that has been performed for each programming language in this package. This benchmark can updated by running the following command (assuming Python is installed):

```
python3 readme_generator.py
```

### QuickSort
Language | Benchmark Time (1000 executions)
--- | ---
C | 79.245600 ms
Go | 113.269822 ms
Java | 184.881992 ms
Python | 998.703241 ms
Rust | 97.326103 ms
Zig | 89.586018 ms

