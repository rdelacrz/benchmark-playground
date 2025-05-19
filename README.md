# benchmark-playground

> [!WARNING]  
> DO NOT EDIT THIS README DIRECTLY. It will be overridden every time the `readme_generator.py` file is executed. Edit the `README_TEMPLATE.md` file instead within the **templates** folder. Do NOT create any new references or modify the existing **language_link** and **benchmark_table** variables preceded by dollar sign characters, as they are used by the aforementioned Python script to generate updated content for the `README.md` file.

This is a passion project that seeks to benchmark various algorithms using different programming languages. I use this project to not only discover the difference in performances between different programming languages, but also to learn how to write code in newer languages by building the different benchmarking infrastructures in each language.

Benchmarking infrastructure has been set up using the following languages so far:

* [C](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/c)
* [C#](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/c%23)
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
c | 80.773100 ms
c# | 715.976300 ms
crystal | 151.245229 ms
go | 121.283533 ms
haskell | 92.767640 ms
java | 199.515906 ms
nodejs | 287.210045 ms
python | 1137.303114 ms
ruby | 2247.460821 ms
rust | 100.480507 ms
zig | 91.707409 ms

