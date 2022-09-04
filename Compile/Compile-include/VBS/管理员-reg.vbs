Set WshShell = WScript.CreateObject("WScript.Shell") 
If WScript.Arguments.Length = 0 Then
  Set ObjShell = CreateObject("Shell.Application") 
  ObjShell.ShellExecute "wscript.exe" _ 
  , """" & WScript.ScriptFullName & """ RunAsAdministrator", , "runas", 1 
  WScript.Quit 
End if

' Create a WSH Shell object: 
Set wshShell = CreateObject("WScript.Shell")
' 
' Create a new key: 
wshShell.RegWrite "HKCR\.bat\", "batfile"
 
' Create a new DWORD value: 
' wshShell.RegWrite "HKCR\TestKey\DWordTestValue", 1, "REG_DWORD"
 
' Create a new subkey and a string value in that new subkey: 
' wshShell.RegWrite "HKCR\TestKey\SubKey\StringTestValue", "Test", "REG_SZ"
 
' Read the values we just created: 
' WScript.Echo "HKCR\TestKey\DWordTestValue = " _ 
' & wshShell.RegRead( "HKCR\TestKey\DWordTestValue" ) 
' WScript.Echo "HKCR\TestKey\SubKey\StringTestValue = """ _ 
' & wshShell.RegRead( "HKCR\TestKey\SubKey\StringTestValue" ) & """"
 
' Delete the subkey and key and the values they contain: 
' wshShell.RegDelete "HKCR\TestKey\SubKey\" 
' wshShell.RegDelete "HKCR\TestKey\" 
 

' use the WSH Shell object to delete an entire "tree" unless you 
' know the exact name of every subkey. 
' If you don't, use the WMI StdRegProv instead. 
 
' Release the object 
Set wshShell = Nothing