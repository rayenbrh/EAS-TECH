# 🤝 Guide de contribution

Merci de votre intérêt pour contribuer à Mayan EDMS PWA ! Ce document vous guidera dans le processus de contribution.

## 📋 Table des matières

1. [Code de conduite](#code-de-conduite)
2. [Comment contribuer](#comment-contribuer)
3. [Standards de code](#standards-de-code)
4. [Processus de Pull Request](#processus-de-pull-request)
5. [Signalement de bugs](#signalement-de-bugs)
6. [Suggestions de fonctionnalités](#suggestions-de-fonctionnalités)

## 📜 Code de conduite

Ce projet adhère à un code de conduite. En participant, vous êtes tenu de respecter ce code :

- Soyez respectueux et inclusif
- Acceptez les critiques constructives
- Concentrez-vous sur ce qui est le mieux pour la communauté
- Faites preuve d'empathie envers les autres membres de la communauté

## 🚀 Comment contribuer

### Première contribution

1. **Fork le repository**
   ```bash
   # Cliquer sur "Fork" en haut à droite du repository GitHub
   ```

2. **Cloner votre fork**
   ```bash
   git clone https://github.com/VOTRE-USERNAME/mayan-edms-pwa.git
   cd mayan-edms-pwa
   ```

3. **Ajouter le repository upstream**
   ```bash
   git remote add upstream https://github.com/ORIGINAL-OWNER/mayan-edms-pwa.git
   ```

4. **Créer une branche**
   ```bash
   git checkout -b feature/ma-super-fonctionnalite
   ```

5. **Installer les dépendances**
   ```bash
   # Backend
   cd backend && npm install
   
   # Frontend
   cd ../frontend && npm install
   ```

### Types de contributions

Nous acceptons plusieurs types de contributions :

- 🐛 **Corrections de bugs**
- ✨ **Nouvelles fonctionnalités**
- 📝 **Améliorations de documentation**
- 🎨 **Améliorations UI/UX**
- ⚡ **Optimisations de performance**
- 🧪 **Tests**
- 🌍 **Traductions**

## 💻 Standards de code

### JavaScript/React

- Utiliser **ES6+** avec les fonctionnalités modernes
- Suivre les conventions **Airbnb JavaScript Style Guide**
- Utiliser **const** par défaut, **let** si nécessaire, jamais **var**
- Nommer les composants en **PascalCase**
- Nommer les fichiers en **camelCase** ou **PascalCase**

**Exemple de composant React :**

```javascript
import React, { useState, useEffect } from 'react';
import { Box, Typography } from '@mui/material';

const MonComposant = ({ title, data }) => {
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    // Effect logic
  }, []);

  return (
    <Box>
      <Typography variant="h6">{title}</Typography>
      {/* Component content */}
    </Box>
  );
};

export default MonComposant;
```

### Node.js/Express

- Utiliser **async/await** au lieu des callbacks
- Gérer toujours les erreurs avec **try/catch**
- Commenter les fonctions complexes
- Utiliser des **middleware** pour la logique réutilisable

**Exemple de route :**

```javascript
// @route   GET /api/resource
// @desc    Description de la route
// @access  Private
router.get('/', protect, async (req, res) => {
  try {
    const data = await Model.find();
    
    res.json({
      success: true,
      data,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
});
```

### Commits

Suivre la convention **Conventional Commits** :

```
type(scope): description courte

Description détaillée (optionnelle)

Footer (optionnel)
```

**Types de commits :**
- `feat`: Nouvelle fonctionnalité
- `fix`: Correction de bug
- `docs`: Documentation uniquement
- `style`: Changements de style (formatage, etc.)
- `refactor`: Refactoring de code
- `test`: Ajout ou modification de tests
- `chore`: Maintenance (dépendances, config, etc.)

**Exemples :**

```bash
git commit -m "feat(auth): ajouter authentification 2FA"
git commit -m "fix(upload): corriger erreur upload fichiers volumineux"
git commit -m "docs(readme): mettre à jour instructions installation"
```

### Tests

- Écrire des tests pour les nouvelles fonctionnalités
- S'assurer que tous les tests passent avant de soumettre une PR
- Viser une couverture de code d'au moins 70%

```bash
# Backend
cd backend
npm test

# Frontend
cd frontend
npm test
```

## 🔄 Processus de Pull Request

1. **Mettre à jour votre branche**
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Tester vos changements**
   ```bash
   npm test
   npm run build
   ```

3. **Commit vos changements**
   ```bash
   git add .
   git commit -m "feat: description de vos changements"
   ```

4. **Push vers votre fork**
   ```bash
   git push origin feature/ma-super-fonctionnalite
   ```

5. **Créer une Pull Request**
   - Aller sur GitHub
   - Cliquer sur "New Pull Request"
   - Remplir le template de PR
   - Attendre la review

### Template de Pull Request

```markdown
## Description
Brève description des changements

## Type de changement
- [ ] Bug fix
- [ ] Nouvelle fonctionnalité
- [ ] Breaking change
- [ ] Documentation

## Comment a été testé ?
Description des tests effectués

## Checklist
- [ ] Mon code suit les standards du projet
- [ ] J'ai commenté les parties complexes
- [ ] J'ai mis à jour la documentation
- [ ] Mes changements ne génèrent pas de warnings
- [ ] J'ai ajouté des tests
- [ ] Tous les tests passent
```

## 🐛 Signalement de bugs

Utiliser le template GitHub Issues pour signaler un bug :

### Informations requises

- **Titre** : Description courte et claire
- **Description** : Explication détaillée du bug
- **Steps to reproduce** : Étapes pour reproduire le bug
- **Expected behavior** : Comportement attendu
- **Actual behavior** : Comportement observé
- **Screenshots** : Captures d'écran si applicable
- **Environment** :
  - OS : Windows/Mac/Linux
  - Node version : `node --version`
  - Browser : Chrome/Firefox/Safari

**Exemple :**

```markdown
### Bug : L'upload de documents échoue

**Description**
Impossible d'uploader des fichiers PDF de plus de 10MB

**Steps to reproduce**
1. Se connecter en tant qu'admin
2. Aller dans "Documents"
3. Cliquer sur "Upload"
4. Sélectionner un PDF > 10MB
5. Observer l'erreur

**Expected behavior**
Le fichier devrait être uploadé avec succès

**Actual behavior**
Erreur : "Failed to upload document"

**Environment**
- OS: Windows 11
- Node: v18.17.0
- Browser: Chrome 120
```

## 💡 Suggestions de fonctionnalités

Pour suggérer une nouvelle fonctionnalité :

1. **Vérifier** qu'elle n'existe pas déjà dans les issues
2. **Ouvrir une issue** avec le label `enhancement`
3. **Décrire** clairement la fonctionnalité
4. **Expliquer** pourquoi elle serait utile
5. **Proposer** une implémentation si possible

**Template :**

```markdown
### Feature Request : Support multi-langue

**Description**
Ajouter le support de plusieurs langues (français, anglais, espagnol)

**Use case**
Les utilisateurs internationaux pourraient utiliser l'app dans leur langue

**Proposed solution**
Utiliser i18next pour la gestion des traductions

**Alternatives**
react-intl ou polyglot

**Additional context**
Screenshots, mockups, etc.
```

## 🌍 Traductions

Pour contribuer aux traductions :

1. Dupliquer le fichier `frontend/src/locales/en.json`
2. Traduire toutes les clés
3. Ajouter la langue dans `frontend/src/i18n/config.js`
4. Tester dans l'interface
5. Soumettre une PR

## 📚 Ressources

- [Documentation React](https://react.dev/)
- [Documentation Material-UI](https://mui.com/)
- [Documentation Express](https://expressjs.com/)
- [Documentation MongoDB](https://www.mongodb.com/docs/)
- [Conventional Commits](https://www.conventionalcommits.org/)

## 🎉 Remerciements

Merci à tous les contributeurs qui ont participé à ce projet !

### Top contributeurs

<!-- Automatiquement mis à jour par GitHub Actions -->

## ❓ Questions ?

Si vous avez des questions, n'hésitez pas à :

- Ouvrir une issue avec le label `question`
- Rejoindre notre [Discord](https://discord.gg/your-invite)
- Envoyer un email à : dev@example.com

---

**Merci pour votre contribution ! 🙏**

