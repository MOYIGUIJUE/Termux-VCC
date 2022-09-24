@echo off
for %%i in (*.db) do sqlite3.exe -column -header -cmd ".tables" %%i

echo;.header on >sqlite.sql
echo;.mode column >>sqlite.sql
echo;.tables >>sqlite.sql
for /f %%i in ('sqlite3.exe test.db ^< sqlite.sql') do (
	echo;select * from %%i; >>sqlite.sql
)
sqlite3.exe test.db < sqlite.sql
REM sqlite3.exe -cmd ".read sqlite.sql" test.db
del sqlite.sql