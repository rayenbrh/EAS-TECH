# 🚀 Guide de démarrage rapide - LockHeaven

Ce guide vous aidera à démarrer rapidement avec l'application LockHeaven.

## 📋 Table des matières

1. [Installation automatique](#installation-automatique)
2. [Installation manuelle](#installation-manuelle)
3. [Premiers pas](#premiers-pas)
4. [Résolution de problèmes](#résolution-de-problèmes)

## 🎯 Installation automatique

### Windows

Ouvrir PowerShell en tant qu'administrateur et exécuter :

```powershell
.\setup.ps1
```

### Linux/Mac

Ouvrir un terminal et exécuter :

```bash
chmod +x setup.sh
./setup.sh
```

Le script va automatiquement :
- ✅ Vérifier les prérequis
- ✅ Installer les dépendances
- ✅ Configurer les variables d'environnement
- ✅ Démarrer les services Docker (optionnel)

## 🔧 Installation manuelle

### 1️⃣ Prérequis

Installer les logiciels suivants :

- **Node.js 16+** : https://nodejs.org/
- **MongoDB 4.4+** : https://www.mongodb.com/try/download/community
- **Docker Desktop** (recommandé) : https://www.docker.com/products/docker-desktop

### 2️⃣ Installation des dépendances

#### Backend

```bash
cd backend
npm install
```

#### Frontend

```bash
cd frontend
npm install
```

### 3️⃣ Configuration

Créer le fichier `backend/.env` :

```env
PORT=5000
NODE_ENV=development

# MongoDB
MONGODB_URI=mongodb://localhost:27017/mayan-edms

# JWT (générer une clé aléatoire sécurisée)
JWT_SECRET=votre-secret-super-securise-ici
JWT_EXPIRE=7d

# Mayan EDMS
MAYAN_API_URL=http://localhost:8082/api
MAYAN_USERNAME=admin
MAYAN_PASSWORD=admin

# AI Service
AI_SERVICE_URL=http://localhost:11434
AI_MODEL=qwen:4b

# CORS
CORS_ORIGIN=http://localhost:3000
```

### 4️⃣ Démarrer les services

#### Méthode A : Avec Docker (recommandé)

```bash
# Démarrer tous les services
docker-compose up -d

# Télécharger le modèle IA
docker exec -it mayan-ollama ollama pull qwen:4b
```

#### Méthode B : Manuellement

**Terminal 1 - MongoDB :**
```bash
mongod --dbpath ./data/db
```

**Terminal 2 - Mayan EDMS :**
```bash
cd mayan-edms/docker
docker-compose --profile all_in_one --profile postgresql --profile redis --profile rabbitmq up -d
```

**Terminal 3 - Ollama (IA) :**
```bash
# Installer Ollama
# Windows: Télécharger depuis https://ollama.ai/download
# Linux/Mac:
curl -fsSL https://ollama.ai/install.sh | sh

# Démarrer le service
ollama serve

# Dans un autre terminal, télécharger le modèle
ollama pull qwen:4b
```

**Terminal 4 - Backend :**
```bash
cd backend
npm run dev
```

**Terminal 5 - Frontend :**
```bash
cd frontend
npm run dev
```

## 🎉 Premiers pas

### 1️⃣ Accéder à l'application

Ouvrir votre navigateur et accéder à : **http://localhost:3000**

### 2️⃣ Se connecter

Utiliser un compte de test :

**Admin (accès complet) :**
- Email : `admin@example.com`
- Mot de passe : `admin123`

**User (accès standard) :**
- Email : `user@example.com`
- Mot de passe : `user123`

### 3️⃣ Explorer le dashboard

Une fois connecté, vous arriverez sur le **dashboard** qui affiche :

- 📊 Statistiques générales (documents, uploads, utilisateurs)
- 📈 Graphiques d'audience et d'activité
- 📱 Répartition par appareils
- 💹 Métriques de croissance

### 4️⃣ Uploader un document

1. Cliquer sur **"Documents"** dans la sidebar
2. Cliquer sur le bouton **"Télécharger"**
3. Glisser-déposer un fichier ou cliquer pour sélectionner
4. Attendre la fin du téléchargement
5. Le résumé IA sera généré automatiquement

**Formats supportés :**
- 📄 PDF
- 📝 Word (DOC, DOCX)
- 📊 Excel (XLS, XLSX)
- 🖼️ Images (PNG, JPG, JPEG)

### 5️⃣ Voir un résumé IA

1. Dans la liste des documents
2. Cliquer sur **"Voir le résumé IA"**
3. Lire le résumé et les points clés
4. Noter le résumé (1-5 étoiles) pour améliorer l'IA

### 6️⃣ Gérer les utilisateurs (Admin uniquement)

1. Cliquer sur **"Utilisateurs"** dans la sidebar
2. Voir la liste de tous les utilisateurs
3. Cliquer sur **"Ajouter un utilisateur"** pour créer un compte
4. Modifier ou supprimer des utilisateurs existants

### 7️⃣ Personnaliser les paramètres

1. Cliquer sur votre avatar en haut à droite
2. Sélectionner **"Paramètres"**
3. Modifier :
   - Profil (nom, email, téléphone)
   - Notifications (email, push, etc.)
   - Sécurité (2FA, timeout)
   - Configuration Mayan EDMS

### 8️⃣ Changer le thème

Cliquer sur l'icône **lune/soleil** dans la topbar pour basculer entre :
- 🌙 **Mode sombre** (par défaut)
- ☀️ **Mode clair**

### 9️⃣ Installer en PWA

**Desktop (Chrome/Edge) :**
- Cliquer sur l'icône **"Installer"** dans la barre d'adresse
- Ou : Menu → "Installer Mayan EDMS"

**Mobile :**
- Menu du navigateur → "Ajouter à l'écran d'accueil"

L'application sera installée comme une app native !

## 🐛 Résolution de problèmes

### ❌ Le backend ne démarre pas

**Erreur : "EADDRINUSE: address already in use :::5000"**

Le port 5000 est déjà utilisé. Options :

1. Arrêter le processus utilisant le port 5000
2. Changer le port dans `backend/.env` :
   ```env
   PORT=5001
   ```

**Erreur : "MongoNetworkError: failed to connect"**

MongoDB n'est pas démarré :

```bash
# Vérifier le statut
# Windows: Ouvrir "Services" et démarrer "MongoDB"
# Linux:
sudo systemctl start mongod
# Mac:
brew services start mongodb-community
```

### ❌ Le frontend ne se connecte pas au backend

**Erreur : "Network Error" ou "Failed to fetch"**

1. Vérifier que le backend est démarré :
   ```bash
   curl http://localhost:5000/api/health
   ```

2. Vérifier la configuration du proxy dans `frontend/vite.config.js`

### ❌ Mayan EDMS non accessible

**Erreur : "Cannot connect to Mayan EDMS"**

1. Vérifier que Mayan EDMS est démarré :
   ```bash
   docker ps | grep mayan
   ```

2. Redémarrer si nécessaire :
   ```bash
   cd mayan-edms/docker
   docker-compose restart
   ```

3. Vérifier l'URL dans `backend/.env` :
   ```env
   MAYAN_API_URL=http://localhost:8082/api
   ```

### ❌ L'IA ne génère pas de résumés

**Les résumés sont "non disponibles"**

1. Vérifier qu'Ollama est démarré :
   ```bash
   # Tester l'API
   curl http://localhost:11434/api/tags
   ```

2. Télécharger le modèle si nécessaire :
   ```bash
   ollama pull qwen:4b
   ```

3. L'application fonctionne sans IA mais avec des résumés par défaut

### ❌ Les notifications ne fonctionnent pas

**Pas de notifications en temps réel**

1. Vérifier la connexion WebSocket dans la console du navigateur
2. Redémarrer le backend
3. Vider le cache du navigateur

### ❌ Erreur lors de l'upload de documents

**"Failed to upload document"**

1. Vérifier que Mayan EDMS est accessible
2. Vérifier les credentials dans `backend/.env` :
   ```env
   MAYAN_USERNAME=admin
   MAYAN_PASSWORD=admin
   ```
3. Vérifier la taille du fichier (max 50MB)

## 📚 Ressources supplémentaires

### Documentation

- **README principal** : `./README.md`
- **Documentation Frontend** : `./frontend/README.md`
- **Documentation Backend** : `./backend/README.md`
- **Documentation Mayan EDMS** : https://docs.mayan-edms.com/

### Support

- 📧 **Email** : support@example.com
- 🐛 **Issues GitHub** : [GitHub Issues](https://github.com/your-repo/issues)
- 💬 **Discord** : [Rejoindre le serveur](https://discord.gg/your-invite)

### Tutoriels vidéo

- 🎥 **Installation** : [Lien YouTube](#)
- 🎥 **Premiers pas** : [Lien YouTube](#)
- 🎥 **Administration** : [Lien YouTube](#)

## 🎓 Prochaines étapes

Maintenant que vous avez installé et exploré l'application, vous pouvez :

1. ✅ **Créer vos propres utilisateurs** avec différents rôles
2. ✅ **Uploader vos documents** et tester les résumés IA
3. ✅ **Personnaliser les paramètres** selon vos besoins
4. ✅ **Explorer les analytics** dans le dashboard
5. ✅ **Tester l'application mobile** en installant la PWA

## 💡 Conseils

- 🔐 **Changer les mots de passe** des comptes de test en production
- 🔑 **Générer un JWT_SECRET** fort et unique
- 💾 **Sauvegarder régulièrement** votre base de données MongoDB
- 📊 **Monitorer les logs** pour détecter les problèmes
- 🔄 **Mettre à jour** régulièrement les dépendances

---

**Besoin d'aide ?** N'hésitez pas à consulter la documentation ou à ouvrir une issue sur GitHub !

**Bon développement ! 🚀**

