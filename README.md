# benchmark-playground

> [!WARNING]  
> DO NOT EDIT THIS README DIRECTLY. It will be overridden every time the `readme_generator.py` file is executed. Edit the `README_TEMPLATE.md` file instead within the **templates** folder. Do NOT create any new references or modify the existing **language_link** and **benchmark_table** variables preceded by dollar sign characters, as they are used by the aforementioned Python script to generate updated content for the `README.md` file.

This is a passion project that seeks to benchmark various algorithms using different programming languages. I use this project to not only discover the difference in performances between different programming languages, but also to learn how to write code in newer languages by building the different benchmarking infrastructures in each language.

Benchmarking infrastructure has been set up using the following languages so far:

* [C](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/c)
* [C#](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/c%23)
* [C++](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/c%2B%2B)
* [Crystal](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/crystal)
* [Go](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/go)
* [Haskell](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/haskell)
* [Java](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/java)
* [NodeJs](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/nodejs)
* [Python](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/python)
* [Ruby](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/ruby)
* [Rust](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/rust)
* [Zig](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/zig)

## Benchmarked Operations

The following tables contains the most recent benchmark data for each operation that has been performed for each programming language in this package. This benchmark can updated by running the following command (assuming Python is installed):

```
python3 readme_generator.py
```

### QuickSort (11 implementions)
Language | Benchmark Time (1000 executions)
-- | -:
c | 79.202800 ms
c# | 623.789200 ms
crystal | 116.839940 ms
go | 110.152943 ms
haskell | 86.684913 ms
java | 193.437554 ms
nodejs | 238.204588 ms
python | 1163.375139 ms
ruby | 2051.661945 ms
rust | 95.097863 ms
zig | 85.084715 ms

