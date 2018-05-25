#!/usr/bin/env bash

current_dir=$(pwd)
echo "$currdir"

dependency_bin_list="
    protoc
    protoc-gen-go
"

function check_dependencies {
    for bin in $dependency_bin_list; do
        if [ ! -x "$(which ${bin})" ]; then
            echo "[Error] Please check if you have installed ${bin} in your \$PATH."
            echo "See dependense decription in README.md for more detail!"
            exit 1
        fi
    done
}

function gen_go {
    echo "Generate go files from protos..."
    
    echo "...Remove all old go files in go directory"
    rm -f go/*.go

    
    find protos -name "*.proto" | while read protofile; do
        echo "...$protofile"
        protoc --go_out=plugins=grpcserial:$current_dir/go -Iprotos $protofile
    done

    echo "End generate go files, checkout the output in \$current_dir/go."

}

function main {
    check_dependencies
    gen_go
}

main

