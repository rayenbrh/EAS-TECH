# 🚀 Guide de Configuration Rapide des Variables d'Environnement

## 📦 Backend

### 1. Créer le fichier `.env`

```bash
cd backend
cp env.template .env
```

### 2. Éditer le fichier `.env` et remplir les valeurs :

```env
# Port
PORT=5000

# MongoDB
MONGODB_URI=mongodb://localhost:27017/mayan-edms

# JWT (IMPORTANT: Changez ces secrets!)
JWT_SECRET=votre-secret-jwt-tres-securise
SESSION_SECRET=votre-secret-session-tres-securise
JWT_EXPIRE=7d

# Google OAuth 2.0
GOOGLE_CLIENT_ID=votre-client-id.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=votre-client-secret
GOOGLE_CALLBACK_URL=http://localhost:5000/auth/google/callback

# Mayan EDMS
MAYAN_API_URL=http://localhost:8082/api
MAYAN_USERNAME=admin
MAYAN_PASSWORD=admin

# Service IA
AI_SERVICE_URL=http://localhost:11434
AI_MODEL=qwen:4b

# CORS
CORS_ORIGIN=http://localhost:3000
FRONTEND_URL=http://localhost:3000
```

## 🎨 Frontend

### 1. Créer le fichier `.env.local`

```bash
cd frontend
cp env.template .env.local
```

### 2. Éditer le fichier `.env.local` :

```env
VITE_API_URL=http://localhost:5000
VITE_WS_URL=http://localhost:5000
VITE_APP_ENV=development
VITE_APP_NAME=LockHeaven
```

## ⚡ Démarrage Rapide

```bash
# Backend
cd backend
npm install
npm start

# Frontend (dans un autre terminal)
cd frontend
npm install
npm run dev
```

## 📝 Notes Importantes

- ⚠️ **Ne commitez JAMAIS** les fichiers `.env` ou `.env.local` dans Git
- 🔒 **Changez les secrets** en production
- 🌐 **Ajustez les URLs** selon votre environnement

Pour plus de détails, consultez `ENV_SETUP.md`
