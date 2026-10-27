# Barre des tâches « Liquid Glass » – installation sur un nouveau PC

Ce dossier refait à l'identique la barre des tâches : deux îlots en verre clair centrés, coins arrondis façon Apple, liseré discret, icônes nettes avec zoom au survol, et barre masquée quand une fenêtre la touche.

Prérequis : **Windows 11**. Compte environ 10 minutes.

## Contenu du dossier

| Fichier | Rôle |
|---|---|
| `1-reglages-windows.ps1` | Règle Windows automatiquement et installe Windhawk |
| `windhawk/1-taskbar-height-and-icon-size.yaml` | Réglages du mod « Taskbar height and icon size » |
| `windhawk/2-taskbar-dock-animation-plus.yaml` | Réglages du mod « Taskbar Dock Animation Plus » |
| `windhawk/3-windows-11-taskbar-styler.yaml` | Le thème complet (verre, arrondis, îlots, survols) |

---

## Étape 1 – Réglages Windows et installation de Windhawk

Fais un clic droit sur `1-reglages-windows.ps1`, puis **Exécuter avec PowerShell**. Le script :

- active le masquage automatique de la barre des tâches ;
- masque le bouton Rechercher ;
- désactive le coin « Afficher le bureau » (`Win + D` marche toujours) ;
- active les effets de transparence ;
- masque l'indicateur de langue FRA/FR, en gardant tes claviers (`Win + Espace` pour changer) ;
- installe Windhawk avec winget, puis redémarre l'Explorateur.

> Si Windows bloque le script : clic droit sur le fichier → **Propriétés** → coche **Débloquer** → OK, puis relance-le.
> Si tu préfères tout faire à la main, suis la section « Réglages Windows à la main » plus bas.

## Étape 2 – Installer les mods dans Windhawk

Ouvre Windhawk et installe les mods **dans cet ordre**. Pour chacun :

1. **Explorer** → cherche le nom du mod → **Détails** → **Installer**.
2. Vérifie l'auteur indiqué dans la fenêtre d'avertissement, puis **Accepter les risques et installer**.
3. Si un fichier est indiqué : onglet **Paramètres** → **Textual mode** → efface tout → colle le contenu du fichier → **Sauvegarder les paramètres**.

| # | Mod | Auteur | Réglages |
|---|---|---|---|
| 1 | Taskbar auto-hide when maximized | m417z | Aucun changement (le mode par défaut « maximized or intersects » est le bon) |
| 2 | Taskbar auto-hide speed | m417z | Aucun changement |
| 3 | Taskbar height and icon size | m417z | `windhawk/1-taskbar-height-and-icon-size.yaml` |
| 4 | **Taskbar Dock Animation Plus** | incconutwo | `windhawk/2-taskbar-dock-animation-plus.yaml` |
| 5 | Windows 11 Taskbar Styler | m417z | `windhawk/3-windows-11-taskbar-styler.yaml` |

Points d'attention :

- Pour le n° 4, prends bien la version **Plus** d'incconutwo, et non « Taskbar Dock Animation » de Ph0en1x-dev. Ne les installe jamais ensemble.
- Fais le **Taskbar Styler en dernier**. Tant qu'il n'est pas réglé, la barre paraît trop haute et les icônes trop grosses : c'est normal.
- Dans le Taskbar Styler, laisse le menu **Theme** sur **None**. Le thème est déjà inclus dans le fichier.
- **N'installe pas** « MacOS Style Dock », « Mac Island & Dock » ni « Better Taskbar Autohide » : ils entrent en conflit avec cette configuration.

## Étape 3 – Redémarrer l'Explorateur

`Ctrl + Maj + Échap` → **Explorateur Windows** → **Redémarrer**.

---

## Réglages Windows à la main (si tu n'utilises pas le script)

- **Masquage automatique** : Paramètres → Personnalisation → Barre des tâches → Comportements de la barre des tâches → coche « Masquer automatiquement la barre des tâches ».
- **Afficher le bureau** : au même endroit, décoche « Sélectionnez le coin le plus éloigné de la barre des tâches pour afficher le bureau ».
- **Rechercher** : Paramètres → Personnalisation → Barre des tâches → Rechercher → **Masquer**.
- **Transparence** : Paramètres → Personnalisation → Couleurs → active « Effets de transparence ».
- **Indicateur de langue** : Paramètres → Heure et langue → Saisie → Paramètres avancés du clavier → coche « Utiliser la barre de langue du Bureau si elle est disponible » → Options de la barre de langue → **Masquée** → OK.
- **Windhawk** : à télécharger sur [windhawk.net](https://windhawk.net).

---

## Personnaliser

Les réglages principaux sont dans les **Style constants**, en haut de `3-windows-11-taskbar-styler.yaml`. Après une modification, recolle le fichier dans le Taskbar Styler et sauvegarde.

| Constante | Valeur | Effet |
|---|---|---|
| `LiquidClear` → `TintOpacity` | `0.06` | Transparence de la barre (plus haut = plus laiteux) |
| `LiquidClear` → `BlurAmount` | `4` | Flou derrière la barre |
| `IslandRim` | `#2E` / `#0B` / `#1A` | Intensité du liseré des îlots |
| `RadiusBar` | `14` | Arrondi des îlots (`22` = forme de pilule) |
| `RadiusTile` | `10` | Arrondi des survols |
| `CornerRadius` | `26` | Arrondi des menus du volume, d'Alt+Tab et des miniatures |
| `RadiusMenu` | `16` | Arrondi des menus clic droit |
| `IslandGap` | `6` | Demi-écart entre les deux îlots (6 = 12 px au total) |

L'épaisseur du liseré se règle avec les deux lignes `BorderThickness=2` des îlots. L'effet de zoom se règle avec `MaxScale` dans le mod Dock Animation Plus : `110` actuellement, à garder à 133 maximum pour que les icônes restent nettes.

## Dépannage

- **Les icônes sont grosses ou floues** : le Taskbar Styler n'est pas réglé, ou a été réglé avant « Taskbar height and icon size ». Recolle son fichier, puis redémarre l'Explorateur.
- **Erreur « Type mismatch … expected number, but got boolean »** : remplace `false` par `0` et `true` par `1` dans les réglages du mod concerné.
- **Une icône dépasse ou est coupée au survol** : baisse `MaxScale` dans Dock Animation Plus.
- **Le rendu ne change pas après une sauvegarde** : redémarre l'Explorateur.
- **Après une mise à jour de Windows ou d'un mod, un détail se décale** : c'est possible, puisque ces mods modifient l'interface de Windows. Désactiver un mod dans Windhawk remet toujours l'élément d'origine.

## Crédits

- Thème de base **WindowGlass**, par Nathaniel4JC ([Windows 11 taskbar styling guide](https://github.com/ramensoftware/windows-11-taskbar-styling-guide)), modifié pour cette configuration.
- Mods Windhawk : m417z (Ramen Software) et incconutwo.
