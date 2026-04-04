#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     🚀 Deraya-Edge Quick Start         ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Check if node is installed
if ! command -v node &> /dev/null; then
  echo -e "${RED}❌ Node.js is not installed. Please install Node.js 16+${NC}"
  exit 1
fi

echo -e "${GREEN}✓ Node.js found: $(node --version)${NC}"
echo ""

# Check if dependencies are installed
echo -e "${YELLOW}📦 Checking frontend dependencies...${NC}"
if [ ! -d "node_modules" ]; then
  echo -e "${YELLOW}Installing frontend dependencies...${NC}"
  npm install
else
  echo -e "${GREEN}✓ Frontend dependencies already installed${NC}"
fi

echo ""
echo -e "${YELLOW}📦 Checking backend dependencies...${NC}"
if [ ! -d "server/node_modules" ]; then
  echo -e "${YELLOW}Installing backend dependencies...${NC}"
  cd server
  npm install
  cd ..
else
  echo -e "${GREEN}✓ Backend dependencies already installed${NC}"
fi

echo ""

# Check for .env files
if [ ! -f ".env.development.local" ]; then
  echo -e "${YELLOW}⚠️  .env.development.local not found${NC}"
  echo -e "${YELLOW}Copying from .env.example...${NC}"
  if [ -f ".env.example" ]; then
    cp .env.example .env.development.local
    echo -e "${GREEN}✓ Created .env.development.local${NC}"
  else
    echo -e "${YELLOW}Note: You need to add environment variables manually${NC}"
  fi
fi

if [ ! -f "server/.env.development.local" ]; then
  echo -e "${YELLOW}⚠️  server/.env.development.local not found${NC}"
  cat > server/.env.development.local << 'EOF'
PORT=5000
JWT_SECRET=deraya_dev_secret_key_change_in_production
FRONTEND_URL=http://localhost:8080
EOF
  echo -e "${GREEN}✓ Created server/.env.development.local${NC}"
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ✅ Setup Complete!                   ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}📝 Next Steps:${NC}"
echo ""
echo -e "${YELLOW}1️⃣  Open two terminal windows:${NC}"
echo ""
echo -e "   ${BLUE}Terminal 1 - Frontend:${NC}"
echo -e "   ${GREEN}npm run dev${NC}"
echo ""
echo -e "   ${BLUE}Terminal 2 - Backend:${NC}"
echo -e "   ${GREEN}cd server && npm start${NC}"
echo ""
echo -e "${YELLOW}2️⃣  Open your browser and visit:${NC}"
echo -e "   ${GREEN}http://localhost:8080${NC}"
echo ""
echo -e "${YELLOW}3️⃣  For more information:${NC}"
echo -e "   📖 SETUP_GUIDE.md - Complete setup guide"
echo -e "   🔧 TROUBLESHOOTING.md - Common issues and solutions"
echo ""
echo -e "${BLUE}Happy coding! 🎉${NC}"
