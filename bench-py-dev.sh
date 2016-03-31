#!/bin/bash

pushd arrow/python
virtualenv venv
source ./venv/bin/activate

asv dev

popd
