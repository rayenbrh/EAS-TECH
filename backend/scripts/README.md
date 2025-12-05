# Scripts de Seed

Ce dossier contient les scripts de seed pour initialiser la base de données avec des données par défaut.

## 🌱 Seed des Utilisateurs

Le script `seedUsers.js` crée des utilisateurs par défaut pour tester l'application.

### Utilisation

```bash
# Depuis la racine du projet
cd backend
npm run seed

# Ou directement
node scripts/seedUsers.js
```

### Utilisateurs créés

Le script crée les utilisateurs suivants :

#### 👑 Administrateur
- **Email**: `admin@example.com`
- **Mot de passe**: `admin123`
- **Rôle**: `admin`
- **Permissions**: Accès complet à toutes les fonctionnalités

#### 👤 Utilisateur
- **Email**: `user@example.com`
- **Mot de passe**: `user123`
- **Rôle**: `user`
- **Permissions**: Upload et consultation de documents

#### 👁️ Invité
- **Email**: `guest@example.com`
- **Mot de passe**: `guest123`
- **Rôle**: `guest`
- **Permissions**: Consultation des documents publics uniquement

### Fonctionnalités

- ✅ Crée les utilisateurs s'ils n'existent pas
- ✅ Met à jour les utilisateurs existants (nom, rôle, mot de passe)
- ✅ Affiche un résumé de tous les utilisateurs
- ✅ Hash automatique des mots de passe
- ✅ Gestion des erreurs

### Notes

- Les mots de passe sont automatiquement hashés avec bcrypt
- Si un utilisateur existe déjà, il sera mis à jour avec les nouvelles valeurs
- Le script peut être exécuté plusieurs fois en toute sécurité (idempotent)
