# This should be sourced by your csh/tcsh shell

if (! $?PSPKG_ROOT) then
    setenv PSPKG_ROOT /reg/g/pcds/pkg_mgr
else if (."$PSPKG_ROOT" == .) then
    setenv PSPKG_ROOT /reg/g/pcds/pkg_mgr
endif

setenv PATH `( echo $PSPKG_ROOT ; echo $PATH ) | awk -F: 'BEGIN{n=0;p="";}{if (n==0){n=1;nn="^" $1;}else{for(i=1;i<=NF;i++) if ($i !~ nn) {printf "%s%s", p, $i;p=":";};printf "\n";}}' -`
if ($?PYTHONPATH) then
    setenv PYTHONPATH `( echo $PSPKG_ROOT ; echo $PYTHONPATH ) | awk -F: 'BEGIN{n=0;p="";}{if (n==0){n=1;nn="^" $1;}else{for(i=1;i<=NF;i++) if ($i !~ nn) {printf "%s%s", p, $i;p=":";};printf "\n";}}' -`
endif
if ($?LD_LIBRARY_PATH) then
    setenv LD_LIBRARY_PATH `( echo $PSPKG_ROOT ; echo $LD_LIBRARY_PATH ) | awk -F: 'BEGIN{n=0;p="";}{if (n==0){n=1;nn="^" $1;}else{for(i=1;i<=NF;i++) if ($i !~ nn) {printf "%s%s", p, $i;p=":";};printf "\n";}}' -`
endif
