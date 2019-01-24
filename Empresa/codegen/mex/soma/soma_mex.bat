@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2013b
set MATLAB_ARCH=win32
set MATLAB_BIN="C:\Program Files\MATLAB\R2013b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=soma_mex
set MEX_NAME=soma_mex
set MEX_EXT=.mexw32
call mexopts.bat
echo # Make settings for soma > soma_mex.mki
echo COMPILER=%COMPILER%>> soma_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> soma_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> soma_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> soma_mex.mki
echo LINKER=%LINKER%>> soma_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> soma_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> soma_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> soma_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> soma_mex.mki
echo BORLAND=%BORLAND%>> soma_mex.mki
echo OMPFLAGS= >> soma_mex.mki
echo OMPLINKFLAGS= >> soma_mex.mki
echo EMC_COMPILER=lcc>> soma_mex.mki
echo EMC_CONFIG=optim>> soma_mex.mki
"C:\Program Files\MATLAB\R2013b\bin\win32\gmake" -B -f soma_mex.mk
