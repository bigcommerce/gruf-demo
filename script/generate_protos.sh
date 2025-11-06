#!/usr/bin/env bash

set -e

cd proto/

grpc_tools_ruby_protoc --ruby_out=./rpc --grpc_out=./rpc Products.proto
