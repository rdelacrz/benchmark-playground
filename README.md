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

To refresh the benchmark tables, install the toolchains and dependencies listed in each language's README, then run this command from the repository root. The generator runs each available `build.sh` before benchmarking.

```
python3 readme_generator.py
```

### QuickSort (12 implementions)
Language | Benchmark Time (1000 executions)
-- | -:
c | 15.872984 ms
c# | 320.683900 ms
c++ | 14.668205 ms
crystal | 33.641780 ms
go | 46.258375 ms
haskell | 277.842365 ms
java | 29.296499 ms
nodejs | 66.579565 ms
python | 322.992086 ms
ruby | 802.724392 ms
rust | 18.231011 ms
zig | 11.704501 ms

