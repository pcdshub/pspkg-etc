#!/bin/sh
#
# To be run as a program, not sourced. Check exit status.
#
if [ ."$EPICS_BASE" == . ]; then
    exit 1
fi

$EPICS_BASE/startup/EpicsHostArch.pl
exit 0
