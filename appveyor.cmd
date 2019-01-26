@setlocal
@pushd %~dp0

nuget restore || set _ERR=1

msbuild -p:Configuration=Release;Platform=x86;PlatformToolset=v140_xp || set _ERR=1
msbuild -p:Configuration=Release;Platform=x64;PlatformToolset=v140_xp || set _ERR=1

msbuild -p:Configuration=Release;Platform=x86;PlatformToolset=v141_xp || set _ERR=1
msbuild -p:Configuration=Release;Platform=x64;PlatformToolset=v141_xp || set _ERR=1
msbuild -p:Configuration=Release;Platform=ARM;PlatformToolset=v141 || set _ERR=1
msbuild -p:Configuration=Release;Platform=ARM64;PlatformToolset=v141 || set _ERR=1

msbuild -p:Configuration=Release -t:PackNativeNuget src\dutil\dutil.vcxproj || set _ERR=1

@popd
@if "%_ERR%"=="1" (echo. & echo Build FAILED. 1>&2)
@exit /b %_ERR%
