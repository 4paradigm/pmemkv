# **PmemStore**

`PmemStore` is a forked project from Intel's [pmemkv](https://github.com/pmem/pmemkv) which is a local/embedded key-value datastore optimized for persistent memory. 
In addition to the origin pmemkv, `PmemStore` adds one more storage engine called `PSKIPLIST` to make it more suitable for supporting feature engineering/extraction workloads in AI applications. The persistent skiplist is firstly introduced in our [VLDB'21 paper](http://vldb.org/pvldb/vol14/p799-chen.pdf) **("Optimizing In-memory Database Engine for AI-powered On-line Decision Augmentation Using Persistent Memory". Cheng Chen, Jun Yang, Mian Lu, Taize Wang, Zhao Zheng, Yuqiang Chen, Wenyuan Dai, Bingsheng He, Weng-Fai Wong, Guoan Wu, Yuping Zhao, Andy Rudoff)**. Please checkout the paper for more details.
Using `PmemStore` is similar to using pmemkv (See [pmemkv README](README-pmemkv.md) for more information.)

## Table of contents
1. [Building from Sources](#building-from-Sources)
5. [Contact us](#contact-us)

## Building from Sources

### Prerequisites

* **Linux 64-bit** (OSX and Windows are not yet supported)
* **libpmem** and **libpmemobj**, which are part of [PMDK](https://github.com/pmem/pmdk) - Persistent Memory Development Kit 1.9.1
* [**libpmemobj-cpp**](https://github.com/pmem/libpmemobj-cpp) - C++ PMDK bindings 1.12
* [**memkind**](https://github.com/memkind/memkind) - Volatile memory manager 1.8.0 (required by vsmap & vcmap engines)
* [**TBB**](https://github.com/01org/tbb) - Thread Building Blocks (required by vcmap engine)
* [**RapidJSON**](https://github.com/tencent/rapidjson) - JSON parser 1.0.0 (required by `libpmemkv_json_config` helper library)
* Used only for **testing**:
	* [**pmempool**](https://github.com/pmem/pmdk/tree/master/src/tools/pmempool) - pmempool utility, part of PMDK
	* [**valgrind**](https://github.com/pmem/valgrind) - tool for profiling and memory leak detection. *pmem* forked version with *pmemcheck*
		tool is recommended, but upstream/original [valgrind](https://valgrind.org/) is also compatible (package valgrind-devel is required).
* Used only for **development**:
	* [**pandoc**](https://pandoc.org/) - markup converter to generate manpages
	* [**doxygen**](http://www.doxygen.nl/) - tool for generating documentation from annotated C++ sources
	* [**graphviz**](https://www.graphviz.org/) - graph visualization software required by _doxygen_
	* [**perl**](https://www.perl.org/) - for whitespace checker script
	* [**clang format**](https://clang.llvm.org/docs/ClangFormat.html) - to format and check coding style, version 9.0 is required

### Building PmemStore and running tests

```sh
git clone https://github.com/4paradigm/pmemstore
cd pmemstore
mkdir ./build
cd ./build
cmake .. -DBUILD_EXAMPLES=OFF -DENGINE_VCMAP=OFF -DENGINE_VSMAP=OFF -DENGINE_PSKIPLIST=ON -DCMAKE_BUILD_TYPE=Debug		# run CMake, prepare Debug version
make -j$(nproc)					# build everything
```

Run Tests

Modify `tests/engines/pskiplist/default.cmake` to specify your own pmem mounted path (default: /mnt/pmem0), then run:
```sh
ctest --output-on-failure -R pskiplist__put_get_remove__default
```

More testcases will be added.

## Contact us
For more information about **pmemstore**, contact Jun Yang (yangjun01@4paradigm.com),
Mian Lu (lumian@4paradigm) or post on our **#pskiplist** Slack channel using
[this invite link](https://join.slack.com/share/zt-oxsgomwg-hKELngKqCfyO3oLcoV2XDw).
