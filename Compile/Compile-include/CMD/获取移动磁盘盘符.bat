@echo off
set "pan="
>"%tmp%\$t.js" echo;try{WSH.echo(WSH.StdIn.ReadAll().replace(/\s*[\r\n]+/g,'\r\n'))}catch(e){}
for /f "tokens=1* delims==" %%a in ('wmic DiskDrive where "InterfaceType='USB'" get Index /value^|find "="^|cscript -nologo -e:jscript "%tmp%\$t.js"') do (
    for /f "tokens=1,2* delims==" %%c in ('wmic path Win32_LogicalDiskToPartition get Antecedent^,Dependent^|find "Disk #%%b,"^|cscript -nologo -e:jscript "%tmp%\$t.js"') do (
        set pan=%%~e
		echo %%~e
    )
)
echo;%pan%
pause