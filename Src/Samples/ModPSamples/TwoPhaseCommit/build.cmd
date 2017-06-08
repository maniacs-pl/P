set THISDIR=%~dp0
pushd %THISDIR%
set pc=..\..\..\..\Bld\drops\Release\x64\Binaries\pc.exe
if not exist "%pc%" goto :noP

set pt=..\..\..\..\Bld\drops\Release\x64\Binaries\pt.exe

%pc% /generate:C# /shared ..\CommonUtilities\Timer.p ..\CommonUtilities\TimerHeader.p /t:Timer.4ml /outputDir:..\CommonUtilities\ /profile

if NOT errorlevel 0 goto :eof

%pc% /generate:C# /shared ..\SMR\StateMachineReplicationHeader.p ..\SMR\StateMachineReplicationAbs.p /t:SMRAbs.4ml /outputDir:..\SMR\ /profile

if NOT errorlevel 0 goto :eof

%pc% /generate:C# /shared .\TwoPhaseCommit.p .\TwoPhaseCommitHeader.p .\TwoPhaseCommitClient.p .\TestDrivers.p .\TwoPhaseCommitSpec.p /r:..\SMR\SMRAbs.4ml /r:..\CommonUtilities\Timer.4ml /profile

if NOT errorlevel 0 goto :eof
%pc% /generate:C# /shared /link TestScript.p /r:TwoPhaseCommit.4ml /r:..\SMR\SMRAbs.4ml /r:..\CommonUtilities\Timer.4ml /profile

if NOT errorlevel 0 goto :eof


%pt% /psharp Test0.dll
if NOT errorlevel 0 goto :eof
%pt% /psharp Test1.dll
if NOT errorlevel 0 goto :eof
%pt% /psharp Test2.dll
if NOT errorlevel 0 goto :eof
%pt% /psharp Test3.dll
if NOT errorlevel 0 goto :eof
%pt% /psharp Test4.dll
if NOT errorlevel 0 goto :eof
goto :eof
:noP
echo please run ..\..\bld\build release x64
