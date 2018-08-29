@ECHO OFF

REM Parameters:
SET source=P:\
SET dest=Q:\7zBackup
SET password=%BACKUP_KEY%

REM Validate parameters.
IF "%password%"=="" GOTO MISSING_BACKUP_KEY
IF NOT EXIST %source% GOTO MISSING_SOURCE_DIR
IF NOT EXIST %dest% GOTO MISSING_DEST_DIR

REM Backup rotation.
SET tempFolder=%dest%\Temp
MKDIR %tempFolder%
MKDIR Q:\7zBackup
ROBOCOPY Q:\7zBackup\ %tempFolder% /move /minage:60
RMDIR /s /q %tempFolder%

REM Backup procedure.

REM Determine a unique filename.
SET year=%date:~-4,4%
SET month=%date:~-10,2%
SET day=%date:~-7,2%
SET hour=%time:~-11,2%
SET hour=%hour: =0%
SET min=%time:~-8,2%
SET zipfilename=backup.%year%.%month%.%day%.%hour%.%min%.zip
SET dest=%dest%\%zipfilename%

REM Determine if 7zip is installed.
SET AppExePath="%ProgramFiles%\7-Zip\7z.exe"
IF NOT EXIST %AppExePath% SET AppExePath="%ProgramFiles(x86)%\7-Zip\7z.exe"
IF NOT EXIST %AppExePath% GOTO NOTINSTALLED

REM Calling 7zip.
ECHO Backup %source%

REM 7zip options:
REM u    = update command
REM -t7z = use 7zip format
REM -mx5 = use default compression (values: mx0, mx1, mx3, mx5, mx7, mx9)
REM -p   = use the specified password
REM -mhe = enables or disables archive header encryption
REM -mmt = enable multithreading
%AppExePath% u -t7z -mx0 -p"%password%" -mhe=on -mmt=on "%dest%" "%source%" -y
ECHO Backup completed.
GOTO :EOF

:MISSING_BACKUP_KEY
ECHO Please set the BACKUP_KEY environment variable.
PAUSE
GOTO :EOF

:MISSING_SOURCE_DIR
ECHO The source directory doesn't exists!
PAUSE
GOTO :EOF

:MISSING_DEST_DIR
ECHO The destination directory doesn't exists!
PAUSE
GOTO :EOF
:NOTINSTALLED
ECHO Cannot find 7-Zip, please install it from: http://7-zip.org/
PAUSE
