# ZigBenchmarkRunner

## Prerequisites

The Zig compiler must be installed in order to run **ZigBenchmarkRunner**. Make sure the you have all the Host System Dependencies defined [here](https://github.com/ziglang/zig-bootstrap?tab=readme-ov-file#host-system-dependencies) installed.

### Zig Compiler Installation

From the *zig/bootstrap* folder, run the following commands below to install the Zig compiler.

This command (which is defined by the *build* file of the [zig-bootstrap](https://github.com/ziglang/zig-bootstrap) repository) builds Zig.
```
CMAKE_GENERATOR=Ninja build native-linux-gnu baseline
```

Afterwards, run the following to confirm the Zig version:
```
./out/zig-x86_64-linux-gnu-baseline/zig version
```