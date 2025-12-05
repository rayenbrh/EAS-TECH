# Script pour pousser le code vers GitHub
Write-Host "=== Vérification du dépôt Git ===" -ForegroundColor Cyan

# Vérifier le statut
Write-Host "`n1. Statut Git:" -ForegroundColor Yellow
git status

# Vérifier les branches
Write-Host "`n2. Branches:" -ForegroundColor Yellow
git branch

# Vérifier les commits
Write-Host "`n3. Dernier commit:" -ForegroundColor Yellow
git log --oneline -1

# Vérifier le remote
Write-Host "`n4. Remote configuré:" -ForegroundColor Yellow
git remote -v

# Si pas de commit, en créer un
Write-Host "`n5. Ajout des fichiers..." -ForegroundColor Yellow
git add .

Write-Host "`n6. Création du commit..." -ForegroundColor Yellow
git commit -m "Initial commit: MERN stack app with Mayan EDMS, AI analytics, and project management"

# Renommer la branche en main
Write-Host "`n7. Renommage de la branche en main..." -ForegroundColor Yellow
git branch -M main

# Pousser vers GitHub
Write-Host "`n8. Push vers GitHub..." -ForegroundColor Yellow
Write-Host "Si vous êtes invité à vous authentifier, utilisez votre Personal Access Token comme mot de passe." -ForegroundColor Green
git push -u origin main

Write-Host "`n=== Terminé ===" -ForegroundColor Cyan
