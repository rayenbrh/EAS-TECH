# 📁 Structure complète du projet

Cette documentation présente l'architecture complète du projet Mayan EDMS PWA.

## 🌳 Arborescence

```
mayan-edms-pwa/
│
├── 📂 frontend/                      # Application React PWA
│   ├── 📂 public/                    # Fichiers statiques
│   │   ├── favicon.ico
│   │   ├── favicon.svg
│   │   ├── manifest.json             # Manifest PWA
│   │   ├── robots.txt
│   │   ├── pwa-192x192.png          # Icône PWA 192x192
│   │   ├── pwa-512x512.png          # Icône PWA 512x512
│   │   └── apple-touch-icon.png     # Icône iOS
│   │
│   ├── 📂 src/
│   │   ├── 📂 components/           # Composants React
│   │   │   ├── 📂 Layout/
│   │   │   │   ├── MainLayout.jsx   # Layout principal
│   │   │   │   ├── Sidebar.jsx      # Barre latérale
│   │   │   │   └── Topbar.jsx       # Barre supérieure
│   │   │   └── PrivateRoute.jsx     # Route protégée
│   │   │
│   │   ├── 📂 contexts/             # Contexts React
│   │   │   ├── AuthContext.jsx      # Authentification
│   │   │   └── NotificationContext.jsx  # Notifications
│   │   │
│   │   ├── 📂 pages/                # Pages de l'application
│   │   │   ├── Dashboard.jsx        # Tableau de bord
│   │   │   ├── Documents.jsx        # Gestion documents
│   │   │   ├── Users.jsx            # Gestion utilisateurs
│   │   │   ├── Settings.jsx         # Paramètres
│   │   │   └── Login.jsx            # Page de connexion
│   │   │
│   │   ├── App.jsx                  # Composant principal
│   │   ├── main.jsx                 # Point d'entrée
│   │   └── index.css                # Styles globaux
│   │
│   ├── Dockerfile                    # Docker pour frontend
│   ├── nginx.conf                    # Config Nginx
│   ├── vite.config.js               # Config Vite
│   ├── package.json                 # Dépendances npm
│   ├── index.html                   # HTML principal
│   └── README.md                    # Documentation frontend
│
├── 📂 backend/                       # API Node.js/Express
│   ├── 📂 config/
│   │   └── database.js              # Configuration MongoDB
│   │
│   ├── 📂 middleware/
│   │   ├── auth.js                  # Middleware auth JWT
│   │   └── errorHandler.js          # Gestion erreurs
│   │
│   ├── 📂 models/
│   │   ├── User.js                  # Modèle utilisateur
│   │   └── Document.js              # Modèle document
│   │
│   ├── 📂 routes/
│   │   ├── auth.js                  # Routes authentification
│   │   ├── users.js                 # Routes utilisateurs
│   │   ├── documents.js             # Routes documents
│   │   ├── dashboard.js             # Routes dashboard
│   │   └── ai.js                    # Routes IA
│   │
│   ├── 📂 services/
│   │   ├── mayanService.js          # Service Mayan EDMS
│   │   └── aiService.js             # Service IA (Qwen3)
│   │
│   ├── Dockerfile                    # Docker pour backend
│   ├── server.js                    # Point d'entrée serveur
│   ├── package.json                 # Dépendances npm
│   ├── .env                         # Variables d'environnement
│   └── README.md                    # Documentation backend
│
├── 📂 mayan-edms/                    # Installation Mayan EDMS
│   ├── 📂 docker/
│   │   ├── docker-compose.yml       # Config Docker Mayan
│   │   └── ...                      # Fichiers Mayan
│   └── ...                          # Code source Mayan
│
├── 📄 docker-compose.yml            # Docker Compose global
├── 📄 .gitignore                    # Fichiers ignorés Git
├── 📄 LICENSE                       # Licence MIT
├── 📄 README.md                     # Documentation principale
├── 📄 GUIDE_DEMARRAGE.md           # Guide de démarrage
├── 📄 CONTRIBUTING.md              # Guide contribution
├── 📄 INSTRUCTIONS_ICONES_PWA.md   # Guide icônes PWA
├── 📄 STRUCTURE_PROJET.md          # Ce fichier
├── 📄 setup.sh                     # Script setup Linux/Mac
└── 📄 setup.ps1                    # Script setup Windows
```

## 📦 Packages et dépendances

### Frontend

