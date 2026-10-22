@echo off
chcp 65001 > nul
cd /d "%~dp0"
where gradle >nul 2>nul
if errorlevel 1 (
  echo [ERROR] 未找到 Gradle。请安装 Android Studio + Gradle 8.10.2，或改用 GitHub Actions 云编译。
  pause
  exit /b 1
)
call gradle --no-daemon assembleDebug
if errorlevel 1 (
  echo [ERROR] 编译失败，请查看上方错误。
) else (
  echo [OK] APK 文件：app\build\outputs\apk\debug\app-debug.apk
)
pause
