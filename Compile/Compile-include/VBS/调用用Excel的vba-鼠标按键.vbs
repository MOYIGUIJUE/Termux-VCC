Option Explicit
Dim WshShell
Dim oExcel, oBook, oModule
Dim strRegKey, strCode, x, y
Set oExcel = CreateObject("Excel.Application") '���� Excel ����
set WshShell = CreateObject("wscript.Shell")
strRegKey = "HKEY_CURRENT_USER\Software\Microsoft\Office\$\Excel\Security\AccessVBOM"
strRegKey = Replace(strRegKey, "$", oExcel.Version)
WshShell.RegWrite strRegKey, 1, "REG_DWORD"
Set oBook = oExcel.Workbooks.Add '��ӹ�����
Set oModule = obook.VBProject.VBComponents.Add(1) '���ģ��
strCode = _
"'Author: Demon"            & vbCrLf & _
"Private Type POINTAPI : X As Long : Y As Long : End Type"                                                                                                                            & vbCrLf & _
"Private Declare Function SetCursorPos Lib ""user32"" (ByVal x As Long, ByVal y As Long) As Long"                                                                                     & vbCrLf & _
"Private Declare Function GetCursorPos Lib ""user32"" (lpPoint As POINTAPI) As Long"                                                                                                  & vbCrLf & _
"Private Declare Sub mouse_event Lib ""user32"" Alias ""mouse_event"" (ByVal dwFlags As Long, ByVal dx As Long, ByVal dy As Long, ByVal cButtons As Long, ByVal dwExtraInfo As Long)" & vbCrLf & _
"Public Function GetXCursorPos() As Long"                                                                                                                                             & vbCrLf & _
    "Dim pt As POINTAPI : GetCursorPos pt : GetXCursorPos = pt.X"                                                                                                                     & vbCrLf & _
"End Function"                                                                                                                                                                        & vbCrLf & _
"Public Function GetYCursorPos() As Long"                                                                                                                                             & vbCrLf & _
    "Dim pt As POINTAPI: GetCursorPos pt : GetYCursorPos = pt.Y"                                                                                                                      & vbCrLf & _
"End Function"
oModule.CodeModule.AddFromString strCode '��ģ������� VBA ����
'Author: Demon
x = oExcel.Run("GetXCursorPos") '��ȡ��� X ����
y = oExcel.Run("GetYCursorPos") '��ȡ��� Y ����
WScript.Echo x, y
oExcel.Run "SetCursorPos", 300, 300 '������� X Y ����
Const MOUSEEVENTF_MOVE       = &H1
Const MOUSEEVENTF_LEFTDOWN   = &H2
Const MOUSEEVENTF_LEFTUP     = &H4
Const MOUSEEVENTF_RIGHTDOWN  = &H8
Const MOUSEEVENTF_RIGHTUP    = &H10
Const MOUSEEVENTF_MIDDLEDOWN = &H20
Const MOUSEEVENTF_MIDDLEUP   = &H40
Const MOUSEEVENTF_ABSOLUTE   = &H8000
'ģ������������
oExcel.Run "mouse_event", MOUSEEVENTF_LEFTDOWN + MOUSEEVENTF_LEFTUP, 0, 0, 0, 0
'ģ��������˫���������ٵ����ε�����
'oExcel.Run "mouse_event", MOUSEEVENTF_LEFTDOWN + MOUSEEVENTF_LEFTUP, 0, 0, 0, 0
'oExcel.Run "mouse_event", MOUSEEVENTF_LEFTDOWN + MOUSEEVENTF_LEFTUP, 0, 0, 0, 0
'ģ������Ҽ�����
'oExcel.Run "mouse_event", MOUSEEVENTF_RIGHTDOWN + MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0
'ģ������м�����
'oExcel.Run "mouse_event", MOUSEEVENTF_MIDDLEDOWN + MOUSEEVENTF_MIDDLEUP, 0, 0, 0, 0
'�ر� Excel

'wscript.sleep 500
'wscript.createobject("wscript.shell").SendKeys "v"
'wscript.sleep 500
'wscript.createobject("wscript.shell").SendKeys "~"
'script.sleep 500
'wscript.createobject("wscript.shell").SendKeys "d"
'wscript.sleep 500
'wscript.createobject("wscript.shell").SendKeys "~"
oExcel.DisplayAlerts = False
oBook.Close
oExcel.Quit