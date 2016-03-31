#!/bin/bash

set -e

export ARROW_HOME=`pwd`/dist/
export PARQUET_HOME=`pwd`/dist/
export LD_LIBRARY_PATH=`pwd`/dist/lib64/

pushd parquet-cpp
source ./setup_build_env.sh
mkdir -p build
pushd build
cmake .. "-DCMAKE_INSTALL_PREFIX=${PARQUET_HOME}" -DCMAKE_BUILD_TYPE=Release
make -j3
make install
popd
popd

pushd arrow/cpp
source ./setup_build_env.sh
mkdir -p build
pushd build
cmake .. "-DCMAKE_INSTALL_PREFIX=${ARROW_HOME}" \
    -DCMAKE_BUILD_TYPE=Release \
    -DARROW_PARQUET=ON \
    -DARROW_BUILD_BENCHMARKS=ON
make -j3
make install
popd
popd

pushd arrow/python
virtualenv venv
source ./venv/bin/activate
pip install cython numpy pandas asv
echo '[build_ext]' > ~/.pydistutils.cfg
echo 'extra-cmake-args=-DCMAKE_BUILD_TYPE=Release' >> ~/.pydistutils.cfg
pip install -e .
popd
