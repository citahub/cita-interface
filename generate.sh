#!/usr/bin/env bash

current_dir=$(pwd)
echo "${currdir}"

protobuf_dependencies="
    protoc
"

# 
cita_node_intf_files="
    blockchain.proto
    snapshot.proto
"

cita_component_intf_files="
    auth.proto
    citacode.proto
    consensus.proto
    request.proto
    communication.proto
    executor.proto
    response.proto
    sync.proto
"

function check_dependencies {
    local l_dependencies="$1"
    for bin in ${l_dependencies}; do
        echo "check ${l_dependencies}"
        if [ ! -x "$(which ${bin})" ]; then
            echo -e "\033[31m[Error] Please check if you have installed \033[43m${bin}\033[0m in your \$PATH. \033[0m"
            echo "See dependense decription in README.md for more detail!"
            exit 1
        fi
    done
}

go_dependencies="
    ${protobuf_dependencies}
    protoc-gen-go
"

function gen_go {
    check_dependencies ${go_dependencies}
    echo -e "Generate\033[33m go\033[0m files from protos:"
    echo "  Remove all old go files in go directory"
    rm -f go/*.go
    
    # Support for go sdk, needs only cita_node_intf_files for now.
    # Maybe 
    for protofile in ${cita_node_intf_files}; do
        protoc --go_out=plugins=grpcserial:${current_dir}/go -Iprotos ${protofile}

        echo "  ${protofile} -> ${protofile/%.proto/.go.pb}"
    done

    echo -e "End generate go files, and results write to \$current_dir/go.\n"
}

js_dependencies="
    ${protobuf_dependencies}
"

function gen_js {
    check_dependencies ${js_dependencies}
    echo -e "Generate\033[33m js\033[0m files from protos:"
    echo "  Remove all old js files in go directory"
    rm -f js/*.js
    
    # Support for js sdk, needs only cita_node_intf_files for now.
    # Maybe 
    for protofile in ${cita_node_intf_files}; do
        protoc --js_out=import_style=commonjs,binary:${current_dir}/js -Iprotos ${protofile}

        echo "  ${protofile} -> ${protofile/%.proto/_pb.js}"
    done

    echo -e "End generate js files, and results write to \$current_dir/js.\n"
}

java_dependencies="
    ${protobuf_dependencies}
"

function gen_java {
    check_dependencies ${java_dependencies}
    echo -e "Generate\033[33m java\033[0m files from protos:"
    echo "  Remove all old java files in go directory"
    rm -f java/*.java
    
    # Support for java sdk, needs only cita_node_intf_files for now.
    # Maybe 
    for protofile in ${cita_node_intf_files}; do
        protoc --java_out=${current_dir}/java -Iprotos ${protofile}

        echo "  ${protofile} -> ${protofile/%.proto/.java}"
    done

    echo -e "End generate java files, and results write to \$current_dir/java.\n"
}

python_dependencies="
    ${protobuf_dependencies}
"

function gen_python {
    check_dependencies ${python_dependencies}
    echo -e "Generate\033[33m python\033[0m files from protos:"
    echo "  Remove all old python files in go directory"
    rm -f python/*.py
    
    # Support for python sdk, needs only cita_node_intf_files for now.
    # Maybe 
    for protofile in ${cita_node_intf_files}; do
        protoc --python_out=${current_dir}/python -Iprotos ${protofile}

        echo "  ${protofile} -> ${protofile/%.proto/_pb2.py}"
    done

    echo -e "End generate python files, and results write to \$current_dir/python.\n"
}

rust_dependencies="
    ${protobuf_dependencies}
    protoc-gen-rust
    protoc-gen-rust-grpc
"

function gen_rust {
    check_dependencies "${rust_dependencies}"
    echo -e "Generate\033[33m rust\033[0m files from protos:"
    echo "  Remove all old rust files in go directory"
    rm -f rust/*.rs
    
    # Support for rust sdk, needs only cita_node_intf_files for now.
    # Maybe 
    for protofile in ${cita_node_intf_files}; do
        protoc --python_out=${current_dir}/rust -Iprotos ${protofile}

        echo "  ${protofile} -> ${protofile/%.proto/.rs}"
    done

    echo -e "End generate rust files, and results write to \$current_dir/rust.\n"
}

function main {
    gen_go
    gen_js
    gen_java
    gen_python
    gen_rust
}

main

