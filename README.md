Setup to run Arrow Benchmarks on various distributions
======================================================

This repository contains various setups with vagrant and ansible to run
the benchmarks for Apache Arrow on different Linux distributions.

To setup an environment, you need Vagrant and Ansible installed.
In the directory of the environment, run the following commands:

```bash
vagrant up # start the virtual machine
vagrant ssh -- ./build.sh # build Arrow and its dependencies
```

As part of initialising the VM, vagrant will call ansible in the background
and clone the git repository of Apache Arrow and the C++ implementation of the
parquet format.

Running the benchmarks
----------------------

With the environment setup, we can execute the benchmarks. You can either run
the ones for the C++ or the Python implementation.

```bash
vagrant ssh -- ./bench-cxx.sh
vagrant ssh -- ./bench-py-dev.sh # will run `asv dev`
vagrant ssh -- ./bench-py.sh # will run `asv run`
```

Each command will place the result of the output in your current directory,
for `bench-py.sh`, it will also copy over the results JSON. This enables you
to locally run ASV's HTML performance visualization.
