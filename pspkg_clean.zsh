# This should be sourced by your zsh shell

if [[ ."$PSPKG_ROOT" == . ]]; then
    set PSPKG_ROOT='/reg/g/pcds/pkg_mgr'
fi
export PSPKG_ROOT

IFS_ORIG="$IFS"

clean() {
    IFS=':'
    result=""
    for i in $1; do
	if echo $i | grep $PSPKG_ROOT > /dev/null; then
	    :
	elif [ "${result}:" == ":" ]; then
	    result="$i"
	else
	    result="${result}:$i"
	fi
    done
    IFS="${IFS_ORIG}"
    echo "$result"
}

#export PATH=`clean "$PATH"`
#export PYTHONPATH=`clean "$PYTHONPATH"`
#export LD_LIBRARY_PATH=`clean "$LD_LIBRARY_PATH"`
