#! /bin/bash

influxd & ProcessInfluxd=$!

if [ ! -f /root/.influxdbv2/configs ]
then
	sleep 10
	influx < influx.inf
fi

telegraf --config telegraf.conf & ProcessTelegraf=$!; wait -n $ProcessInfluxd $ProcessTelegraf