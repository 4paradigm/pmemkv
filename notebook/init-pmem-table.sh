#!/bin/bash
if [ -z $1 ]
then
        nt=20
else
        nt=$1
fi
if [ -z $2 ]
then
        lc=1000000
else
        lc=$2
fi

pushd benchmark/pmem-test > /dev/null 2>&1
../apache-jmeter-5.1.1/bin/jmeter -n -t get/pmtest-init-gs-table-2.jmx > /dev/null 2>&1
echo "[INFO] Create PMEM table : Done"
echo "[INFO] Start to insert records to PMEM table with ${nt} threads with ${lc} keys each ..."
sleep 60
../apache-jmeter-5.1.1/bin/jmeter -n -t get/pmtest-load-data-2.jmx -Jthreads=${nt} -Jloop_count=${lc} -Jrecords=1
popd > /dev/null 2>&1
echo "[INFO] Done"