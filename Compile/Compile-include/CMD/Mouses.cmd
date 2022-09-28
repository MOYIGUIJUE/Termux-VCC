@Echo off
For %%I in (- / \ [ ] { } ` ~ , . @ # ; = + _) Do (
	If /i "%1"=="%%Ii" Goto :Mouse_Installs
)
If exist Mouse.exe (
	For %%I in (- / \ [ ] { } ` ~ , . @ # ; = + _) Do (
		If /i "%1"=="%%Iv" Goto :Mouse_Var
		If /i "%1"=="%%If" Goto :Mouse_File
	)
)
For %%I in (- / \ [ ] { } ` ~ , . @ # ; = + _) Do (
	If /i "%1"=="%%Ih" Goto :Mouse_Help
)
Echo(
Echo(命令语法不正确。
@Exit /b

:Mouse_Help
Echo(在批处理文件或命令行窗口中进行鼠标操作。
Echo(
Echo(Mouse_Key [-I] [-V] [-F] [-H]
Echo(
Echo(-I    安装Mouse.exe以初始化,并加载鼠标驱动。
Echo(
Echo(-V    将鼠标的驱动信息储存到变量中。
Echo(      以下例子可能有帮助：
Echo(
Echo(      Mouse_Key -V ^<Var_1^> ^<Var_2^> ^<Var_3^>
Echo(
Echo(      Var_1   将鼠标单击的信息储存在此变量里， 1 为左键单击， 2 为右键单击。
Echo(      Var_2   将鼠标单击的行的信息储存在此变量里。
Echo(      Var_3   将鼠标单击的列的信息储存在此变量里。
Echo(
Echo(      注意：
Echo(      1. 您的这三个变量以及文件名必须用引号括起来。
Echo(
Echo(-F    将鼠标的驱动信息储存到文件中。
Echo(      以下例子可能有帮助：
Echo(
Echo(      Mouse_Key -F ^<File_1^> ^<File_2^> ^<File_3^>
Echo(
Echo(      File_1  将鼠标驱动信息储存在此文件里。
Echo(      File_2  将鼠标单击的信息储存在此文件里， 1 为左键单击， 2 为右键单击。
Echo(      File_3  将鼠标单击的行的信息储存在此文件里。
Echo(      File_4  将鼠标单击的列的信息储存在此文件里。
Echo(
Echo(      注意：
Echo(      1. 您的这三个文件名必须用引号括起来。
Echo(
Echo(-H    显示帮助信息。
Echo(
@Exit /b

:Mouse_File <File_1> <File_2> <File_3>
For /F  "usebackq tokens=1,2,3 delims= " %%I in (`Mouse`) Do (
	Echo.%%I > "%~2"
	Echo.%%J > "%~3"
	Echo.%%K > "%~4"
)
@Exit /b

:Mouse_Var <Var_1> <Var_2> <Var_3>
For /F  "usebackq tokens=1,2,3 delims= " %%I in (`Mouse`) Do (
	Set "%~2=%%I"
	Set "%~3=%%J"
	Set "%~4=%%K"
)
@Exit /b

:Mouse_Installs
( 
Echo(-----BEGIN CERTIfICATE----- 
Echo(TVqQAAMAAAAEAAAA//8AALgAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 
Echo(AAAAAAAAAAAAAAAAgAAAAA4fug4AtAnNIbgBTM0hVGhpcyBwcm9ncmFtIGNhbm5v 
Echo(dCBiZSBydW4gaW4gRE9TIG1vZGUuDQ0KJAAAAAAAAABQRQAATAECAAAAAAAAAAAA 
Echo(AAAAAOAADwMLAQYAAAAAAAAAAAAAAAAAQBEAAAAQAAAAIAAAAABAAAAQAAAAAgAA 
Echo(BAAAAAAAAAAEAAAAAAAAAFAhAAAAAgAAAAAAAAMAAAAAABAAABAAAAAAEAAAEAAA 
Echo(AAAAABAAAAAAAAAAAAAAACAgAAA8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 
Echo(AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 
Echo(AAAAAAAAAABcIAAALAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC50ZXh0AAAA 
Echo(ABAAAAAQAAAAAgAAAAIAAAAAAAAAAAAAAAAAACAAAGAuZGF0YQAAAFABAAAAIAAA 
Echo(UgEAAAAEAAAAAAAAAAAAAAAAAABAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 
Echo(AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABVieWB7AgAAACQjUX6UOgs 
Echo(AAAAg8QED79F/FAPv0X+UA++RfpQuAAgQABQ6IgBAACDxBC4AAAAAOkAAAAAycNV 
Echo(ieWB7CQAAACQuPb///9Q6GwBAACJRfy4AAAAAIlF3I1F+FCLRfxQ6FwBAACLRfiD 
Echo(yBCD4L+D4N9Qi0X8UOhOAQAAi0XchcAPhAUAAADpnAAAAI1F9FC4AQAAAFCNReBQ 
Echo(i0X8UOgvAQAAD7dF4IP4Ag+FcwAAAItF6IP4AbgAAAAAD5TAiUXchcAPhA8AAACL 
Echo(RQi5AQAAAIgI6SMAAACLReiD+AK4AAAAAA+UwIlF3IXAD4QKAAAAi0UIuQIAAACI 
Echo(CItF3IXAD4QdAAAAi0UIg8ACD79N5GaJCItFCIPAAoPAAg+/TeZmiQjpVP///4tF 
Echo(+FCLRfxQ6JUAAADJwwAAAFWJ5YHsFAAAAJC4AAAAAIlF7LgAAAMAULgAAAEAUOh9 
Echo(AAAAg8QIuAEAAABQ6HcAAACDxASNRexQuAAAAABQjUX0UI1F+FCNRfxQ6GEAAACD 
Echo(xBSLRfRQi0X4UItF/FDoXf7//4PEDIlF8ItF8FDoRgAAAIPEBMnDAP8lXCBAAAAA 
Echo(/yV0IEAAAAD/JXggQAAAAP8lfCBAAAAA/yWAIEAAAAD/JWAgQAAAAP8lZCBAAAAA 
Echo(/yVoIEAAAAD/JWwgQAAAACVkICVkICVkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 
Echo(iCAAAAAAAAAAAAAAtCAAAFwgAACgIAAAAAAAAAAAAAD9IAAAdCAAAAAAAAAAAAAA 
Echo(AAAAAAAAAAAAAAAAvyAAAMggAADVIAAA5iAAAPYgAAAAAAAACiEAABkhAAAqIQAA 
Echo(OyEAAAAAAAC/IAAAyCAAANUgAADmIAAA9iAAAAAAAAAKIQAAGSEAACohAAA7IQAA 
Echo(AAAAAG1zdmNydC5kbGwAAABwcmludGYAAABfY29udHJvbGZwAAAAX19zZXRfYXBw 
Echo(X3R5cGUAAABfX2dldG1haW5hcmdzAAAAZXhpdABrZXJuZWwzMi5kbGwAAABHZXRT 
Echo(dGRIYW5kbGUAAABHZXRDb25zb2xlTW9kZQAAAFNldENvbnNvbGVNb2RlAAAAUmVh 
Echo(ZENvbnNvbGVJbnB1dEEAAAAA 
Echo(-----END CERTIfICATE----- 
) > "Mouse.exe" 
If not exist "Mouse.exe" Call :Mouse_Installs
Certutil -Decode -f "Mouse.exe" "Mouse.exe" > nul 
If not exist "Mouse.exe" Call :Mouse_Installs
@Exit /b