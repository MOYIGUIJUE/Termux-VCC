Set WshShell = WScript.CreateObject("WScript.Shell") 
If WScript.Arguments.Length = 0 Then
  Set ObjShell = CreateObject("Shell.Application") 
  ObjShell.ShellExecute "wscript.exe" _ 
  , """" & WScript.ScriptFullName & """ RunAsAdministrator", , "runas", 1 
  WScript.Quit 
End if
dim a
a=0
Set W=CreateObject("Wscript.Shell")
Do
If W.AppActivate("���������") Then 
'Wscript.Sleep 1000
Msgbox "��������ռ�ã��Ƿ�������л�����"
W.run "taskill -f -im Taskmgr.exe"
else

end if
Wscript.Sleep 1000
a=a+1
Loop Until a=20
'Loop Until Msgbox("y",4)=Vbyes
