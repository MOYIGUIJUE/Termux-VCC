'-------------vbsTree.vbs------------------------
'描述:用vbs输出一个文件夹的目录结构。
'------------------------------------------------
Const Unit4Size = "字节KBMBGB"
Const OutFile = "OutTree.txt"
Dim TreePath,TreeStr,WS
Set WS = WScript.CreateObject("WScript.Shell")
TreePath = BFF("请选择需要列出子项目的路径",&H0001 + &H0008 + &H0010,"")
Set WS = Nothing
If Len(TreePath) = 0 Then WScript.Quit
If Len(TreePath) <= 3 Then MsgBox "无法处理根目录！",64,"提示":WScript.Quit

Dim objFSO
Set objFSO = CreateObject("Scripting.FileSystemObject")
TreeStr = TreePath & FormatSize(objFSO.GetFolder(TreePath).Size) & vbCrLf
Tree TreePath,""
Set objFile = objFSO.CreateTextFile(OutFile,True)
objFile.Write TreeStr
objFile.Close
Set objFile = Nothing
Set objFSO = Nothing
MsgBox "查看当前目录下的OutTree.txt",vbInformation,"完成 - vbsTree"
Sub Tree(Path,SFSpace)
    Dim i,TempStr,FlSpace
    FlSpace = SFSpace & "  "
    Set CrntFolder = objFSO.GetFolder(Path)
    i = 0:TempStr = "├─"
    For Each ConFile In CrntFolder.Files
        i = i + 1
        If i = CrntFolder.Files.Count And CrntFolder.SubFolders.Count = 0 Then TempStr = "└─"
        TreeStr = TreeStr & FlSpace & Tempstr & ConFile.name & FormatSize(ConFile.size) & vbCrLf
    Next
    i = 0:TempStr = "├─"
    For Each SubFolder In CrntFolder.SubFolders
        i = i + 1
        If i = CrntFolder.SubFolders.Count Then
            TempStr = "└─"
            SFSpace = FlSpace & "  "
        Else
            SFSpace = FlSpace & "│"
        End If
        TreeStr = TreeStr & FlSpace & TempStr & SubFolder.name & FormatSize(SubFolder.size) & vbCrLf
        Tree SubFolder,(SFSpace)
    Next
End Sub
Function FormatSize(SZ)
    Dim i
    Do While SZ > 1024
        i = i + 1
        SZ = SZ \ 1024
    Loop
    FormatSize = "  (" & SZ & Mid(Unit4Size,1 + 2 * i,2) & ")"
End Function


Function BFF(title, flag, dir)
On Error Resume Next
Dim oShell, oItem, oStr
Set oShell = WScript.CreateObject("Shell.Application")
Set oItem = oShell.BrowseForFolder(&H0, title, flag, dir)
oStr = oItem.Title 
If Err <> 0 Then
    Set oShell = Nothing
    Set oItem = Nothing
    Exit Function
End If

If InStr(oStr, ":") Then 
BFF = mid(oStr,InStr(oStr, ":")-1, 2)
    Else
        Select Case oStr
            Case "桌面"
                BFF = WS.SpecialFolders("Desktop")
            Case "我的文档"
                BFF = WS.SpecialFolders("MyDocuments")
            Case "我的电脑"
                MsgBox "无效目录！",64,"提示":WScript.Quit
            Case "网上邻居"
                MsgBox "无效目录！",64,"提示":WScript.Quit
            Case Else
             BFF = oItem.ParentFolder.ParseName(oItem.Title).Path
        End Select
    End If
Set oShell = Nothing
Set oItem = Nothing    
If Right(BFF,1)<> "\" Then
    BFF = BFF & "\"
End If
On Error GoTo 0
End Function