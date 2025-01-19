#!/bin/bash

mkdir -p build

cmake -B build -S . -DCMAKE_BUILD_TYPE=Debug -G Ninja
cmake --build build
