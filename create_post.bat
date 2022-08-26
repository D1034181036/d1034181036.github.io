@echo off
set /p title="Enter article title: "
hugo new post/%title%/index.md
pause()