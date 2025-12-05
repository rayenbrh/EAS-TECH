# Script pour résoudre le problème avec backend/ dans Git
Write-Host "=== Diagnostic et correction du problème Git avec backend/ ===" -ForegroundColor Cyan

# 1. Vérifier s'il y a un .git dans backend
Write-Host "`n1. Recherche de .git dans backend/..." -ForegroundColor Yellow
$backendGit = Get-ChildItem -Path "backend" -Filter ".git" -Recurse -Force -ErrorAction SilentlyContinue
if ($backendGit) {
    Write-Host "   TROUVÉ: $($backendGit.FullName)" -ForegroundColor Red
    Remove-Item -Recurse -Force $backendGit.FullName -ErrorAction Stop
    Write-Host "   SUPPRIMÉ" -ForegroundColor Green
} else {
    Write-Host "   Aucun .git trouvé dans backend/" -ForegroundColor Green
}

# 2. Vérifier .gitmodules
Write-Host "`n2. Vérification de .gitmodules..." -ForegroundColor Yellow
if (Test-Path ".gitmodules") {
    Write-Host "   TROUVÉ: .gitmodules" -ForegroundColor Red
    Get-Content ".gitmodules"
    Remove-Item ".gitmodules" -Force
    Write-Host "   SUPPRIMÉ" -ForegroundColor Green
} else {
    Write-Host "   Aucun .gitmodules trouvé" -ForegroundColor Green
}

# 3. Nettoyer les sous-modules dans .git/config
Write-Host "`n3. Nettoyage de la config Git..." -ForegroundColor Yellow
git config --remove-section submodule.backend 2>&1 | Out-Null
git config --remove-section submodule.frontend 2>&1 | Out-Null
git config --remove-section submodule.mayan-edms 2>&1 | Out-Null
Write-Host "   Config nettoyée" -ForegroundColor Green

# 4. Supprimer .git/modules
Write-Host "`n4. Suppression de .git/modules..." -ForegroundColor Yellow
if (Test-Path ".git\modules") {
    Remove-Item -Recurse -Force ".git\modules" -ErrorAction SilentlyContinue
    Write-Host "   .git/modules supprimé" -ForegroundColor Green
} else {
    Write-Host "   Aucun .git/modules trouvé" -ForegroundColor Green
}

# 5. Retirer backend du cache Git
Write-Host "`n5. Retrait de backend du cache Git..." -ForegroundColor Yellow
git rm --cached -r backend 2>&1 | Out-Null
git rm --cached -r frontend 2>&1 | Out-Null
git rm --cached -r mayan-edms 2>&1 | Out-Null
Write-Host "   Cache nettoyé" -ForegroundColor Green

# 6. Vérifier qu'il n'y a pas de fichier .git dans backend
Write-Host "`n6. Vérification finale..." -ForegroundColor Yellow
$allGitDirs = Get-ChildItem -Path . -Filter ".git" -Recurse -Force -Directory -ErrorAction SilentlyContinue | Where-Object { $_.FullName -ne (Resolve-Path ".git").Path }
if ($allGitDirs) {
    Write-Host "   ATTENTION: Dossiers .git trouvés:" -ForegroundColor Red
    $allGitDirs | ForEach-Object { 
        Write-Host "   - $($_.FullName)" -ForegroundColor Red
        Remove-Item -Recurse -Force $_.FullName -ErrorAction SilentlyContinue
        Write-Host "     SUPPRIMÉ" -ForegroundColor Green
    }
} else {
    Write-Host "   Aucun .git supplémentaire trouvé" -ForegroundColor Green
}

# 7. Essayer d'ajouter backend
Write-Host "`n7. Tentative d'ajout de backend/..." -ForegroundColor Yellow
$result = git add backend/ 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "   SUCCÈS: backend/ ajouté" -ForegroundColor Green
} else {
    Write-Host "   ERREUR:" -ForegroundColor Red
    $result | ForEach-Object { Write-Host "   $_" -ForegroundColor Red }
}

# 8. Essayer d'ajouter tous les fichiers
Write-Host "`n8. Tentative d'ajout de tous les fichiers..." -ForegroundColor Yellow
$result = git add . 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "   SUCCÈS: Tous les fichiers ajoutés" -ForegroundColor Green
} else {
    Write-Host "   ERREUR:" -ForegroundColor Red
    $result | ForEach-Object { Write-Host "   $_" -ForegroundColor Red }
}

# 9. Afficher le statut
Write-Host "`n9. Statut Git:" -ForegroundColor Yellow
git status --short | Select-Object -First 30

Write-Host "`n=== Terminé ===" -ForegroundColor Cyan
