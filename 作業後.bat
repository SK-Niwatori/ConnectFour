@echo off
set /p MESSAGE=Commit message:
git add .
git commit -m "%MESSAGE%"
git push
pause
