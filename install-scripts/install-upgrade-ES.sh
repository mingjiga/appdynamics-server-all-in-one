#!/bin/bash

# check if Events Service is installed
if [ -f /config/appdynamics/events-service/processor/bin/events-service.sh ]; then
	cd /config/appdynamics/events-service/processor
	INSTALLED_VERSION=$(grep -oP '(version=)\K(.*?$)' version.txt)
	echo "Events Service: $INSTALLED_VERSION is installed"
	# check for upgrade <code to be inserted>, however upgrade path needs to be followed EC > ES > EUM > Controller
else
	# check if enterprise console is installed
	if [ ! -f /config/appdynamics/enterprise-console/platform-admin/bin/platform-admin.sh ]; then
		echo "Please install Enterprise Console on Host and map appdata to /config"
	else
		if [ -z $ES_SIZE ]; then
			ES_SIZE="dev"			
		fi
		echo "Installing Events Service"
		cd /config/appdynamics/enterprise-console/platform-admin/bin
		./platform-admin.sh install-events-service  --profile $ES_SIZE --hosts $CONTROLLER_HOST
	fi
fi
