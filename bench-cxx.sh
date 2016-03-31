#!/bin/bash

pushd arrow/cpp/build
# TODO: Is there a routine to call all benchmarks?
./release/column-benchmark | tee /vagrant/bench-cxx.log
popd
