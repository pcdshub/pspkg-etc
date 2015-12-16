# This should be sourced by your sh/bash shell

if [ ."$PSPKG_ROOT" == . ]; then
    PSPKG_ROOT='/reg/g/pcds/pkg_mgr'
fi
export PSPKG_ROOT

. ${PSPKG_ROOT}/etc/pspkg_clean.sh

export PSPKG_RELEASE=`${PSPKG_ROOT}/etc/pspkg_release.sh`
export PSPKG_PROC=`${PSPKG_ROOT}/etc/pspkg_proc.sh`
export PSPKG_OS=`${PSPKG_ROOT}/etc/pspkg_os.sh`
export PSPKG_COMP=`${PSPKG_ROOT}/etc/pspkg_comp.sh`
export PSPKG_BUILD=`${PSPKG_ROOT}/etc/pspkg_build.sh`

export PSPKG_ARCH="${PSPKG_PROC}-${PSPKG_OS}-${PSPKG_COMP}-${PSPKG_BUILD}"
export PSPKG_RELDIR="${PSPKG_ROOT}/release/${PSPKG_RELEASE}/${PSPKG_ARCH}"

export PATH="${PSPKG_RELDIR}/bin:${PATH}"
export LD_LIBRARY_PATH="${PSPKG_RELDIR}/lib:${LD_LIBRARY_PATH}"
if [ X${EXTRA_LD_LIBS} != X ] ; then
    # LinuxRT sh clobbers LD_LIBRARY_PATH in every subshell!
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${EXTRA_LD_LIBS}"
fi
export PYTHONPATH="${PSPKG_RELDIR}/python:${PYTHONPATH}"