```json
{
  "dependencies": {
    "@mui/material": "^5.15.0",           // UI Components
    "@mui/icons-material": "^5.15.0",     // Icônes Material
    "@emotion/react": "^11.11.3",         // Styles CSS-in-JS
    "@emotion/styled": "^11.11.0",        // Styled components
    "axios": "^1.6.2",                    // HTTP client
    "chart.js": "^4.4.1",                 // Graphiques
    "react": "^18.2.0",                   // Framework React
    "react-dom": "^18.2.0",               // React DOM
    "react-router-dom": "^6.21.0",        // Routing
    "react-chartjs-2": "^5.2.0",          // Charts React
    "socket.io-client": "^4.6.0",         // WebSocket client
    "jwt-decode": "^4.0.0",               // Décodage JWT
    "react-dropzone": "^14.2.3",          // Upload fichiers
    "notistack": "^3.0.1",                // Notifications
    "date-fns": "^3.0.0"                  // Dates
  },
  "devDependencies": {
    "@vitejs/plugin-react": "^4.2.1",     // Plugin Vite React
    "vite": "^5.0.8",                     // Build tool
    "vite-plugin-pwa": "^0.17.4",         // Plugin PWA
    "workbox-window": "^7.0.0"            // Service Worker
  }
}
```

### Backend

```json
{
  "dependencies": {
    "express": "^4.18.2",                 // Framework web
    "cors": "^2.8.5",                     // CORS
    "dotenv": "^16.3.1",                  // Variables env
    "jsonwebtoken": "^9.0.2",             // JWT
    "bcryptjs": "^2.4.3",                 // Hashing passwords
    "mongoose": "^8.0.3",                 // MongoDB ODM
    "axios": "^1.6.2",                    // HTTP client
    "multer": "^1.4.5-lts.1",            // Upload fichiers
    "socket.io": "^4.6.0",                // WebSocket server
    "form-data": "^4.0.0",                // Form data
    "helmet": "^7.1.0",                   // Sécurité
    "express-rate-limit": "^7.1.5",       // Rate limiting
    "morgan": "^1.10.0"                   // Logging HTTP
  },
  "devDependencies": {
    "nodemon": "^3.0.2"                   // Auto-restart dev
  }
}
```

## 🔧 Configuration

### Variables d'environnement (Backend)

```env
# Serveur
PORT=5000
NODE_ENV=development

# Base de données
MONGODB_URI=mongodb://localhost:27017/mayan-edms

# JWT
JWT_SECRET=secret-super-securise
JWT_EXPIRE=7d

# Mayan EDMS
MAYAN_API_URL=http://localhost:8082/api
MAYAN_USERNAME=admin
MAYAN_PASSWORD=admin

# Service IA
AI_SERVICE_URL=http://localhost:11434
AI_MODEL=qwen:4b

# CORS
CORS_ORIGIN=http://localhost:3000
```

### Ports utilisés

| Service | Port | Description |
|---------|------|-------------|
| Frontend | 3000 | Application React |
| Backend | 5000 | API Express |
| Mayan EDMS | 8082 | Interface Mayan |
| MongoDB | 27017 | Base de données |
| PostgreSQL | 5432 | DB Mayan |
| Redis | 6379 | Cache Mayan |
| RabbitMQ | 5672 | Queue Mayan |
| Ollama | 11434 | Service IA |

## 🔐 Sécurité

### Backend

- ✅ **JWT** pour l'authentification
- ✅ **bcrypt** pour le hashing des passwords
- ✅ **Helmet** pour les headers HTTP sécurisés
- ✅ **CORS** configuré
- ✅ **Rate limiting** sur les routes sensibles
- ✅ **Validation** des entrées utilisateur
- ✅ **RBAC** (Role-Based Access Control)

### Frontend

- ✅ **HTTPS** en production
- ✅ **Token** stocké en localStorage
- ✅ **Routes protégées** avec PrivateRoute
- ✅ **Validation** côté client
- ✅ **CSP** (Content Security Policy)
- ✅ **XSS** protection

## 📊 Fonctionnalités par rôle

### Admin (Administrateur)

| Fonctionnalité | Accès |
|---------------|-------|
| Dashboard complet | ✅ |
| Voir tous les documents | ✅ |
| Upload documents | ✅ |
| Supprimer documents | ✅ |
| Gérer utilisateurs | ✅ |
| Modifier rôles | ✅ |
| Analytics avancées | ✅ |
| Résumés IA | ✅ |
| Paramètres système | ✅ |

### User (Utilisateur)

| Fonctionnalité | Accès |
|---------------|-------|
| Dashboard | ✅ |
| Voir ses documents | ✅ |
| Voir documents publics | ✅ |
| Upload documents | ✅ |
| Supprimer ses documents | ❌ |
| Gérer utilisateurs | ❌ |
| Analytics basiques | ✅ |
| Résumés IA | ✅ |
| Paramètres personnels | ✅ |

### Guest (Invité)

| Fonctionnalité | Accès |
|---------------|-------|
| Dashboard limité | ✅ |
| Voir documents publics | ✅ |
| Upload documents | ❌ |
| Supprimer documents | ❌ |
| Gérer utilisateurs | ❌ |
| Analytics | ❌ |
| Résumés IA | ❌ |
| Paramètres | ❌ |

