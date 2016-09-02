#!/bin/sh
#
# To be run as a program, not sourced. Check exit status.
#
if [ "$(which perl)" != "" ]; then
	STARTUP=unknown
	if [    -d "$EPICS_BASE_TOP/current/startup" ]; then
		STARTUP=$EPICS_BASE_TOP/current/startup/EpicsHostArch.pl
	elif [  -d "$EPICS_BASE/startup" ]; then
		STARTUP=$EPICS_BASE/startup
	elif [  -d "/reg/g/pcds/package/epics/3.14/base/R3.14.12-0.4.0/startup" ]; then
		STARTUP=/reg/g/pcds/package/epics/3.14/base/R3.14.12-0.4.0/startup
	elif [  -d "/afs/slac/g/pcds/package/epics/3.14/base/R3.14.12-0.4.0/startup" ]; then
		STARTUP=/afs/slac/g/pcds/package/epics/3.14/base/R3.14.12-0.4.0/startup
	fi
	if [ -f "$STARTUP/EpicsHostArch.pl" ]; then
		perl -X $STARTUP/EpicsHostArch.pl
		exit 0
	fi
else
	# Default to linuxRT if perl isn't installed
	echo linuxRT_glibc-x86_64
	exit 1
fi

exit 1
