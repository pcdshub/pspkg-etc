#!/bin/sh
#
# To be run as a program, not sourced. Check exit status.
#
if [ ."$EPICS_BASE" != . ]; then
	$EPICS_BASE/startup/EpicsHostArch.pl
	exit 0
fi
if [ ."$EPICS_BASE_TOP" != . ]; then
	$EPICS_BASE_TOP/current/startup/EpicsHostArch.pl
	exit 0
fi

exit 1
