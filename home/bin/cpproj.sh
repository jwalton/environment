mkdir -p ./pkg
PROJECT_ROOT=$(git rev-parse --show-toplevel)
PROJECT=${1:-$(basename "${PROJECT_ROOT}")}
scp "jasondev:~/solink/${PROJECT}/pkg/*" "${PROJECT_ROOT}/pkg/"
foo