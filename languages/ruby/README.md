# Ruby Benchmark Runner

The following subpackage runs benchmarks using code written in [Ruby](https://www.ruby-lang.org/en/).

## Prerequisites

Several software must be installed in order to run **Ruby Benchmark Runner**. The following instructions will assume that the operating system hosting this application is Ubuntu.

Before installing anything, it is recommended that you run the following to update the system packages on Ubuntu:
```
sudo apt update
```

The next step upgrades the entire system.
```
sudo apt upgrade
```

Next, add all Ubuntu dependencies needed to run Ruby:
```
sudo apt install curl g++ gcc autoconf automake bison libc6-dev libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool libyaml-dev make pkg-config sqlite3 zlib1g-dev libgmp-dev libreadline-dev libssl-dev
```

### Install rbenv

[rbenv](https://github.com/rbenv/rbenv) needs to be installed by following these steps.

Clone rbenv into `~/.rbenv`.
```
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
```

Set up your shell to load **rbenv**
```
~/.rbenv/bin/rbenv init
```

Clone [ruby-build](https://github.com/rbenv/ruby-build) (installation plugin for **rbenv**) with:
```
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
```

*Optional: Upgrade **ruby-build** with*:
```
git -C "$(rbenv root)"/plugins/ruby-build pull
```

Add the following line to the .bashrc file:
```
alias rbenv="$HOME/.rbenv/bin/rbenv"
```

Run the following to load the changes just made to the .bashrc file.
```
source /home/${USER}/.bashrc
```

### Install Ruby

Check list of Ruby versions available with:
```
rbenv install -l
```

Install a given version of Ruby from the previous step with:
```
rbenv install <version_number>
```

Example: `rbenv install 3.4.3`

Set the global default based on the output of the installation:
```
rbenv global <version_number>
```

Example: `rbenv global 3.4.3`

Open new window for terminal, then verify that installation worked with the expected version:
```
ruby -v
```

### Install Ruby gems
After installing Ruby, run the following from `languages/ruby`:

```bash
./install_deps.sh
```

The script uses Bundler to install the project's gems (including Colorator and RSpec) into `vendor/bundle`, without `sudo`.

If rbenv reports `bundle: command not found`, check the active Ruby with `rbenv version`. If Bundler is installed under another Ruby version, switch to it for the current shell with `rbenv shell <version>` (or `export RBENV_VERSION=<version>` if shell integration is unavailable). To keep using the active Ruby instead, run `gem install bundler`.

Verify with `bundle --version`, then rerun `./install_deps.sh`. Use the same Ruby version to install gems, run benchmarks, and run tests.

## Running Ruby Benchmark Runner

From `languages/ruby`, run the benchmark with the installed gems. No build step is required.
```
./run.sh -o <operation_name> -i <input_file> -c <execution_count>
```

Example: `./run.sh -i ../../inputs/random_string_list.json -o QuickSort -c 1000`

## Running tests

After installing the gems, run `./test.sh` from `languages/ruby`.