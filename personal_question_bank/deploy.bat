@echo off
REM 个性化题库系统 - Vercel部署脚本 (Windows)

echo 🚀 开始部署个性化题库系统到Vercel...

REM 检查是否安装了Vercel CLI
vercel --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Vercel CLI未安装
    echo 请运行: npm install -g vercel
    pause
    exit /b 1
)

REM 检查必需的文件
echo 📋 检查部署文件...

if not exist "vercel.json" (
    echo ❌ 缺少必需文件: vercel.json
    pause
    exit /b 1
)

if not exist "api\index.py" (
    echo ❌ 缺少必需文件: api\index.py
    pause
    exit /b 1
)

if not exist "requirements.txt" (
    echo ❌ 缺少必需文件: requirements.txt
    pause
    exit /b 1
)

if not exist "app.py" (
    echo ❌ 缺少必需文件: app.py
    pause
    exit /b 1
)

echo ✅ 所有必需文件存在

REM 登录检查
echo 🔐 检查Vercel登录状态...
vercel whoami >nul 2>&1
if %errorlevel% neq 0 (
    echo 请登录Vercel:
    vercel login
)

REM 环境变量提醒
echo.
echo ⚠️  请确保在Vercel控制台中设置了以下环境变量:
echo    - SECRET_KEY
echo    - DATABASE_URL
echo    - VERCEL=1
echo.

set /p confirm="是否已设置环境变量？(y/N): "
if /i not "%confirm%"=="y" (
    echo 请先在Vercel控制台中设置环境变量，然后重新运行此脚本
    pause
    exit /b 1
)

REM 部署到生产环境
echo 🚀 部署到生产环境...
vercel --prod

echo ✅ 部署完成！
echo 📱 你的应用现在可以通过Vercel提供的URL访问
echo 🔧 如有问题，请查看Vercel控制台的日志
pause
