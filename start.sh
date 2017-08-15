#!/bin/bash

project_path=/python/scrapy-cluster
python_env_path=/home/nosun/Envs/scrapy-cluster/bin

# kill all related process





# start all related process

# kafka monitor
cd $project_path"/kafka-monitor"
nohup $python_env_path"/python" kafka_monitor.py run >/tmp/scrapy.log 2>&1 &
echo "start kafka-monitor"

# redis-monitor
cd $project_path"/redis-monitor"
nohup $python_env_path"/python" redis_monitor.py >/tmp/scrapy.log 2>&1 &
echo "start reids-monitor"

# rest
cd $project_path"/rest"
nohup $python_env_path"/python" rest_service.py >/tmp/scrapy.log 2>&1 &
echo "start rest-server"

# run spider
cd $project_path"/crawler"
nohup $python_env_path"/scrapy" runspider crawling/spiders/link_spider.py >/tmp/scrapy.log 2>&1 &
echo "start spider"

# run dump
cd $project_path"/kafka-monitor"
$python_env_path"/python" kafkadump.py dump -t demo.crawled_firehose -p
echo "start dump"