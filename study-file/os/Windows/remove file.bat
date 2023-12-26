@echo off
%指定的路径%
set SrcDir1=C:\python\new\Oldimage\
set SrcDir2=C:\python\禁止识别\data\
set SrcDir3=C:\python\禁止识别\MSDS解析\
%日期%
set DaysAgo=5
forfiles /p %SrcDir1% /s /m *.log /d -%DaysAgo% /c "cmd /c del /f /q /a @path"
forfiles /p %SrcDir2% /s /m *.log /d -%DaysAgo% /c "cmd /c del /f /q /a @path"
forfiles /p %SrcDir3% /s /m *.log /d -%DaysAgo% /c "cmd /c del /f /q /a @path"