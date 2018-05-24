## Overview

Provide the type of interaction between the cita-node 
interaction type and the cita component, use protobuf 
to generate the corresponding file. And have generated
files for the following languages in advance:
- Rust
- go
- javascript
- java

You can use them derectly, and be free to use the `protos`to generate to the languages you needed.


## Dependences

- [protobuf 3.5.1](https://github.com/google/protobuf/releases)

Generate rust files:
- [rust-protobuf v1.4.4](https://github.com/stepancheg/rust-protobuf)
- [grpc-rust 0.3.0](https://github.com/stepancheg/grpc-rust)

Generate go files:
- [protoc-gen-go](https://github.com/lleveque/protoc-gen-go)

Currently only supports these versions. If there is a break version, 
it is temporarily not supported.

## Usage

1. Install google protoc

2. Generate rust files, install rust plugin

```
$ cargo install protobuf --vers 1.4.4
$ cargo install grpc-compiler
```

3. Generate go files, install go plugin
```
$ go get -u github.com/lleveque/protoc-gen-go
```
