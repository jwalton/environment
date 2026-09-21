#!/usr/bin/env bash

set -e

CWD=$(pwd)
COVERAGE_DIR="${CWD}/target/coverage/html"

# Install/update tools we need.
cargo install grcov
rustup component add llvm-tools-preview

cargo clean
find . -name "*.profraw" -print0 | xargs -0 rm
CARGO_INCREMENTAL=0 RUSTFLAGS='-Cinstrument-coverage' LLVM_PROFILE_FILE='cargo-test-%p-%m.profraw' cargo test "$@"
grcov . \
    --binary-path "${CWD}/target/debug/deps/" \
    --source-dir . \
    --output-types html \
    --branch \
    --ignore-not-existing \
    --ignore 'target/debug/build/**' \
    -o "${COVERAGE_DIR}"
find . -name "*.profraw" -print0 | xargs -0 rm

# If this is MacOS, open the coverage report.
if which open > /dev/null; then
    open "${CWD}/target/coverage/html/index.html"
else
    echo "Coverage report available at: ${COVERAGE_DIR}/index.html"
fi
