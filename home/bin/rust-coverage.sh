#!/usr/bin/env sh

set -e

# By Oguz Bilgener
#
# A script to run unit tests and generate coverage locally.
#
# Prerequisites:
#
# $ rustup install nightly
# $ cargo install grcov

export CARGO_INCREMENTAL=0
export RUSTFLAGS="-Zprofile -Ccodegen-units=1 -Copt-level=0 -Clink-dead-code -Coverflow-checks=off -Zpanic_abort_tests -Cpanic=abort"
export RUSTDOCFLAGS="-Cpanic=abort"

cargo +nightly clean
cargo +nightly build
cargo +nightly test

grcov . -s . --binary-path ./target/debug/ -t html --branch --ignore-not-existing -o ./target/debug/coverage/

open target/debug/coverage/index.html
