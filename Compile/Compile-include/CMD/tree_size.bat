Rem^ & @echo off 
Rem^ &cscript //NoLogo //E:VBScript "%~f0"
Rem^ &pause
Rem^ &goto :eof

Public fso, input_file, output_file
Public layer
Public Branch
call main
Sub main()
    ReDim Branch(1000)
    layer = 0
    Set fso = CreateObject("Scripting.FileSystemObject")
    ' 脚本对象 和 当前目录
    Set obj_wsc_shell = CreateObject("wscript.shell")
    HostFolder = obj_wsc_shell.CurrentDirectory & "\"
    ' HostFolder = ThisWorkbook.Path & "\"
    Call DoFolder(fso.GetFolder(HostFolder))
    wscript.Quit
End Sub
Sub DoFolder(Folder)
    Dim i
    pref_str = ""
    For i = 1 To layer - 1
        pref_str = pref_str & Branch(i)
    Next
    If layer > 0 Then
        If Branch(layer) = "   " Then
            pref_str = pref_str & "  └─ "
        Else
            pref_str = pref_str & "  ├─ "
        End If
    End If
    wscript.echo  pref_str & Folder.Name
    ' Debug.Print pref_str & Folder.Name
    ' 在子目录中递归调用
    Dim SubFolder
    Dim count_SubFolders, cnt_SubFolder_or_file
    count_SubFolders = Folder.SubFolders.Count
    count_files = Folder.Files.Count
    count_SubFolders_and_files = count_SubFolders + count_files
    cnt_SubFolder_or_file = 0
    For Each SubFolder In Folder.SubFolders
        cnt_SubFolder_or_file = cnt_SubFolder_or_file + 1
        layer = layer + 1
        ' Branch 用于子对象
        If (cnt_SubFolder_or_file >= count_SubFolders_and_files) Then
            Branch(layer) = "   "
        Else
            Branch(layer) = "  │"
        End If
        Call DoFolder(SubFolder)
        layer = layer - 1
    Next
    Dim file
    For Each file In Folder.Files
        cnt_SubFolder_or_file = cnt_SubFolder_or_file + 1
        layer = layer + 1
        If (cnt_SubFolder_or_file >= count_SubFolders_and_files) Then
            Branch(layer) = "   "
        Else
            Branch(layer) = "  │"
        End If
        Call doFile(file)
        layer = layer - 1
    Next
End Sub
Sub doFile(ByRef input_file)
    Dim i
    pref_str = ""
    For i = 1 To layer - 1
        pref_str = pref_str & Branch(i)
    Next
    If layer > 0 Then
        If Branch(layer) = "   " Then
            pref_str = pref_str & "  └─ "
        Else
            pref_str = pref_str & "  ├─ "
        End If
    End If
    wscript.echo  pref_str & input_file.Name & " : " & input_file.Size & " Bytes"
End Sub