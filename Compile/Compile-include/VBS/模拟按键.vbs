set wshshell=wscript.createobject("wscript.shell") 

wshshell.AppActivate"bat和vbs入门交流"

for i=1 to 2
wscript.sleep 80
wshshell.sendKeys "^v"

wshshell.sendKeys i

wshshell.sendKeys "%s"

next