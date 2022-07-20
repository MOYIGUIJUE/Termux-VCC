'for i=1 to 3
randomize
set fso=createobject("scripting.filesystemobject") 
set a=createobject("scripting.dictionary") 
set file=fso.opentextfile("name.txt") 
do while file.atendofstream<>true 
m=m+1 
a.add m,file.readline 
loop
file.close
h=int(rnd*m)
do while(h=0)
	if h=0 then 
		h=int(rnd*m)
	else
		exit do
	end if
loop
msgbox "第" & h & "行:" & a(h) ,4096,"随机内容"
m=0
'next
' 用于粘贴到剪切板
' Set objIE = CreateObject("InternetExplorer.Application")
' objIE.Navigate("about:blank")
' objIE.Document.ParentWindow.ClipboardData.SetData "text", "第" & h & "行: " & a(h)
' objIE.Quit