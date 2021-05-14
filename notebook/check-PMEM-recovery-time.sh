echo "Waiting for PMEM table to be recovered ..."
finished=$(cat rtidb/logs/tablet.info.log | grep "Finish loading PMEM" | sed "s/^.*Finish/Finish/" | wc -l)
while [ $finished -ne 1 ]
do
	sleep 1
	finished=$(cat rtidb/logs/tablet.info.log | grep "Finish loading PMEM" | sed "s/^.*Finish/Finish/" | wc -l)
done
cat rtidb/logs/tablet.info.log | grep "Finish loading PMEM" | sed "s/^.*Finish/Finish/"

