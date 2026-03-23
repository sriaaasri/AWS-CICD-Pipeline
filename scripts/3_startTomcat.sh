#!/bin/bash

echo "Starting application"

cd /opt/dev/apache-tomcat-11.0.18/webapps/

if [[ -f webapp.war ]]; then
    echo "application artifact exists , starting application"
    sh /opt/dev/apache-tomcat-11.0.18/bin/catalina.sh start
    sleep 2
else 
    echo "Appliation artifact not present , not starting "
    	exit 1
fi

exit 0

