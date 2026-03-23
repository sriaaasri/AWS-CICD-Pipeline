#!/bin/bash

echo "Stopping application"

sh /opt/dev/apache-tomcat-11.0.18/bin/catalina.sh stop

sleep 1

if [[ ! -n $(pgrep java) ]]; then
	echo "Application stopped successfully"
fi




