# This should be sourced by your sh/bash shell

if [ ."$PSPKG_ROOT" == . ]; then
	if [ -d /reg/g/pcds/pkg_mgr ]; then
    	PSPKG_ROOT='/reg/g/pcds/pkg_mgr'
	else
    	PSPKG_ROOT='/afs/slac/g/pcds/pkg_mgr'
	fi
fi
export PSPKG_ROOT

function env_add_pkg_usage()
{
	echo "
env_add_pkg prepends a specied pkg_mgr package or release to your
   env path variables: PATH, PYTHONPATH, LD_LIBRARY_PATH

Usage: env_add_pkg PKG_NAME/VERSION
   or  env_add_pkg RELEASE-VERSION

Examples:
env_add_pkg controls-0.0.7
env_add_pkg pyca/2.1.0
"
}

if [ "$ENV_ADD_PKG_DEFINED" != "1" ]; then
	ENV_ADD_PKG_FIRST_TIME=1
else
	ENV_ADD_PKG_FIRST_TIME=0
fi
function env_add_pkg()
{
	if [ $# -ne 1 ]; then
		env_add_pkg_usage
		return 1
	fi
	export PSPKG_RELEASE=$1
	source $PSPKG_ROOT/etc/env_add_pkg.sh
}
export ENV_ADD_PKG_DEFINED=1

# PSPKG_RELEASE must be specified
if [ -z "$PSPKG_RELEASE" ]; then
	if [ $# -eq 1 ]; then
		export PSPKG_RELEASE=$1
	fi
fi
if [ -z "$PSPKG_RELEASE" ]; then
	if [ "$ENV_ADD_PKG_FIRST_TIME" == 1 ]; then
		return 0
	fi
	env_add_pkg_usage
	return 1
fi

# Determine which architecture to use
export PSPKG_PROC=`${PSPKG_ROOT}/etc/pspkg_proc.sh`
export PSPKG_OS=`${PSPKG_ROOT}/etc/pspkg_os.sh`
export PSPKG_COMP=`${PSPKG_ROOT}/etc/pspkg_comp.sh`
export PSPKG_BUILD=`${PSPKG_ROOT}/etc/pspkg_build.sh`

export PSPKG_ARCH="${PSPKG_PROC}-${PSPKG_OS}-${PSPKG_COMP}-${PSPKG_BUILD}"
export PSPKG_RELDIR="${PSPKG_ROOT}/release/${PSPKG_RELEASE}/${PSPKG_ARCH}"

# Check for release directory
if [ ! -d $PSPKG_RELDIR ]; then
	echo PSPKG Error: Release $PSPKG_RELDIR not found!
	return 1
fi

source $PSPKG_ROOT/etc/pathmunge.sh

# Add the release to PATH
pathmunge ${PSPKG_RELDIR}/python-bin
pathmunge ${PSPKG_RELDIR}/bin

# Add the release to LD_LIBRARY_PATH
ldpathmunge ${PSPKG_RELDIR}/lib
if [ X${EXTRA_LD_LIBS} != X ] ; then
    # LinuxRT sh clobbers LD_LIBRARY_PATH in every subshell!
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${EXTRA_LD_LIBS}"
fi

# Add the release to PYTHONPATH
pythonpathmunge ${PSPKG_RELDIR}/python-site-packages
pythonpathmunge ${PSPKG_RELDIR}/python

