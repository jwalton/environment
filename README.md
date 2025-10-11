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
# On desktop:
sudo snap install --classic code
sudo snap install vlc

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
./scripts/install-volta.sh
```

## Setting up gpg for signing commits

See [detailed instructions](https://withblue.ink/2020/05/17/how-and-why-to-sign-git-commits.html), but the short version is:

Generate a new key:

```sh
gpg --full-generate-key
gpg --list-secret-keys --keyid-format LONG
gpg --armor --export YOUR_ID
# On GitHub, Settings > SSH and GPG Keys > New GPG Key, add your key.
git config --global user.signingkey YOUR_ID
git config --global commit.gpgSign true
```

Or, copy existing key from another machine:

```sh
# On old machine
gpg --list-keys
gpg --export-secret-keys -a YOUR_KEY_ID > key_private.asc
gpg --export -a YOUR_KEY_ID > key_public.asc
# On new machine
gpg --import key_private.asc && gpg --import key_public.ash
```

Rotate keys when they expire:

```sh
gpg --list-keys --keyid-format SHORT
gpg --edit-key YOUR_KEY_ID
list
key 0
expire
2y
y
key 1
expire
2y
y
save
```
