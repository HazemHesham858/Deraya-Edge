#!/bin/bash

echo "🚀 Starting Deraya-Edge Build Process..."

# Install frontend dependencies
echo "📦 Installing frontend dependencies..."
npm install

# Build frontend
echo "🔨 Building frontend..."
npm run build

# Install server dependencies
echo "📦 Installing server dependencies..."
cd server
npm install
cd ..

echo "✅ Build completed successfully!"
echo "📝 To start the server, run: npm start"
