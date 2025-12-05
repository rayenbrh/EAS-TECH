# Guide de Configuration des Variables d'Environnement

Ce guide explique comment configurer les fichiers d'environnement pour le backend et le frontend.

## 📋 Prérequis

1. **MongoDB** : Installé et en cours d'exécution
2. **Mayan EDMS** : Accessible via Docker ou installation locale
3. **Service IA** : Ollama, LM Studio, ou autre service LLM local
4. **Google Cloud Console** : Pour obtenir les credentials OAuth 2.0

## 🔧 Configuration Backend

### 1. Créer le fichier `.env` dans le dossier `backend/`

```bash
cd backend
cp .env.example .env
```

### 2. Configurer les variables essentielles

#### Base de données MongoDB
```env
MONGODB_URI=mongodb://localhost:27017/mayan-edms
```

#### JWT et Sessions
```env
JWT_SECRET=votre-secret-jwt-tres-securise-changez-moi
SESSION_SECRET=votre-secret-session-tres-securise-changez-moi
JWT_EXPIRE=7d
```

**⚠️ IMPORTANT** : Changez ces secrets en production avec des valeurs aléatoires sécurisées !

#### Google OAuth 2.0

1. Allez sur [Google Cloud Console](https://console.cloud.google.com/)
2. Créez un nouveau projet ou sélectionnez un projet existant
3. Activez l'API "Google Identity Platform"
4. Allez dans "APIs & Services" > "Credentials"
5. Cliquez sur "Create Credentials" > "OAuth client ID"
6. Choisissez "Web application"
7. Ajoutez les URIs de redirection autorisées :
   - `http://localhost:5000/auth/google/callback` (développement)
   - `https://votre-domaine.com/auth/google/callback` (production)
8. Copiez le Client ID et Client Secret dans votre `.env` :

```env
GOOGLE_CLIENT_ID=votre-client-id.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=votre-client-secret
GOOGLE_CALLBACK_URL=http://localhost:5000/auth/google/callback
```

#### Mayan EDMS

```env
MAYAN_API_URL=http://localhost:8082/api
MAYAN_USERNAME=admin
MAYAN_PASSWORD=admin
```

**Note** : Ajustez ces valeurs selon votre configuration Mayan EDMS.

#### Service IA (Ollama)

Si vous utilisez Ollama :

```bash
# Installer Ollama
curl -fsSL https://ollama.ai/install.sh | sh

# Démarrer Ollama
ollama serve

# Télécharger un modèle (ex: Qwen 4B)
ollama pull qwen:4b
```

Puis dans votre `.env` :

```env
AI_SERVICE_URL=http://localhost:11434
AI_MODEL=qwen:4b
```

**Autres services IA** :
- **LM Studio** : `AI_SERVICE_URL=http://localhost:1234`
- **Service personnalisé** : Ajustez l'URL selon votre configuration

#### CORS et Frontend

```env
CORS_ORIGIN=http://localhost:3000
FRONTEND_URL=http://localhost:3000
```

## 🎨 Configuration Frontend

### 1. Créer le fichier `.env` ou `.env.local` dans le dossier `frontend/`

```bash
cd frontend
cp .env.example .env.local
```

### 2. Configurer les variables

#### URL de l'API Backend

```env
VITE_API_URL=http://localhost:5000
```

**En production** :
```env
VITE_API_URL=https://api.votre-domaine.com
```

#### URL WebSocket

```env
VITE_WS_URL=http://localhost:5000
```

**En production** :
```env
VITE_WS_URL=https://api.votre-domaine.com
```

## 🚀 Démarrage

### Backend

```bash
cd backend
npm install
npm start  # ou npm run dev pour le mode développement
```

### Frontend

```bash
cd frontend
npm install
npm run dev  # pour le mode développement
```

## 🔒 Sécurité en Production

### Backend

1. **Changez tous les secrets** :
   - `JWT_SECRET` : Utilisez un générateur de secrets sécurisé
   - `SESSION_SECRET` : Utilisez un secret différent de JWT_SECRET
   - `GOOGLE_CLIENT_SECRET` : Gardez-le secret !

2. **Utilisez HTTPS** :
   - Configurez un reverse proxy (Nginx, Apache)
   - Utilisez des certificats SSL/TLS valides

3. **Variables d'environnement** :
   - Ne commitez JAMAIS le fichier `.env` dans Git
   - Utilisez des services de gestion de secrets (AWS Secrets Manager, etc.)

4. **CORS** :
   - Limitez `CORS_ORIGIN` à votre domaine de production uniquement
   - Ne mettez jamais `*` en production

### Frontend

1. **Variables d'environnement** :
   - Les variables `VITE_*` sont exposées au client
   - Ne mettez JAMAIS de secrets dans les variables VITE_*

2. **Build de production** :
   ```bash
   npm run build
   ```

## 📝 Exemple de Configuration Complète

### Backend `.env` (Développement)

```env
PORT=5000
NODE_ENV=development
MONGODB_URI=mongodb://localhost:27017/mayan-edms
JWT_SECRET=dev-secret-change-in-production
JWT_EXPIRE=7d
SESSION_SECRET=dev-session-secret-change-in-production
GOOGLE_CLIENT_ID=123456789-abc.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=GOCSPX-abcdefghijklmnopqrstuvwxyz
GOOGLE_CALLBACK_URL=http://localhost:5000/auth/google/callback
MAYAN_API_URL=http://localhost:8082/api
MAYAN_USERNAME=admin
MAYAN_PASSWORD=admin
AI_SERVICE_URL=http://localhost:11434
AI_MODEL=qwen:4b
CORS_ORIGIN=http://localhost:3000
FRONTEND_URL=http://localhost:3000
```

### Frontend `.env.local` (Développement)

```env
VITE_API_URL=http://localhost:5000
VITE_WS_URL=http://localhost:5000
VITE_APP_ENV=development
VITE_APP_NAME=LockHeaven
VITE_DEBUG=true
```

## 🐛 Dépannage

### Erreur : "Cannot find module"
- Vérifiez que vous avez installé les dépendances : `npm install`

### Erreur : "MongoDB connection failed"
- Vérifiez que MongoDB est démarré
- Vérifiez l'URI MongoDB dans `.env`

### Erreur : "Google OAuth failed"
- Vérifiez que les credentials Google sont corrects
- Vérifiez que l'URI de callback est bien configurée dans Google Cloud Console

### Erreur : "Mayan EDMS not accessible"
- Vérifiez que Mayan EDMS est démarré
- Vérifiez l'URL et les credentials dans `.env`

### Erreur : "AI Service not available"
- Vérifiez que le service IA est démarré
- Vérifiez l'URL dans `AI_SERVICE_URL`
- L'application fonctionnera sans IA mais avec des résumés par défaut

## 📚 Ressources

- [Google OAuth 2.0 Setup](https://developers.google.com/identity/protocols/oauth2)
- [MongoDB Connection String](https://docs.mongodb.com/manual/reference/connection-string/)
- [Ollama Documentation](https://ollama.ai/docs)
- [Mayan EDMS Documentation](https://docs.mayan-edms.com/)
