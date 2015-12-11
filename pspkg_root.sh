#!/bin/sh
#
# To be run as a program, not sourced. Check exit status.
#
if [ ."$PSPKG_ROOT" == . ]; then
    echo '/reg/common/package'
else
    echo "$PSPKG_ROOT"
fi
exit 0
