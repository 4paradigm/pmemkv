#!/bin/bash
if [ -z $1 ]
then
	nt=30
else
	nt=$1
fi
if [ -z $2 ]
then
	lc=2000000
else
	lc=$2
fi

pushd benchmark/pmem-test
../apache-jmeter-5.1.1/bin/jmeter -n -t get/pmtest-init-gs-table-2.jmx
echo "Create PMEM table : Done"
echo "Start to insert records to PMEM table with ${nt} threads with ${lc} keys each ..."
sleep 60
../apache-jmeter-5.1.1/bin/jmeter -n -t get/pmtest-load-data-2.jmx -Jthreads=${nt} -Jloop_count=${lc} -Jrecords=10
popd
