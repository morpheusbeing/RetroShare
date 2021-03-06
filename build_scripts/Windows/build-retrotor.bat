@echo off

setlocal

:: Initialize environment
call "%~dp0env.bat"
if errorlevel 1 goto error_env
call "%EnvPath%\env.bat"
if errorlevel 1 goto error_env

%cecho% info "Build libraries"
call "%~dp0build-libs\build-libs.bat" auto-copy
if errorlevel 1 %cecho% error "Failed to build libraries." & exit /B %ERRORLEVEL%

%cecho% info "Build %SourceName%"
call "%~dp0build\build.bat" retrotor
if errorlevel 1 %cecho% error "Failed to build %SourceName%." & exit /B %ERRORLEVEL%

%cecho% info "Pack %SourceName%"
call "%~dp0build\pack.bat" retrotor
if errorlevel 1 %cecho% error "Failed to pack %SourceName%." & exit /B %ERRORLEVEL%

exit /B 0

:error_env
echo Failed to initialize environment.
exit /B 1
