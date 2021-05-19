if [ $# -lt 1 ]
then
	pmempath=/pmem
else
	pmempath=$1
fi

sed -i "s/<ip_addr>/$(hostname -i)/g"	rtidb/conf/tablet.flags \
					rtidb/conf/nameserver.flags \
					benchmark/pmem-test/rtidb.properties \
					benchmark/apache-jmeter-5.1.1/bin/rtidb.properties \
					connect_rtidb.sh
sed -i "s/<ncores>/$(nproc)/g"		rtidb/conf/tablet.flags
sed -i "s#<pmem_path>#${pmempath}#g"	rtidb/conf/tablet.flags clear_rtidb.sh
echo "Done"