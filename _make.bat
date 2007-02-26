setlocal
set appname=%~n0


d:
cd d:\data\codes\%appname%\trunk

for /F "tokens=1-3 delims=/ " %%a in ('date /t') do set DATES=%%a%%b%%c

del "o:\xul\xpi\%appname%.xpi"
del "o:\xul\xpi\%appname%_en.xpi"
del "o:\xul\xpi\%appname%.lzh"

chmod -cfr 644 *.jar *.js *.light *.inf *.rdf *.cfg *.manifest



mkdir temp
xcopy content temp\content /i /s
xcopy locale temp\locale /i /s
xcopy skin temp\skin /i /s
xcopy defaults temp\defaults /i /s
xcopy *.js temp\ /i
xcopy *.rdf temp\ /i
xcopy *.manifest temp\ /i
cd temp



mkdir "chrome"
zip -r0 "chrome\%appname%.jar" content locale skin

del locale.inf
copy o:\xul\codes\make-xpi\ja.inf .\locale.inf
del options.inf
copy "o:\xul\codes\make-xpi\options.%appname%.ja.inf" .\options.inf
zip -9 o:\xul\xpi\%appname%.xpi *.js *.light *.inf *.rdf *.cfg *.manifest
zip -9 -r o:\xul\xpi\%appname%.xpi chrome
zip -9 -r o:\xul\xpi\%appname%.xpi defaults


IF EXIST readme.txt GOTO MAKELZH
GOTO MAKEEN

:MAKELZH
c:\apps\Dos\unlha\unlha.exe a -m0 o:\xul\xpi\%appname%.lzh o:\xul\xpi\%appname%.xpi readme.txt


:MAKEEN
del locale.inf
copy o:\xul\codes\make-xpi\en.inf .\locale.inf
del options.inf
copy "o:\xul\codes\make-xpi\options.%appname%.en.inf" .\options.inf
chmod -cf 644 *.inf
zip -9 o:\xul\xpi\%appname%_en.xpi *.js *.light *.inf *.rdf *.cfg *.manifest
zip -9 -r o:\xul\xpi\%appname%_en.xpi chrome
zip -9 -r o:\xul\xpi\%appname%_en.xpi defaults



IF EXIST readme.txt GOTO COPYLZH
copy o:\xul\xpi\%appname%.xpi c:\apps\win\other\mozilla\_packages\%appname%_%DATES%.xpi.zip
GOTO COPYFILES

:COPYLZH
copy o:\xul\xpi\%appname%.lzh c:\apps\win\other\mozilla\_packages\%appname%_%DATES%.lzh



:COPYFILES

cd ..
rmdir "temp" /s /q


rem copy %appname%.jar C:\Apps\Win\Other\Mozilla\bin\chrome\%appname%.jar
rem copy %appname%.jar C:\Apps\Win\Other\Mozilla\bin16\chrome\%appname%.jar
rem copy %appname%.jar "C:\Apps\Win\Other\Netscape\Netscape 7\chrome\%appname%.jar"

endlocal