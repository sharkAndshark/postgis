#!/usr/bin/env bash
set -e

# Flags for coverage build
CFLAGS_COV="-g -O0 --coverage"
LDFLAGS_COV="--coverage"

/usr/local/pgsql/bin/pg_ctl -c -l /tmp/logfile start
./autogen.sh
./configure CFLAGS="${CFLAGS_COV}" LDFLAGS="${LDFLAGS_COV}" --enable-debug
make -j check
curl -S -f https://codecov.io/bash -o .github/codecov.bash || echo "Coverage report failed"
bash .github/codecov.bash || echo "Coverage report failed"
