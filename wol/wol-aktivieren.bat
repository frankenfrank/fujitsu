ECHO https://github.com/frankenfrank

@echo off
COLOR 1F
CLS

REM - - - - - START Anpassen
SET JOBNAME=biospwd
SET QUELLVERZEICHNIS=d:\Software\FTS_DeskViewx_BIOSSet
SET ZIELVERZEICHNIS=c$\_ld-install
SET COMPUTERLISTE=computerliste.txt
SET PROGRAMMAUFRUF=C:\_ld-install\BiosSet.exe /expert 0x0011=0x0002

REM - - - - - STOPP Anpassen


:EXECUTE
@echo off
for /F "delims=" %%x in (%~dp0%COMPUTERLISTE%) do (
	CLS
	TITLE %%x
	ECHO.
	ECHO CLIENT = %%x
	ECHO.
	IF NOT EXIST \\%%x\%ZIELVERZEICHNIS% MD \\%%x\%ZIELVERZEICHNIS% >NUL
	ECHO --^> Kopiere die notwendigen Dateien
 	robocopy /E %QUELLVERZEICHNIS% \\%%x\%ZIELVERZEICHNIS% /NJH /NJS /NS /R:1 /W:1 /NC /TEE /NP
	ECHO.
	ECHO --^> Starte Programm
	%~dp0psexec \\%%x cmd /c "%PROGRAMMAUFRUF%"
	:EOEXECUTE	
	TIMEOUT 3 >NUL
)

GOTO EOF


:EOF
TITLE fertig - %JOBNAME%
ECHO.
ECHO.
SET /P EOF=Taste zum beenden
EXIT
