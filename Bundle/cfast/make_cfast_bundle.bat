@echo off
set cfastrev=%1
set smvrev=%2
set upload=%3
set build_cedit=%4
SETLOCAL

set THISDIR=%CD%

echo ***Building CFAST bundle
echo ***Setting up repos
cd ..\..\..
set GITROOT=%CD%
cd %THISDIR%

set CFASTREPO=%GITROOT%\cfast
set SCRIPTDIR=%CFASTREPO%\Utilities\for_bundle\scripts
set VSSTUDIO=%CFASTREPO%\Utilities\Visual_Studio

cd %THISDIR%
echo ***Cleaning CFAST bundle build directory
git clean -dxf  > Nul 2>&1

cd %CFASTREPO%
echo ***Cleaning CFAST repo
git clean -dxf  > Nul 2>&1

cd %THISDIR%
echo ***Restoring project configuration files 
call Restore_vs_config %VSSTUDIO%  %THISDIR% %THISDIR%\out\stage1_config

cd %THISDIR%
call CopyFilestoCFASTclean %build_cedit%

cd %THISDIR%
call BUNDLE_cfast %cfastrev% %smvrev% %upload% %build_cedit%

cd %THISDIR%
