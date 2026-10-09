# =====================================================================
# Module 4 - Graphiques  (ÉNONCÉ)
# Formation « Langage R - initiation »
# =====================================================================
# Données : la table jointe IPS x DNB 2021 préparée au module 3,
# et le fichier du brevet 2017-2021 pour les évolutions.
# Les graphiques s'affichent dans le panneau Plots de RStudio.
# ---------------------------------------------------------------------

library(dplyr)
library(readr)
library(ggplot2)

colleges <- read_csv2("data/colleges_ips_dnb_2021.csv")
dnb <- read_csv2("data/dnb_etablissements_2017_2021.csv")


# =====================================================================
# Partie 1 - Graphiques de base
# =====================================================================

# --- Exercice 1 : diagramme en barres --------------------------------
# Nombre de collèges par secteur : ranger table(colleges$secteur) dans
# nb_par_secteur, puis le représenter avec barplot().
# Ajouter un titre (main) et un titre d'axe vertical (ylab).
# À COMPLÉTER

# IPS moyen par académie, trié, en barres horizontales.
ips_par_academie <- tapply(colleges$ips, colleges$academie, mean)
ips_par_academie <- sort(ips_par_academie)

# Élargir la marge de gauche (2e valeur) pour que les noms soient lisibles.
par(mar = c(5, 9, 4, 2))
# Tracer ips_par_academie avec barplot() et les arguments
# horiz = TRUE, las = 1, cex.names = 0.6, main et xlab.
# À COMPLÉTER
# Revenir aux marges par défaut.
par(mar = c(5, 4, 4, 2))


# --- Exercice 2 : courbe d'évolution ---------------------------------
# Taux de réussite national des collèges au brevet, de 2017 à 2021.
evolution <- dnb |>
  filter(type_d_etablissement == "COLLEGE", presents > 0) |>
  group_by(session) |>
  summarise(taux_reussite = sum(admis) / sum(presents) * 100)
evolution

# Tracer taux_reussite en fonction de session avec plot(),
# type = "b" (points reliés), un titre et des titres d'axes.
# À COMPLÉTER


# --- Exercice 3 : diagramme en secteurs ------------------------------
# Répartition des collèges entre public et privé, avec pie().
# À COMPLÉTER


# --- Exercice 4 : histogramme et nuage de points ---------------------
# Distribution de l'IPS avec hist().
# À COMPLÉTER

# Part de mentions très bien (part_tb) en fonction de l'IPS, avec plot().
# À COMPLÉTER


# =====================================================================
# Partie 2 - ggplot2
# =====================================================================
# Un graphique ggplot2 se construit par couches ajoutées avec + :
#   ggplot(données, aes(x = ..., y = ...)) + geom_...() + labs(...)

# --- Exercice 5 : nuage de points ------------------------------------
# Même nuage qu'à l'exercice 4, avec geom_point(alpha = 0.3)
# et des titres avec labs(title = , x = , y = ).
# À COMPLÉTER


# --- Exercice 6 : couleur et droite de tendance ----------------------
# Colorer les points selon le secteur (colour = secteur dans aes)
# et ajouter une droite de régression avec geom_smooth(method = "lm").
# À COMPLÉTER


# --- Exercice 7 : histogramme ----------------------------------------
# Distribution de l'IPS avec geom_histogram(binwidth = 5).
# À COMPLÉTER


# --- Exercice 8 : boîtes à moustaches --------------------------------
# Taux de réussite selon le secteur, avec geom_boxplot().
# À COMPLÉTER


# --- Exercice 9 : un graphique par secteur ---------------------------
# Nuage taux_reussite en fonction de l'IPS, découpé en deux panneaux
# avec facet_wrap(~ secteur).
# À COMPLÉTER


# --- Exercice 10 : courbes d'évolution par secteur -------------------
evolution_secteur <- dnb |>
  filter(type_d_etablissement == "COLLEGE", presents > 0) |>
  group_by(session, secteur_d_enseignement) |>
  summarise(taux_reussite = sum(admis) / sum(presents) * 100,
            .groups = "drop")

# Une courbe par secteur : colour = secteur_d_enseignement dans aes,
# puis geom_line() et geom_point().
# À COMPLÉTER


# =====================================================================
# Pour aller plus loin
# =====================================================================

# IPS par académie en boîtes horizontales, triées par IPS médian.
# Indice : aes(x = ips, y = reorder(academie, ips, FUN = median))
# À COMPLÉTER

# Reprendre le graphique de l'exercice 6 sans la droite, le ranger dans
# un objet graphique, choisir ses couleurs avec scale_colour_manual()
# et un thème sobre avec theme_minimal().
# À COMPLÉTER

# Enregistrer ce graphique dans "graphiques/mentions_tb_ips.png" avec ggsave().
# Créer d'abord le dossier : dir.create("graphiques", showWarnings = FALSE)
# À COMPLÉTER
