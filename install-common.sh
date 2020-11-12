# Rust programming
if ! which rustup > /dev/null; then
    echo Installing rustup
    curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
    source ~/.cargo/env
    rustup update
fi
