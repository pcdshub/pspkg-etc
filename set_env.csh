# This should be sourced by your csh/tcsh shell

if (! $?PSPKG_ROOT) then
    setenv PSPKG_ROOT /reg/common/package
elsif (."$PSPKG_ROOT" == .) then
    setenv PSPKG_ROOT /reg/common/package
endif

source ${PSPKG_ROOT}/etc/pspkg_clean.csh

setenv PSPKG_RELEASE `sh -c ${PSPKG_ROOT}/etc/pspkg_release.sh`
setenv PSPKG_PROC `sh -c ${PSPKG_ROOT}/etc/pspkg_proc.sh`
setenv PSPKG_OS `sh -c ${PSPKG_ROOT}/etc/pspkg_os.sh`
setenv PSPKG_COMP `sh -c ${PSPKG_ROOT}/etc/pspkg_comp.sh`
setenv PSPKG_BUILD `sh -c ${PSPKG_ROOT}/etc/pspkg_build.sh`

setenv PSPKG_ARCH "${PSPKG_PROC}-${PSPKG_OS}-${PSPKG_COMP}-${PSPKG_BUILD}"
setenv PSPKG_RELDIR "${PSPKG_ROOT}/release/${PSPKG_RELEASE}/${PSPKG_ARCH}"

if ($?PATH) then
    setenv PATH "${PSPKG_RELDIR}/bin:${PATH}"
else
    setenv PATH "${PSPKG_RELDIR}/bin"
endif

if ($?LD_LIBRARY_PATH) then
    setenv LD_LIBRARY_PATH "${PSPKG_RELDIR}/lib:${LD_LIBRARY_PATH}"
else
    setenv LD_LIBRARY_PATH "${PSPKG_RELDIR}/lib"
endif

if ($?PYTHONPATH) then
    setenv PYTHONPATH "${PSPKG_RELDIR}/python:${PYTHONPATH}"
else
    setenv PYTHONPATH "${PSPKG_RELDIR}/python"
endif
