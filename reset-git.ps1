# Script pour réinitialiser complètement Git
Write-Host "=== Réinitialisation complète du dépôt Git ===" -ForegroundColor Cyan

# 1. Supprimer complètement .git
Write-Host "`n1. Suppression de .git..." -ForegroundColor Yellow
if (Test-Path ".git") {
    Remove-Item -Recurse -Force ".git" -ErrorAction Stop
    Write-Host "   .git supprimé" -ForegroundColor Green
}

# 2. Supprimer tous les .git dans les sous-dossiers
Write-Host "`n2. Suppression de tous les .git dans les sous-dossiers..." -ForegroundColor Yellow
Get-ChildItem -Path . -Filter ".git" -Recurse -Force -Directory -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Host "   Suppression: $($_.FullName)" -ForegroundColor Yellow
    Remove-Item -Recurse -Force $_.FullName -ErrorAction SilentlyContinue
}
Write-Host "   Nettoyage terminé" -ForegroundColor Green

# 3. Supprimer .gitmodules
Write-Host "`n3. Suppression de .gitmodules..." -ForegroundColor Yellow
if (Test-Path ".gitmodules") {
    Remove-Item ".gitmodules" -Force
    Write-Host "   .gitmodules supprimé" -ForegroundColor Green
}

# 4. Réinitialiser Git
Write-Host "`n4. Réinitialisation de Git..." -ForegroundColor Yellow
git init
Write-Host "   Git initialisé" -ForegroundColor Green

# 5. Ajouter le remote
Write-Host "`n5. Configuration du remote..." -ForegroundColor Yellow
git remote add origin https://github.com/rayenbrh/EAS-TECH.git 2>&1 | Out-Null
git remote set-url origin https://github.com/rayenbrh/EAS-TECH.git
Write-Host "   Remote configuré" -ForegroundColor Green

# 6. Ajouter tous les fichiers
Write-Host "`n6. Ajout de tous les fichiers..." -ForegroundColor Yellow
git add .
if ($LASTEXITCODE -eq 0) {
    Write-Host "   Fichiers ajoutés avec succès" -ForegroundColor Green
} else {
    Write-Host "   ERREUR lors de l'ajout" -ForegroundColor Red
    exit 1
}

# 7. Créer le commit
Write-Host "`n7. Création du commit..." -ForegroundColor Yellow
git commit -m "Initial commit: MERN stack app with Mayan EDMS, AI analytics, and project management"
if ($LASTEXITCODE -eq 0) {
    Write-Host "   Commit créé avec succès" -ForegroundColor Green
} else {
    Write-Host "   ERREUR lors de la création du commit" -ForegroundColor Red
    exit 1
}

# 8. Renommer la branche
Write-Host "`n8. Renommage de la branche en main..." -ForegroundColor Yellow
git branch -M main
Write-Host "   Branche renommée" -ForegroundColor Green

# 9. Afficher le statut
Write-Host "`n9. Statut final:" -ForegroundColor Yellow
git status

Write-Host "`n=== Prêt pour le push ===" -ForegroundColor Cyan
Write-Host "Exécutez: git push -u origin main" -ForegroundColor Green
