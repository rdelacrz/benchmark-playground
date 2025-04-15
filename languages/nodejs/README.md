# node_benchmark_runner

The following subpackage runs benchmarks using code written in [Node](https://nodejs.org/en).

## Prerequisites

Several software must be installed in order to run **node_benchmark_runner**. The following instructions will assume that the operating system hosting this application is Ubuntu.

Before installing anything, it is recommended that you run the following:
```
sudo apt update
```

### Installing NVM
[NVM](https://github.com/nvm-sh/nvm) can be used to manage your NodeJs versions. Install it with the following command:

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
```

You may be prompted with the following command on screen after running this, which you should run to immediately allow access to NodeJs via CLI:

```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

### Installing NodeJs

The latest version of **NodeJs** can then be installed by NVM with the following command:

```
nvm install node
```

### Installing Yarn
[Yarn](https://classic.yarnpkg.com/lang/en/docs/install/#windows-stable) is a faster alternative to [NPM](http://npmjs.org/) for managing NodeJs packages. It can be installed with the following command:

```
npm install --global yarn
```

