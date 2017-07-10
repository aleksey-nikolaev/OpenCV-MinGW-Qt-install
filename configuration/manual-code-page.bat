reg query "HKCU\Software\Microsoft\Command Processor" /v Autorun
choice /c 0123 /m "0-delete, 1- 866, 2- 1251, 3-65001"

if "%ERRORLEVEL%" == "1" reg delete "HKCU\Software\Microsoft\Command Processor" /v Autorun /f
if "%ERRORLEVEL%" == "2" reg add "HKCU\Software\Microsoft\Command Processor" /v Autorun /f /d "chcp 866"
if "%ERRORLEVEL%" == "3" reg add "HKCU\Software\Microsoft\Command Processor" /v Autorun /f /d "chcp 1251"
if "%ERRORLEVEL%" == "4" reg add "HKCU\Software\Microsoft\Command Processor" /v Autorun /f /d "chcp 65001"
pause