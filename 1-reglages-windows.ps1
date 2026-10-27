# =====================================================================
#  Barre des taches "Liquid Glass" - reglages Windows + installation Windhawk
#  A lancer une fois sur le nouveau PC (Windows 11), dans PowerShell :
#    clic droit sur ce fichier > "Executer avec PowerShell"
#  Tout se fait pour ton compte utilisateur, sans droits administrateur
#  (sauf l'installation de Windhawk, qui peut demander une confirmation).
# =====================================================================

$ErrorActionPreference = 'Stop'
Write-Host ''
Write-Host '=== Barre des taches Liquid Glass : reglages Windows ===' -ForegroundColor Cyan

function Set-Dword($Path, $Name, $Value) {
    if (-not (Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
    New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType DWord -Force | Out-Null
}

# 1. Masquer automatiquement la barre des taches (requis par "Taskbar auto-hide when maximized")
$sr = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3'
if (Test-Path $sr) {
    $v = (Get-ItemProperty -Path $sr -Name Settings).Settings
    $v[8] = 3
    Set-ItemProperty -Path $sr -Name Settings -Value $v
    Write-Host '[OK] Masquage automatique de la barre des taches active'
} else {
    Write-Host '[!] Masquage automatique : a activer a la main (voir README)' -ForegroundColor Yellow
}

# 2. Masquer le bouton Rechercher
Set-Dword 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' 'SearchboxTaskbarMode' 0
Write-Host '[OK] Bouton Rechercher masque'

# 3. Desactiver "Afficher le bureau" dans le coin de la barre (Win + D marche toujours)
Set-Dword 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' 'TaskbarSd' 0
Write-Host '[OK] Coin "Afficher le bureau" desactive'

# 4. Effets de transparence actives (necessaires pour le verre)
Set-Dword 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' 'EnableTransparency' 1
Write-Host '[OK] Effets de transparence actives'

# 5. Masquer l'indicateur de langue FRA/FR (en gardant les claviers ; Win + Espace pour changer)
try {
    Set-WinLanguageBarOption -UseLegacyLanguageBar
    Set-Dword 'HKCU:\Software\Microsoft\CTF\LangBar' 'ShowStatus' 3
    Write-Host '[OK] Indicateur de langue masque'
} catch {
    Write-Host '[!] Indicateur de langue : a masquer a la main (voir README)' -ForegroundColor Yellow
}

# 6. Installer Windhawk
if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host ''
    Write-Host 'Installation de Windhawk...' -ForegroundColor Cyan
    winget install --id RamenSoftware.Windhawk -e --accept-source-agreements --accept-package-agreements
} else {
    Write-Host '[!] winget introuvable : installe Windhawk depuis https://windhawk.net' -ForegroundColor Yellow
}

# 7. Redemarrer l'Explorateur pour appliquer
Write-Host ''
Write-Host 'Redemarrage de l''Explorateur...' -ForegroundColor Cyan
Stop-Process -Name explorer -Force
Start-Sleep -Seconds 2
if (-not (Get-Process explorer -ErrorAction SilentlyContinue)) { Start-Process explorer }

Write-Host ''
Write-Host 'Termine. Suite : etape 2 du README (installer les mods dans Windhawk).' -ForegroundColor Green
Read-Host 'Appuie sur Entree pour fermer'
