echo "Waiting for both DRAM and PMEM tables to be recovered ..."
finished=$(cat rtidb/logs/tablet.info.log | grep "Finish" | wc -l)
while [ $finished -ne 2 ]
do
	sleep 1
done
