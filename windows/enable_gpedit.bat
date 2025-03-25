@echo off
echo Installing Group Policy Editor packages...
FOR %%F IN ("%SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~*.mum") DO (
    DISM /Online /NoRestart /Add-Package:"%%F"
)
FOR %%F IN ("%SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~*.mum") DO (
    DISM /Online /NoRestart /Add-Package:"%%F"
)
echo Installation complete.
pause
