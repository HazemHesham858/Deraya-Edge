@echo off
setlocal enabledelayedexpansion

cls
echo.
echo ============================================
echo.
echo      Deraya-Edge Quick Start
echo.
echo ============================================
echo.

REM Check if node is installed
node --version >nul 2>&1
if errorlevel 1 (
  echo ERROR: Node.js is not installed. Please install Node.js 16+ first.
  pause
  exit /b 1
)

echo Node.js found: 
node --version
echo.

REM Check frontend dependencies
echo Checking frontend dependencies...
if not exist "node_modules" (
  echo Installing frontend dependencies...
  call npm install
) else (
  echo Frontend dependencies already installed
)

echo.

REM Check backend dependencies
echo Checking backend dependencies...
if not exist "server\node_modules" (
  echo Installing backend dependencies...
  cd server
  call npm install
  cd ..
) else (
  echo Backend dependencies already installed
)

echo.

REM Check for .env files
if not exist ".env.development.local" (
  echo NOTE: .env.development.local not found
  if exist ".env.example" (
    copy .env.example .env.development.local
    echo Created .env.development.local
  )
)

if not exist "server\.env.development.local" (
  (
    echo PORT=5000
    echo JWT_SECRET=deraya_dev_secret_key_change_in_production
    echo FRONTEND_URL=http://localhost:8080
  ) > "server\.env.development.local"
  echo Created server\.env.development.local
)

echo.
echo ============================================
echo      Setup Complete!
echo ============================================
echo.
echo NEXT STEPS:
echo.
echo 1. Open TWO command prompts/PowerShell windows
echo.
echo    Terminal 1 - Frontend:
echo    npm run dev
echo.
echo    Terminal 2 - Backend:
echo    cd server
echo    npm start
echo.
echo 2. Open your browser:
echo    http://localhost:8080
echo.
echo 3. For more info, read:
echo    - SETUP_GUIDE.md
echo    - TROUBLESHOOTING.md
echo.
echo Happy coding!
echo.
pause
