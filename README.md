# Environment

## Mac Installation

First, install vscode and Cascadia Code Font, then:

```sh
mkdir -p dev && \
    cd dev && \
    git clone https://github.com/jwalton/environment.git && \
    cd environment && \
    ./install.sh
```

If you use Little Snitch, and you're on Big Sur, see instructions [here](https://tinyapps.org/blog/202010210700_whose_computer_is_it.html) for allowing Little Snitch to filter Mac apps, and I'd also recommend reading [this slightly tongue in cheek article](https://www.naut.ca/blog/2020/11/13/forbidden-commands-to-liberate-macos/) if you want to understand exactly what's going on.  You may also want to block traffic to ocsp.apple.com if you don't want Apple to know every time you open an app.

## Ubuntu Installation

```sh
sudo apt install git -y
mkdir -p dev && \
    cd dev && \
    git clone https://github.com/jwalton/environment.git && \
    cd environment && \
    ./install.sh
```

## Programming Environments

### Installing Rust

```sh
./scripts/install-rust.sh
```

### Installing Node

```sh
./scripts/install-nvm.sh
```
