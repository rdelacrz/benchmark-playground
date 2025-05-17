# C# Benchmark Runner

The following subpackage runs benchmarks using code written in [C#](https://learn.microsoft.com/en-us/dotnet/csharp/), a programming language built to run on the .NET platform.

## Prerequisites

Several software must be installed in order to run **C# Benchmark Runner**. The following instructions will assume that the operating system hosting this application is Ubuntu.

Before installing anything, it is recommended that you run the following:
```
sudo apt-get update
```

### Add Ubuntu backports package repository
```
sudo add-apt-repository ppa:dotnet/backports
```

### Install .NET SDK

Install the .NET SDK (in this case, with version 9.0), which is required in order to develop C# based applications.
```
sudo apt-get install -y dotnet-sdk-9.0
```

### Install C# Extensions (for Visual Studio Code only)

Install the [C#](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp) and [C# Dev Kit](https://learn.microsoft.com/en-us/visualstudio/subscriptions/vs-c-sharp-dev-kit) for a better Visual Studio Code experience.