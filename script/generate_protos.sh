#!/usr/bin/env bash

set -e

grpc_tools_ruby_protoc --ruby_out=app/rpc --grpc_out=app/rpc app/proto/Products.proto
