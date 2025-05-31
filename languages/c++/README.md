# C++ Benchmark Runner

The following subpackage runs benchmarks using code written in **C++**.

## Prerequisites

Several software must be installed in order to run **C++ Benchmark Runner**. The following instructions will assume that the operating system hosting this application is Ubuntu.

Before installing anything, it is recommended that you run the following:

```
sudo apt update
```

This will update the package repository to ensure you have the latest package information.

### Install Clang

The **C++ Benchmark Runner** uses [Clang](https://clang.llvm.org/get_started.html) to compile and run the benchmarks. You can download Clang using Ubuntu's built-in package manager.

1. Install Clang by running:
    ```
    sudo apt install clang
    ```

2. Verify the installation by checking the Clang version:
    ```
    clang --version
    ```
This command should display the installed version of Clang, confirming a successful installation.

### Install CMake

[CMake](https://cmake.org/) is a package managed by [Kitware](https://apt.kitware.com/) that will be used to manage the building process of the C++ based  **C++ Benchmark Runner**. You can download the latest version of CMake using Ubuntu's built-in package manager (just like with Clang).

1. Uninstall the current version of CMake (if it is already installed) by running:
    ```
    sudo apt purge --auto-remove cmake
    ```
2. Obtain a copy of Kitware's signing key:
    ```
    wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
    ```
3. Add the repository to your sources list:
    * For Ubuntu Noble Numbat (24.04)
        ```
        echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ noble main' | sudo tee /etc/apt/sources.list.d/kitware.list >/dev/null
        ```
    * For Ubuntu Jammy Jellyfish (22.04)
        ```
        echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main' | sudo tee /etc/apt/sources.list.d/kitware.list >/dev/null
        ```
    * For Ubuntu Focal Fossa (20.04)
        ```
        echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ focal main' | sudo tee /etc/apt/sources.list.d/kitware.list >/dev/null
        ```
4. Update and install the new version of CMake:
    ```
    sudo apt update
    sudo apt install cmake
    ```
5. Install Ninja for use with CMake:
    ```
    sudo apt install ninja-build
    ```

