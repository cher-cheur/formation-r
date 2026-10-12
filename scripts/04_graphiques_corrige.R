# =====================================================================
# Module 4 - Graphiques  (CORRIGÉ)
# Formation « Langage R - initiation »
# =====================================================================
# Données : la table jointe IPS x DNB 2021 préparée au module 3,
# et le fichier du brevet 2017-2021 pour les évolutions.
# Les graphiques s'affichent dans le panneau Plots de RStudio.
#
# Chaque exercice commence par l'exemple vu en cours : exécutez-le,
# puis adaptez-le pour répondre aux questions « À vous ».
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
# Exemple du cours : exécutez-le.
# Nombre de collèges par secteur.
nb_par_secteur <- table(colleges$secteur)
barplot(nb_par_secteur,
        main = "Nombre de collèges par secteur",
        ylab = "Nombre de collèges")

# IPS moyen par académie, trié : exécutez ces lignes.
ips_par_academie <- tapply(colleges$ips, colleges$academie, mean)
ips_par_academie <- sort(ips_par_academie)

# Élargir la marge de gauche (2e valeur) pour que les noms soient lisibles.
par(mar = c(5, 9, 4, 2))

# À vous : tracer ips_par_academie en barres horizontales, avec un titre
# (main) et un titre d'axe horizontal (xlab).
# Arguments : horiz = TRUE (barres horizontales), las = 1 (noms écrits
# à l'horizontale), cex.names = 0.6 (noms plus petits).
barplot(ips_par_academie,
        horiz = TRUE, las = 1, cex.names = 0.6,
        main = "IPS moyen des collèges par académie",
        xlab = "IPS moyen")

# Revenir aux marges par défaut.
par(mar = c(5, 4, 4, 2))


# --- Exercice 2 : courbe d'évolution ---------------------------------
# Exemple du cours : exécutez-le.
# Taux de réussite national des collèges au brevet, de 2017 à 2021.
evolution <- dnb |>
  filter(type_d_etablissement == "COLLEGE", presents > 0) |>
  group_by(session) |>
  summarise(taux_reussite = sum(admis) / sum(presents) * 100)
evolution

plot(evolution$session, evolution$taux_reussite,
     type = "b",
     main = "Taux de réussite au brevet des collèges",
     xlab = "Session", ylab = "Taux de réussite (%)")

# À vous : refaire le graphique avec un axe vertical qui va de 0 à 100.
# L'évolution paraît-elle aussi forte ? Indice : argument ylim = c(0, 100)
plot(evolution$session, evolution$taux_reussite,
     type = "b", ylim = c(0, 100),
     main = "Taux de réussite au brevet des collèges",
     xlab = "Session", ylab = "Taux de réussite (%)")


# --- Exercice 3 : diagramme en secteurs ------------------------------
# Exemple du cours : exécutez-le.
# Répartition des collèges entre public et privé.
pie(nb_par_secteur,
    main = "Répartition des collèges par secteur")

# Admis au brevet 2021 selon la mention, tous collèges confondus :
# exécutez ces lignes.
dnb_2021 <- dnb |>
  filter(session == 2021, type_d_etablissement == "COLLEGE")
mentions_2021 <- c(sans_mention = sum(dnb_2021$admis_sans_mention),
                   AB = sum(dnb_2021$nombre_d_admis_mention_ab),
                   B = sum(dnb_2021$admis_mention_bien),
                   TB = sum(dnb_2021$admis_mention_tres_bien))
mentions_2021

# À vous : représenter mentions_2021 en secteurs, puis en barres.
# Lequel des deux graphiques permet de comparer les mentions B et TB ?
pie(mentions_2021, main = "Admis au brevet 2021 selon la mention")
barplot(mentions_2021, main = "Admis au brevet 2021 selon la mention",
        ylab = "Nombre d'admis")


# --- Exercice 4 : histogramme et nuage de points ---------------------
# Exemple du cours : exécutez-le.
# Distribution de l'IPS.
hist(colleges$ips,
     main = "Distribution de l'IPS des collèges",
     xlab = "IPS", ylab = "Nombre de collèges")

# À vous : distribution du taux de réussite, avec des titres.
# Sa forme ressemble-t-elle à celle de l'IPS ?
hist(colleges$taux_reussite,
     main = "Distribution du taux de réussite au brevet",
     xlab = "Taux de réussite (%)", ylab = "Nombre de collèges")

# À vous : nuage de points de la part de mentions très bien (part_tb)
# en fonction de l'IPS, avec plot() et des titres.
plot(colleges$ips, colleges$part_tb,
     main = "Mentions très bien et profil social",
     xlab = "IPS", ylab = "Part de mentions TB (%)")


# =====================================================================
# Partie 2 - ggplot2
# =====================================================================
# Un graphique ggplot2 se construit par couches ajoutées avec + :
#   ggplot(données, aes(x = ..., y = ...)) + geom_...() + labs(...)

# --- Exercice 5 : nuage de points ------------------------------------
# Exemple du cours : exécutez-le.
# Le nuage de l'exercice 4, avec des points semi-transparents.
ggplot(colleges, aes(x = ips, y = part_tb)) +
  geom_point(alpha = 0.3) +
  labs(title = "Mentions très bien et profil social",
       x = "IPS", y = "Part de mentions TB (%)")

