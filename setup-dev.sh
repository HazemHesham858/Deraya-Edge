#!/bin/bash

echo "🛠️ Setting up development environment..."

# Install frontend dependencies
echo "📦 Installing frontend dependencies..."
npm install

# Install server dependencies
echo "📦 Installing server dependencies..."
cd server
npm install
cd ..

# Create .env files if they don't exist
if [ ! -f .env.development.local ]; then
  echo "Creating .env.development.local..."
  cp .env.example .env.development.local 2>/dev/null || echo "Note: .env.example not found"
fi

if [ ! -f server/.env.development.local ]; then
  echo "Creating server/.env.development.local..."
  cat > server/.env.development.local << 'EOF'
PORT=5000
JWT_SECRET=deraya_dev_secret_key_change_in_production
FRONTEND_URL=http://localhost:8080
EOF
fi

echo "✅ Development environment setup complete!"
echo ""
echo "📝 Next steps:"
echo "1. In one terminal, run: npm run dev"
echo "2. In another terminal, run: cd server && npm start"
echo ""
echo "Frontend will be available at: http://localhost:8080"
echo "Backend API will be available at: http://localhost:5000/api"
