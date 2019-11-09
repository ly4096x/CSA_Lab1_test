#!/bin/bash

set -e

if (( $# < 2 )); then
    echo "Usage: $0 <asm_file> <output_dir>"
    exit 1
fi

ASM_GEN=./assembler/assembler
DMEM_GEN=./dmem_generator/dmem_generator

function build {
    echo Building assembler...
    cd assembler
    go build -o assembler
    echo Building dmem_generator...
    cd ../dmem_generator
    c++ -O3 dmem_generator.cc -o dmem_generator
    echo Building complete
    cd ..
}

[[ -x $ASM_GEN ]] && [[ -x $DMEM_GEN ]] || build
echo Generating imem.txt...
$ASM_GEN $1
echo Generating dmem.txt...
$DMEM_GEN
mv imem.txt dmem.txt $2/
echo Done
