#!/bin/bash
if [ -z $1 ]
then
        nt=1
else
        nt=$1
fi
if [ -z $2 ]
then
        nk=1000000
else
        nk=$2
fi

pushd benchmark/pmem-test > /dev/null 2>&1
echo "[INFO] Start to test GET performance of DRAM table with ${nt} threads ..."
../apache-ant-1.9.6/bin/ant -Dthreads=${nt} -Dduration=120 -Dkey.count=${nk} -Dtest.script=get/pmtest-2-get-mem.jmx
popd > /dev/null 2>&1
echo "[INFO] Done"