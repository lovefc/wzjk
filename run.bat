::����վ���� sh�ű�ִ���� --- by lovefc ��Ȩ���� δ��������� ����������ҵ��;
::����ʱ�䣺2017/08/2
::github:https://github.com/lovefc/wzjk
@echo off
color 1f
title ��վ�����ű�ִ���� --by lovefc
::mode con cols=90 lines=30
call:is_num
echo ��ʼִ������ %jk_time%�� ���һ��
set sh_file=%~dp0sh\restart.sh
set wz_list=%~dp0wz.list
set log_file=%~dp0log\%date:~0,4%%date:~5,2%%date:~8,2%.log
call:win_is_64

if "%BITS%"=="true"  (
set curl_path=%~dp0exe\64\curl.exe
set puttystop=%~dp0exe\64\puttyAlertStopper.exe
) else (
set curl_path=%~dp0exe\32\curl.exe
set puttystop=%~dp0exe\32\puttyAlertStopper.exe
)

start "" %puttystop%

call:wzjt %wz_list% %jk_time%
:wzjt
if not exist %log_file% echo.>%log_file%
setlocal enabledelayedexpansion  
set /a v=0  
for /f "delims=" %%i in (%1) do (
set /a v+=1
call:jt %%i
)
setlocal disabledelayedexpansion
ping /n %2 127.1>nul
echo -----------------------------������ʼ-----------------------------
call:wzjt %1 %2
)
gito:eof
:jt
set "wzurl=%1" 
set "wzurl=%wzurl: =%"
set str="0"
%curl_path% -sL -m 10 -w "%%{http_code}" %wzurl% -o nul>check.txt
setlocal enabledelayedexpansion 
set /p str=<check.txt
if "!str!"=="200" (
call:get_ip %wzurl%
set logstr=%wzurl% ��%date% %time:~0,5%  �������� !wzip!
echo !logstr!
if NOT EXIST %~dp0info\!wzip!.txt (
echo open>%~dp0info\!wzip!.txt
)
) else (
set logstr=%wzurl% ��%date% %time:~0,5%  �޷��������� 
echo !logstr!
echo !logstr!>>%log_file%
call:get_ip %wzurl%
if EXIST %~dp0info\!wzip!.txt (
echo %wzurl% �ű�ִ���С�������
echo SSH��Ϣ:%~dp0info\!wzip!.txt
call:pyrun %~dp0info\!wzip!.txt %sh_file% 0>nul 2>nul
)
)
del check.txt /q  0>nul 1>nul 2>nul
setlocal disabledelayedexpansion
goto:eof
:pyrun
setlocal enabledelayedexpansion  
set /a v=0  
for /f "delims=" %%i in (%1) do (
set /a v+=1

if "!v!"=="1" (
set Server=%%i
)
if "!v!"=="2" (
set Port=%%i
)
if "!v!"=="3" (
set UserName=%%i
)
if "!v!"=="4" (
set UserPass=%%i
)
if "!v!"=="5" (
set sh_files=%%i
)
)

setlocal disabledelayedexpansion
if not defined sh_files (
set sh_files=%2
) else (
if NOT EXIST %sh_files% set sh_files=%~dp0sh\%sh_files%
)
set "Server=%Server%" 
set "Server=%Server: =%"
set "Port=%Port%" 
set "Port=%Port: =%"
set "UserName=%UserName%" 
set "UserName=%UserName: =%"
set "UserPass=%UserPass%" 
set "UserPass=%UserPass: =%"
if EXIST %sh_files% (
%~dp0exe\putty.exe -pw %UserPass% -P %Port% -m %sh_files% %UserName%@%Server%
ping /n 10 127.1>nul
) else (
echo ִ��sh�ű�  %sh_files% �����ڣ�
)
gito:eof

:win_is_64
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
  set BITS=true
) else (
  set BITS=false
)
goto:eof 
:is_num
set /p jk_time=   ��������ʱ�� ��λ��:
if %jk_time% gtr 0x3FFFFFFF (
echo  ���ʱ�� ���������֡���
call:is_num
)
goto:eof
:get_ip
ping %1 -4 -n 1 |find /i "ping">%1.txt
for /f "tokens=2 delims=[]" %%b in (%1.txt) do set wzip=%%b
del /f /q %1.txt
goto:eof

