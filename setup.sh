#!/bin/bash

# Script de setup pour LockHeaven
# Ce script configure et démarre tous les services nécessaires

set -e

echo "🚀 Configuration de LockHeaven"
echo "=================================="
echo ""

# Couleurs pour l'output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Vérifier les prérequis
echo "📋 Vérification des prérequis..."

# Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js n'est pas installé${NC}"
    echo "Installer Node.js depuis https://nodejs.org/"
    exit 1
fi
echo -e "${GREEN}✅ Node.js $(node --version)${NC}"

# npm
if ! command -v npm &> /dev/null; then
    echo -e "${RED}❌ npm n'est pas installé${NC}"
    exit 1
fi
echo -e "${GREEN}✅ npm $(npm --version)${NC}"

# Docker
if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}⚠️  Docker n'est pas installé${NC}"
    echo "Vous pouvez continuer sans Docker, mais certaines fonctionnalités seront limitées"
    read -p "Continuer sans Docker? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
    USE_DOCKER=false
else
    echo -e "${GREEN}✅ Docker $(docker --version)${NC}"
    USE_DOCKER=true
fi

# Docker Compose
if [ "$USE_DOCKER" = true ]; then
    if ! command -v docker-compose &> /dev/null; then
        echo -e "${YELLOW}⚠️  Docker Compose n'est pas installé${NC}"
        USE_DOCKER=false
    else
        echo -e "${GREEN}✅ Docker Compose $(docker-compose --version)${NC}"
    fi
fi

echo ""
echo "📦 Installation des dépendances..."

# Backend
echo "Installing backend dependencies..."
cd backend
npm install
cd ..
echo -e "${GREEN}✅ Backend dependencies installées${NC}"

# Frontend
echo "Installing frontend dependencies..."
cd frontend
npm install
cd ..
echo -e "${GREEN}✅ Frontend dependencies installées${NC}"

echo ""
echo "⚙️  Configuration des variables d'environnement..."

# Créer .env pour le backend si n'existe pas
if [ ! -f backend/.env ]; then
    cat > backend/.env << EOF
PORT=5000
NODE_ENV=development

# MongoDB
MONGODB_URI=mongodb://localhost:27017/mayan-edms

# JWT
JWT_SECRET=$(openssl rand -base64 32)
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
EOF
    echo -e "${GREEN}✅ Fichier backend/.env créé${NC}"
else
    echo -e "${YELLOW}⚠️  backend/.env existe déjà${NC}"
fi

echo ""
if [ "$USE_DOCKER" = true ]; then
    echo "🐳 Démarrage des services Docker..."
    echo ""
    echo "Cette opération peut prendre plusieurs minutes la première fois."
    echo ""
    
    read -p "Démarrer les services avec Docker? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        docker-compose up -d
        
        echo ""
        echo "⏳ Attente du démarrage des services (30 secondes)..."
        sleep 30
        
        echo ""
        echo "📥 Téléchargement du modèle IA Qwen3 (peut prendre du temps)..."
        docker exec -it mayan-ollama ollama pull qwen:4b || echo -e "${YELLOW}⚠️  Impossible de télécharger le modèle IA${NC}"
    fi
else
    echo "📝 Services à démarrer manuellement:"
    echo ""
    echo "1. MongoDB:"
    echo "   mongod --dbpath ./data/db"
    echo ""
    echo "2. Ollama (IA):"
    echo "   ollama serve"
    echo "   ollama pull qwen:4b"
    echo ""
    echo "3. Mayan EDMS:"
    echo "   cd mayan-edms/docker"
    echo "   docker-compose --profile all_in_one --profile postgresql --profile redis --profile rabbitmq up -d"
    echo ""
fi

echo ""
echo "✅ Configuration terminée!"
echo ""
echo "═══════════════════════════════════════"
echo "🎉 PRÊT À DÉMARRER"
echo "═══════════════════════════════════════"
echo ""
echo "Pour démarrer l'application:"
echo ""
echo "Terminal 1 - Backend:"
echo "  cd backend"
echo "  npm run dev"
echo ""
echo "Terminal 2 - Frontend:"
echo "  cd frontend"
echo "  npm run dev"
echo ""
echo "Accès aux applications:"
echo "  🌐 Frontend:    http://localhost:3000"
echo "  🔌 Backend API: http://localhost:5000"
echo "  📁 Mayan EDMS:  http://localhost:8082"
echo ""
echo "Comptes par défaut:"
echo "  👤 Admin: admin@example.com / admin123"
echo "  👤 User:  user@example.com / user123"
echo ""
echo "Documentation:"
echo "  📖 README:      ./README.md"
echo "  📖 Frontend:    ./frontend/README.md"
echo "  📖 Backend:     ./backend/README.md"
echo ""
echo "═══════════════════════════════════════"