## 🚀 API Endpoints

### Authentification

```
POST   /api/auth/register      # Créer un compte
POST   /api/auth/login         # Se connecter
GET    /api/auth/me            # Profil utilisateur
```

### Utilisateurs

```
GET    /api/users              # Liste utilisateurs (Admin)
GET    /api/users/:id          # Un utilisateur (Admin)
POST   /api/users              # Créer utilisateur (Admin)
PUT    /api/users/:id          # Modifier utilisateur (Admin)
DELETE /api/users/:id          # Supprimer utilisateur (Admin)
```

### Documents

```
GET    /api/documents          # Liste documents
GET    /api/documents/:id      # Un document
POST   /api/documents/upload   # Upload document
POST   /api/documents/search   # Rechercher
PUT    /api/documents/:id/rating  # Noter résumé IA
DELETE /api/documents/:id      # Supprimer (Admin)
```

### Dashboard

```
GET    /api/dashboard/stats    # Statistiques
GET    /api/dashboard/analytics # Analytics (Admin)
```

### IA

```
POST   /api/ai/summarize       # Générer résumé
POST   /api/ai/extract-text    # Extraire texte
```

## 🔄 Workflow de développement

### 1. Setup initial

```bash
# Cloner le projet
git clone <repo-url>
cd mayan-edms-pwa

# Installer les dépendances
./setup.sh  # Linux/Mac
# ou
.\setup.ps1  # Windows
```

### 2. Développement

```bash
# Terminal 1 - Backend
cd backend
npm run dev

# Terminal 2 - Frontend
cd frontend
npm run dev

# Terminal 3 - Docker services
docker-compose up -d
```

### 3. Tests

```bash
# Backend
cd backend
npm test

# Frontend
cd frontend
npm test
```

### 4. Build

```bash
# Frontend
cd frontend
npm run build

# Backend
cd backend
npm start
```

### 5. Déploiement

```bash
# Docker (production)
docker-compose up -d --build
```

## 📚 Documentation

| Document | Description |
|----------|-------------|
| README.md | Documentation principale |
| GUIDE_DEMARRAGE.md | Guide de démarrage rapide |
| CONTRIBUTING.md | Guide de contribution |
| frontend/README.md | Documentation frontend |
| backend/README.md | Documentation backend |
| INSTRUCTIONS_ICONES_PWA.md | Guide création icônes |
| STRUCTURE_PROJET.md | Ce document |

## 🧪 Tests

### Backend

- Tests unitaires des routes
- Tests d'intégration avec MongoDB
- Tests des services Mayan EDMS
- Tests de l'authentification JWT

### Frontend

- Tests de composants React
- Tests d'intégration
- Tests E2E avec Playwright

## 🔄 CI/CD

### GitHub Actions

```yaml
# .github/workflows/ci.yml
- Tests automatiques
- Build vérification
- Linting
- Sécurité scan
```

## 📱 PWA Features

- ✅ **Installable** sur tous les appareils
- ✅ **Offline support** avec Service Worker
- ✅ **Push notifications** WebSocket
- ✅ **Responsive** design
- ✅ **Fast loading** avec cache
- ✅ **SEO** optimized
- ✅ **Cross-platform** compatible

## 🛠️ Maintenance

### Mises à jour régulières

```bash
# Mettre à jour les dépendances
npm update

# Vérifier les vulnérabilités
npm audit

# Corriger les vulnérabilités
npm audit fix
```

### Backup

```bash
# Backup MongoDB
mongodump --out ./backup/

# Backup PostgreSQL (Mayan)
docker exec mayan-postgresql pg_dump -U mayan > backup/mayan.sql
```

## 🎯 Performance

### Frontend

- ✅ Code splitting avec React.lazy()
- ✅ Lazy loading des images
- ✅ Memoization avec React.memo()
- ✅ Debounce sur les recherches
- ✅ Virtual scrolling pour grandes listes
- ✅ Compression gzip

### Backend

- ✅ Indexation MongoDB
- ✅ Rate limiting
- ✅ Compression des réponses
- ✅ Caching avec Redis
- ✅ Pagination des résultats
- ✅ Query optimization

## 🐛 Troubleshooting

Voir le fichier [GUIDE_DEMARRAGE.md](GUIDE_DEMARRAGE.md) section "Résolution de problèmes"

## 📞 Support

- 📧 Email: support@example.com
- 🐛 Issues: GitHub Issues
- 💬 Discord: [Lien Discord](#)
- 📖 Wiki: [GitHub Wiki](#)

---

**Dernière mise à jour:** Décembre 2024

**Version:** 1.0.0

**Auteur:** Équipe de développement Mayan EDMS PWA

