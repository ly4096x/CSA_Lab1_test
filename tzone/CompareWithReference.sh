#!/bin/bash
set -e

if (( $# < 2 )); then
    echo "Usage: $0 <reference_src> <test_src>"
    exit 1
fi

function build {
    echo Building reference...
    c++ -O3 $1 -o ref &
    echo Building test...
    c++ -O3 $2 -o t &
    wait
    echo Building complete
}

function rename_results {
    for i in dmemresu*; do mv $i dmemres_$1.txt ; done
    for i in RFresu*; do mv $i rfres_$1.txt ; done
    for i in stateresu*; do mv $i stateres_$1.txt ; done
}

build $@
rm *res*.txt ||:
echo Running reference...
./ref
echo Reference returned $?
rename_results ref
echo Running test...
./t
echo Test returned $?
rename_results t

echo
echo =============== COMPARE RESULT =======================
diff -wq dmemres_* ||:
diff -wq rfres_* ||:
diff -wq stateres_* ||:
echo ======================================================
