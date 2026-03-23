#!/bin/bash

echo "Deleting webapp artifact from webapps"

cd /opt/dev/apache-tomcat-11.0.18/webapps/

rm -rf webapp*

if [[ ! -f webapp* ]]; then
	echo "Deleted succefully"
fi
