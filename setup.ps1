# Script de setup pour LockHeaven (Windows PowerShell)
# Ce script configure et démarre tous les services nécessaires

$ErrorActionPreference = "Stop"

Write-Host "🚀 Configuration de LockHeaven" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Vérifier les prérequis
Write-Host "📋 Vérification des prérequis..." -ForegroundColor Yellow

# Node.js
try {
    $nodeVersion = node --version
    Write-Host "✅ Node.js $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Node.js n'est pas installé" -ForegroundColor Red
    Write-Host "Installer Node.js depuis https://nodejs.org/" -ForegroundColor Yellow
    exit 1
}

# npm
try {
    $npmVersion = npm --version
    Write-Host "✅ npm $npmVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ npm n'est pas installé" -ForegroundColor Red
    exit 1
}

# Docker
$useDocker = $true
try {
    $dockerVersion = docker --version
    Write-Host "✅ Docker $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "⚠️  Docker n'est pas installé" -ForegroundColor Yellow
    Write-Host "Vous pouvez continuer sans Docker, mais certaines fonctionnalités seront limitées" -ForegroundColor Yellow
    $response = Read-Host "Continuer sans Docker? (y/n)"
    if ($response -ne "y") {
        exit 1
    }
    $useDocker = $false
}

# Docker Compose
if ($useDocker) {
    try {
        $composeVersion = docker-compose --version
        Write-Host "✅ Docker Compose $composeVersion" -ForegroundColor Green
    } catch {
        Write-Host "⚠️  Docker Compose n'est pas installé" -ForegroundColor Yellow
        $useDocker = $false
    }
}

Write-Host ""
Write-Host "📦 Installation des dépendances..." -ForegroundColor Yellow

# Backend
Write-Host "Installation des dépendances backend..." -ForegroundColor Cyan
Set-Location backend
npm install
Set-Location ..
Write-Host "✅ Backend dependencies installées" -ForegroundColor Green

# Frontend
Write-Host "Installation des dépendances frontend..." -ForegroundColor Cyan
Set-Location frontend
npm install
Set-Location ..
Write-Host "✅ Frontend dependencies installées" -ForegroundColor Green

Write-Host ""
Write-Host "⚙️  Configuration des variables d'environnement..." -ForegroundColor Yellow

# Créer .env pour le backend si n'existe pas
if (-not (Test-Path "backend\.env")) {
    # Générer un secret JWT aléatoire
    $jwtSecret = [Convert]::ToBase64String((1..32 | ForEach-Object { Get-Random -Minimum 0 -Maximum 256 }))
    
    $envContent = @"
PORT=5000
NODE_ENV=development

# MongoDB
MONGODB_URI=mongodb://localhost:27017/mayan-edms

# JWT
JWT_SECRET=$jwtSecret
JWT_EXPIRE=7d

# Mayan EDMS
MAYAN_API_URL=http://localhost:8082/api
MAYAN_USERNAME=admin
MAYAN_PASSWORD=admin

# AI Service (Qwen3)
AI_SERVICE_URL=http://localhost:11434
AI_MODEL=qwen:4b

# CORS
CORS_ORIGIN=http://localhost:3000
"@
    
    Set-Content -Path "backend\.env" -Value $envContent
    Write-Host "✅ Fichier backend\.env créé" -ForegroundColor Green
} else {
    Write-Host "⚠️  backend\.env existe déjà" -ForegroundColor Yellow
}

Write-Host ""
if ($useDocker) {
    Write-Host "🐳 Démarrage des services Docker..." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Cette opération peut prendre plusieurs minutes la première fois." -ForegroundColor Cyan
    Write-Host ""
    
    $response = Read-Host "Démarrer les services avec Docker? (y/n)"
    if ($response -eq "y") {
        docker-compose up -d
        
        Write-Host ""
        Write-Host "⏳ Attente du démarrage des services (30 secondes)..." -ForegroundColor Yellow
        Start-Sleep -Seconds 30
        
        Write-Host ""
        Write-Host "📥 Téléchargement du modèle IA Qwen3 (peut prendre du temps)..." -ForegroundColor Yellow
        docker exec -it mayan-ollama ollama pull qwen:4b
    }
} else {
    Write-Host "📝 Services à démarrer manuellement:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1. MongoDB:"
    Write-Host "   mongod --dbpath .\data\db"
    Write-Host ""
    Write-Host "2. Ollama (IA):"
    Write-Host "   ollama serve"
    Write-Host "   ollama pull qwen:4b"
    Write-Host ""
    Write-Host "3. Mayan EDMS:"
    Write-Host "   cd mayan-edms\docker"
    Write-Host "   docker-compose --profile all_in_one --profile postgresql --profile redis --profile rabbitmq up -d"
    Write-Host ""
}

Write-Host ""
Write-Host "✅ Configuration terminée!" -ForegroundColor Green
Write-Host ""
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
Write-Host "🎉 PRÊT À DÉMARRER" -ForegroundColor Green
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pour démarrer l'application:" -ForegroundColor Yellow
Write-Host ""
Write-Host "Terminal 1 - Backend:" -ForegroundColor Cyan
Write-Host "  cd backend"
Write-Host "  npm run dev"
Write-Host ""
Write-Host "Terminal 2 - Frontend:" -ForegroundColor Cyan
Write-Host "  cd frontend"
Write-Host "  npm run dev"
Write-Host ""
Write-Host "Accès aux applications:" -ForegroundColor Yellow
Write-Host "  🌐 Frontend:    http://localhost:3000"
Write-Host "  🔌 Backend API: http://localhost:5000"
Write-Host "  📁 Mayan EDMS:  http://localhost:8082"
Write-Host ""
Write-Host "Comptes par défaut:" -ForegroundColor Yellow
Write-Host "  👤 Admin: admin@example.com / admin123"
Write-Host "  👤 User:  user@example.com / user123"
Write-Host ""
Write-Host "Documentation:" -ForegroundColor Yellow
Write-Host "  📖 README:      .\README.md"
Write-Host "  📖 Frontend:    .\frontend\README.md"
Write-Host "  📖 Backend:     .\backend\README.md"
Write-Host ""
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan

