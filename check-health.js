#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

console.log('\n🔍 Deraya-Edge Health Check\n');

// Colors
const colors = {
  reset: '\x1b[0m',
  red: '\x1b[31m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
};

const log = {
  success: (msg) => console.log(`${colors.green}✓${colors.reset} ${msg}`),
  error: (msg) => console.log(`${colors.red}✗${colors.reset} ${msg}`),
  warn: (msg) => console.log(`${colors.yellow}⚠${colors.reset}  ${msg}`),
  info: (msg) => console.log(`${colors.blue}ℹ${colors.reset}  ${msg}`),
};

let issues = [];

// 1. Check Node.js version
const nodeVersion = process.version;
const majorVersion = parseInt(nodeVersion.split('.')[0].slice(1));
console.log(`${colors.blue}═══════════════════════════════════${colors.reset}`);
console.log(`${colors.blue}System Information${colors.reset}`);
console.log(`${colors.blue}═══════════════════════════════════${colors.reset}\n`);

if (majorVersion >= 16) {
  log.success(`Node.js version: ${nodeVersion}`);
} else {
  log.error(`Node.js version: ${nodeVersion} (requires 16+)`);
  issues.push('Node.js version is too old');
}

// 2. Check npm
const npmVersion = require('child_process')
  .execSync('npm --version')
  .toString()
  .trim();
log.success(`npm version: ${npmVersion}`);

// 3. Check directory structure
console.log(`\n${colors.blue}═══════════════════════════════════${colors.reset}`);
console.log(`${colors.blue}Project Structure${colors.reset}`);
console.log(`${colors.blue}═══════════════════════════════════${colors.reset}\n`);

const dirs = {
  'src': './src',
  'server': './server',
  'public': './public',
  'node_modules': './node_modules',
  'server/node_modules': './server/node_modules',
};

for (const [name, dir] of Object.entries(dirs)) {
  if (fs.existsSync(dir)) {
    log.success(`${name} directory exists`);
  } else {
    log.warn(`${name} directory missing`);
    if (name === 'node_modules' || name === 'server/node_modules') {
      log.info('Run: npm install && cd server && npm install && cd ..');
    }
  }
}

// 4. Check important files
console.log(`\n${colors.blue}═══════════════════════════════════${colors.reset}`);
console.log(`${colors.blue}Configuration Files${colors.reset}`);
console.log(`${colors.blue}═══════════════════════════════════${colors.reset}\n`);

const files = {
  'package.json': './package.json',
  'vite.config.ts': './vite.config.ts',
  'tsconfig.json': './tsconfig.json',
  'server/package.json': './server/package.json',
  'server/server.js': './server/server.js',
};

for (const [name, file] of Object.entries(files)) {
  if (fs.existsSync(file)) {
    log.success(`${name} exists`);
  } else {
    log.error(`${name} missing`);
    issues.push(`Missing file: ${name}`);
  }
}

// 5. Check environment files
console.log(`\n${colors.blue}═══════════════════════════════════${colors.reset}`);
console.log(`${colors.blue}Environment Configuration${colors.reset}`);
console.log(`${colors.blue}═══════════════════════════════════${colors.reset}\n`);

if (fs.existsSync('.env.development.local')) {
  log.success('.env.development.local exists');
} else {
  log.warn('.env.development.local missing');
  log.info('Copy .env.example to .env.development.local and update values');
}

if (fs.existsSync('server/.env.development.local')) {
  log.success('server/.env.development.local exists');
} else {
  log.warn('server/.env.development.local missing');
  log.info('Create with: PORT=5000, JWT_SECRET=..., FRONTEND_URL=...');
}

// 6. Check key dependencies
console.log(`\n${colors.blue}═══════════════════════════════════${colors.reset}`);
console.log(`${colors.blue}Dependencies Check${colors.reset}`);
console.log(`${colors.blue}═══════════════════════════════════${colors.reset}\n`);

const packageJson = require('./package.json');
const serverPackageJson = require('./server/package.json');

const keyDeps = ['react', 'react-router-dom', 'vite'];
const keyServerDeps = ['express', 'bcrypt', 'sequelize', 'jsonwebtoken'];

let allDepsPresent = true;

for (const dep of keyDeps) {
  if (packageJson.dependencies[dep] || packageJson.devDependencies[dep]) {
    log.success(`${dep} is configured`);
  } else {
    log.error(`${dep} is missing`);
    allDepsPresent = false;
  }
}

for (const dep of keyServerDeps) {
  if (serverPackageJson.dependencies[dep]) {
    log.success(`${dep} (server) is configured`);
  } else {
    log.error(`${dep} (server) is missing`);
    allDepsPresent = false;
  }
}

// Summary
console.log(`\n${colors.blue}═══════════════════════════════════${colors.reset}`);
console.log(`${colors.blue}Summary${colors.reset}`);
console.log(`${colors.blue}═══════════════════════════════════${colors.reset}\n`);

if (issues.length === 0 && allDepsPresent) {
  console.log(`${colors.green}✓ All checks passed!${colors.reset}`);
  console.log('\nYou can now run:');
  console.log(`  ${colors.yellow}npm run dev${colors.reset}          (Terminal 1 - Frontend)`);
  console.log(`  ${colors.yellow}cd server && npm start${colors.reset} (Terminal 2 - Backend)\n`);
} else {
  console.log(`${colors.red}✗ Some issues found:${colors.reset}\n`);
  issues.forEach(issue => log.error(issue));
  console.log('\nPlease fix these issues before running the application.\n');
}

console.log(`${colors.blue}═══════════════════════════════════${colors.reset}\n`);
