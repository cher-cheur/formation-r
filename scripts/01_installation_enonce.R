# =====================================================================
# Module 1 - Installation et environnement  (ÉNONCÉ)
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
# Taper ces calculs dans la console, puis les exécuter depuis le script :
# 2 plus 3, 10 divisé par 4, 2 puissance 10 (symbole ^).
# À COMPLÉTER


# --- Exercice 2 : où suis-je ? ---------------------------------------
# Afficher la version de R installée (objet R.version.string).
# À COMPLÉTER

# Afficher le dossier de travail (il doit être celui du projet).
# Fonction : getwd()
# À COMPLÉTER

# Lister les fichiers du dossier data.
# Fonction : list.files()
# À COMPLÉTER


# --- Exercice 3 : installer et charger un package --------------------
# Installer un package se fait UNE seule fois par poste.
# Vous l'avez fait à l'installation, dans la console (inutile de le relancer) :
# install.packages(c("dplyr", "ggplot2", "readr", "haven"))

# Charger un package se fait À CHAQUE nouvelle session R.
# Charger les packages dplyr, ggplot2 et readr avec library().
# À COMPLÉTER

# Vérifier la version du package dplyr avec packageVersion().
# À COMPLÉTER


# --- Exercice 4 : obtenir de l'aide ----------------------------------
# À taper dans la console : la page d'aide s'ouvre dans le panneau Aide.
# ?mean
# help(round)

# D'après l'aide de round(), arrondir 3.14159 à 2 décimales.
# À COMPLÉTER


# =====================================================================
# Pour aller plus loin
# =====================================================================

# Afficher les informations complètes de la session :
# version de R, système, packages chargés.
# Fonction : sessionInfo()
# À COMPLÉTER

# Compter le nombre de packages installés sur le poste.
# Indice : nrow() et installed.packages()
# À COMPLÉTER
