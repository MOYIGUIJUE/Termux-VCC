<!-- :
@echo off
for /f "delims=" %%a in ('mshta "%~f0"') do set %1=%%a
exit /b
-->

<script>
var Shell = new ActiveXObject("Shell.Application");
var Folder = Shell.BrowseForFolder(0, "��ѡ���ļ���", 0); //��ʼĿ¼Ϊ������
if (Folder != null) {
    Folder = Folder.items();
    Folder = Folder.item();
    Folder = Folder.Path;
    new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).Write(Folder);
}
close();
</script>