# À vous : même nuage pour le taux de réussite (taux_reussite) en fonction
# de l'IPS, avec des titres adaptés.
ggplot(colleges, aes(x = ips, y = taux_reussite)) +
  geom_point(alpha = 0.3) +
  labs(title = "Taux de réussite et profil social",
       x = "IPS", y = "Taux de réussite (%)")


# --- Exercice 6 : couleur et droite de tendance ----------------------
# Exemple du cours : exécutez-le.
# Colorer les points selon le secteur et ajouter une droite de régression.
ggplot(colleges, aes(x = ips, y = part_tb, colour = secteur)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "lm") +
  labs(title = "Mentions très bien et profil social, par secteur",
       x = "IPS", y = "Part de mentions TB (%)", colour = "Secteur")

# À vous : même chose pour le taux de réussite.
# Les deux droites sont-elles parallèles ? Laquelle monte le plus vite ?
ggplot(colleges, aes(x = ips, y = taux_reussite, colour = secteur)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "lm") +
  labs(title = "Taux de réussite et profil social, par secteur",
       x = "IPS", y = "Taux de réussite (%)", colour = "Secteur")


# --- Exercice 7 : histogramme ----------------------------------------
# À vous : distribution de l'IPS avec geom_histogram(binwidth = 5).
# Indice : un histogramme n'a besoin que de x : aes(x = ips).
ggplot(colleges, aes(x = ips)) +
  geom_histogram(binwidth = 5) +
  labs(title = "Distribution de l'IPS des collèges",
       x = "IPS", y = "Nombre de collèges")

# À vous : essayer binwidth = 1, puis binwidth = 20. Que change la
# largeur des classes ?
ggplot(colleges, aes(x = ips)) +
  geom_histogram(binwidth = 20)


# --- Exercice 8 : boîtes à moustaches --------------------------------
# Exemple du cours : exécutez-le.
# Taux de réussite selon le secteur.
ggplot(colleges, aes(x = secteur, y = taux_reussite)) +
  geom_boxplot() +
  labs(title = "Taux de réussite au brevet selon le secteur",
       x = "Secteur", y = "Taux de réussite (%)")

# À vous : l'IPS selon le secteur, en boîtes à moustaches.
# Les deux boîtes se chevauchent-elles ?
ggplot(colleges, aes(x = secteur, y = ips)) +
  geom_boxplot() +
  labs(title = "IPS des collèges selon le secteur",
       x = "Secteur", y = "IPS")


# --- Exercice 9 : un graphique par secteur ---------------------------
# À vous : reprendre le nuage de l'exercice 5 (taux_reussite en fonction
# de l'IPS) et le découper en deux panneaux, un par secteur.
# Indice : ajouter la couche facet_wrap(~ secteur).
ggplot(colleges, aes(x = ips, y = taux_reussite)) +
  geom_point(alpha = 0.3) +
  facet_wrap(~ secteur) +
  labs(title = "Taux de réussite et profil social",
       x = "IPS", y = "Taux de réussite (%)")


# --- Exercice 10 : courbes d'évolution par secteur -------------------
# Taux de réussite par session et par secteur : exécutez ces lignes.
evolution_secteur <- dnb |>
  filter(type_d_etablissement == "COLLEGE", presents > 0) |>
  group_by(session, secteur_d_enseignement) |>
  summarise(taux_reussite = sum(admis) / sum(presents) * 100,
            .groups = "drop")

# À vous : une courbe par secteur, avec colour = secteur_d_enseignement
# dans aes(), puis les couches geom_line() et geom_point().
ggplot(evolution_secteur,
       aes(x = session, y = taux_reussite, colour = secteur_d_enseignement)) +
  geom_line() +
  geom_point() +
  labs(title = "Taux de réussite au brevet des collèges",
       x = "Session", y = "Taux de réussite (%)", colour = "Secteur")


# =====================================================================
# Pour aller plus loin
# =====================================================================

# IPS par académie en boîtes horizontales, triées par IPS médian.
# Indice : aes(x = ips, y = reorder(academie, ips, FUN = median))
ggplot(colleges, aes(x = ips, y = reorder(academie, ips, FUN = median))) +
  geom_boxplot() +
  labs(title = "IPS des collèges par académie",
       x = "IPS", y = NULL)

# Reprendre le graphique de l'exercice 6 sans la droite, le ranger dans
# un objet graphique, choisir ses couleurs avec scale_colour_manual()
# et un thème sobre avec theme_minimal().
graphique <- ggplot(colleges, aes(x = ips, y = part_tb, colour = secteur)) +
  geom_point(alpha = 0.3) +
  scale_colour_manual(values = c("public" = "#1f77b4",
                                 "privé sous contrat" = "#ff7f0e")) +
  theme_minimal() +
  labs(title = "Mentions très bien et profil social",
       x = "IPS", y = "Part de mentions TB (%)", colour = "Secteur")
graphique

# Enregistrer ce graphique dans "graphiques/mentions_tb_ips.png" avec ggsave().
# Créer d'abord le dossier : dir.create("graphiques", showWarnings = FALSE)
dir.create("graphiques", showWarnings = FALSE)
ggsave("graphiques/mentions_tb_ips.png", graphique,
       width = 8, height = 5, dpi = 150)
