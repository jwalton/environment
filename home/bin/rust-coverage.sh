#!/usr/bin/env sh

set -e

GIT_ROOT=$(git rev-parse --show-toplevel)
COVERAGE_DIR="${GIT_ROOT}/target/coverage/html"

if ! which grcov > /dev/null; then
    echo "Installing grcov..."
    cargo install grcov
    rustup component add llvm-tools-preview
fi

cargo clean
CARGO_INCREMENTAL=0 RUSTFLAGS='-Cinstrument-coverage' LLVM_PROFILE_FILE='cargo-test-%p-%m.profraw' cargo test $*
grcov . \
    --binary-path "${GIT_ROOT}/target/debug/deps/" \
    --source-dir . \
    --output-types html \
    --branch \
    --ignore-not-existing \
    -o "${COVERAGE_DIR}"
find . -name "*.profraw" -print0 | xargs -0 rm

# If this is MacOS, open the coverage report.
if which open > /dev/null; then
    open "${GIT_ROOT}/target/coverage/html/index.html"
else
    echo "Coverage report available at: ${COVERAGE_DIR}/index.html"
fi