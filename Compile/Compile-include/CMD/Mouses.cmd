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
Echo(�����﷨����ȷ��
@Exit /b

:Mouse_Help
Echo(���������ļ��������д����н�����������
Echo(
Echo(Mouse_Key [-I] [-V] [-F] [-H]
Echo(
Echo(-I    ��װMouse.exe�Գ�ʼ��,���������������
Echo(
Echo(-V    ������������Ϣ���浽�����С�
Echo(      �������ӿ����а�����
Echo(
Echo(      Mouse_Key -V ^<Var_1^> ^<Var_2^> ^<Var_3^>
Echo(
Echo(      Var_1   ����굥������Ϣ�����ڴ˱���� 1 Ϊ��������� 2 Ϊ�Ҽ�������
Echo(      Var_2   ����굥�����е���Ϣ�����ڴ˱����
Echo(      Var_3   ����굥�����е���Ϣ�����ڴ˱����
Echo(
Echo(      ע�⣺
Echo(      1. ���������������Լ��ļ���������������������
Echo(
Echo(-F    ������������Ϣ���浽�ļ��С�
Echo(      �������ӿ����а�����
Echo(
Echo(      Mouse_Key -F ^<File_1^> ^<File_2^> ^<File_3^>
Echo(
Echo(      File_1  �����������Ϣ�����ڴ��ļ��
Echo(      File_2  ����굥������Ϣ�����ڴ��ļ�� 1 Ϊ��������� 2 Ϊ�Ҽ�������
Echo(      File_3  ����굥�����е���Ϣ�����ڴ��ļ��
Echo(      File_4  ����굥�����е���Ϣ�����ڴ��ļ��
Echo(
Echo(      ע�⣺
Echo(      1. �����������ļ���������������������
Echo(
Echo(-H    ��ʾ������Ϣ��
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