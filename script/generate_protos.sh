#!/usr/bin/env bash

set -e

grpc_tools_ruby_protoc --ruby_out=app/proto --grpc_out=app/proto app/proto/Products.proto
