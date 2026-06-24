@echo off
set /p MESSAGE=コミットメッセージ：
git add .
git commit -m "%MESSAGE%"
git push
pause
