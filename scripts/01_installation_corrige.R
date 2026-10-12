# =====================================================================
# Module 1 - Installation et environnement  (CORRIGÉ)
# Formation « Langage R - initiation »
# =====================================================================
# Avant de commencer : avoir suivi installation/guide-installation.md
# jusqu'au message « POSTE PRÊT ». Le projet RStudio de la formation
# est donc ouvert.
# Gestes dans RStudio, à faire en binôme :
#   1. Repérer les 4 panneaux : script, console,
#      environnement / historique, fichiers / graphiques / aide.
#   2. Ouvrir ce script. Exécuter une ligne avec Ctrl + Entrée,
#      tout le script avec Ctrl + Maj + Entrée.
#   3. Enregistrer avec Ctrl + S.
# ---------------------------------------------------------------------


# --- Exercice 1 : R comme calculatrice -------------------------------
# Taper ces calculs dans la console, puis les exécuter depuis le script.
# La puissance s'écrit ** (le symbole ^ fonctionne aussi, mais il est
# difficile à taper sur certains claviers).
2 + 3
10 / 4
2 ** 10

# Combien de minutes dure la formation (2 jours de 6 heures) ?
2 * 6 * 60


# --- Exercice 2 : où suis-je ? ---------------------------------------
# Afficher la version de R installée.
R.version.string

# Afficher le dossier de travail (il doit être celui du projet).
getwd()

# Lister les fichiers du dossier data.
list.files("data")


# --- Exercice 3 : installer et charger un package --------------------
# Installer un package se fait UNE seule fois par poste.
# Vous l'avez fait à l'installation, dans la console (inutile de le relancer) :
# install.packages(c("dplyr", "ggplot2", "readr", "haven"))

# Charger un package se fait À CHAQUE nouvelle session R.
library(dplyr)
library(ggplot2)
library(readr)

# Vérifier la version d'un package installé.
packageVersion("dplyr")


# --- Exercice 4 : obtenir de l'aide ----------------------------------
# À taper dans la console : la page d'aide s'ouvre dans le panneau Aide.
# ?mean
# help(round)

# Exemple du cours : arrondir à 2 décimales.
round(3.14159, digits = 2)

# D'après la section Details de l'aide, digits peut être négatif.
# Arrondir 6953 (le nombre de collèges du fichier) à la centaine.
round(6953, digits = -2)


# =====================================================================
# Pour aller plus loin
# =====================================================================

# Afficher les informations complètes de la session :
# version de R, système, packages chargés.
sessionInfo()

# Lister tous les packages installés sur le poste (et en compter le nombre).
nrow(installed.packages())
