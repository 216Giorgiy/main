set SRC=%MERLIN_ROOT%\Bin\Debug
set DST=%MERLIN_ROOT%\Bin\CodeCoverage
set PERF_TOOLS=%VSINSTALLDIR%\Team Tools\Performance Tools
set VSINSTR="%PERF_TOOLS%\vsinstr.exe" /coverage /outputpath:"%DST%"

rmdir /s /y "%DST%"
mkdir "%DST%"
xcopy /s /y "%SRC%\IronRuby*" "%DST%"
xcopy /s /y "%SRC%\IronPython*" "%DST%"
xcopy /s /y "%SRC%\Microsoft.*.dll" "%DST%"

%VSINSTR% "%SRC%\IronRuby.dll"
%VSINSTR% "%SRC%\IronRuby.Libraries.dll"
%VSINSTR% "%SRC%\IronRuby.Libraries.Yaml.dll"

"%PERF_TOOLS%\vsperfcmd.exe" /start:coverage /OUTPUT:"%DST%\IronRuby"

"%DST%\IronRuby.Tests.exe" %*

"%PERF_TOOLS%\vsperfcmd.exe" /shutdown

@echo Code Coverage results generated to
@echo %DST%\IronRuby.coverage