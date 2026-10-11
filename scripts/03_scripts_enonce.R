# =====================================================================
# Module 3 - Scripts, fonctions, boucles et dplyr  (ÉNONCÉ)
# Formation « Langage R - initiation »
# =====================================================================
# Question métier : le profil social d'un collège explique-t-il
# ses résultats au brevet ?
# Données : IPS des collèges (2020-2021) et résultats au DNB (session 2021).
#
# Chaque exercice commence par l'exemple vu en cours : exécutez-le,
# puis adaptez-le pour répondre aux questions « À vous ».
# ---------------------------------------------------------------------

library(dplyr)
library(readr)

ips <- read_csv2("data/ips_colleges_2020_2021.csv")


# =====================================================================
# Partie 1 - Fonctions intégrées et boucles (R de base)
# =====================================================================

# --- Exercice 1 : fonctions intégrées --------------------------------
# Exemple du cours : exécutez-le.
mean(ips$ips)
median(ips$ips)
sd(ips$ips)
round(mean(ips$ips), 1)
length(unique(ips$academie))

# À vous : écart d'IPS entre le collège le plus favorisé et le moins
# favorisé, en une seule ligne.
# À COMPLÉTER

# À vous : combien de départements différents compte le fichier ?
# À COMPLÉTER

# À vous : IPS médian des collèges publics.
# À COMPLÉTER

# À vous : passer le secteur en majuscules avec toupper(), puis compter
# avec table(). Utile plus tard : l'autre fichier écrit PUBLIC et PRIVE
# en majuscules.
# À COMPLÉTER


# --- Exercice 2 : une boucle ------------------------------------------
# Exemple du cours : exécutez-le.
# Pour chaque académie, afficher l'IPS moyen de ses collèges.
academies <- sort(unique(ips$academie))

for (academie in academies) {
  moyenne <- mean(ips$ips[ips$academie == academie])
  cat(academie, ":", round(moyenne, 1), "\n")
}

# À vous : même boucle, mais pour chaque académie, afficher son nombre
# de collèges. Indice : sum() compte les TRUE.
# À COMPLÉTER

# À vous : une boucle sur les secteurs (et non plus sur les académies),
# qui affiche l'IPS moyen de chaque secteur.
# Indice : commencer par secteurs <- unique(ips$secteur)
# À COMPLÉTER


# --- Exercice 3 : une condition dans la boucle -----------------------
# Exemple du cours : exécutez-le.
# Indiquer si l'académie est au-dessus ou en dessous de la moyenne nationale.
moyenne_nationale <- mean(ips$ips)

for (academie in academies) {
  moyenne <- mean(ips$ips[ips$academie == academie])
  if (moyenne > moyenne_nationale) {
    cat(academie, ": au-dessus de la moyenne\n")
  } else {
    cat(academie, ": en dessous de la moyenne\n")
  }
}

# À vous : n'afficher que les académies dont l'IPS moyen est inférieur
# à 95, avec leur IPS moyen. Un if peut s'écrire sans else.
# À COMPLÉTER


# =====================================================================
# Partie 2 - Manipuler les données avec dplyr
# =====================================================================
# Le symbole |> (« pipe ») passe le résultat d'une étape à la suivante.
# Raccourci clavier dans RStudio : Ctrl + Maj + M.

# --- Exercice 4 : filtrer, sélectionner, trier -----------------------
# Exemple du cours : exécutez-le.
# Les 5 collèges publics les plus favorisés de l'académie de Rennes.
rennes_public <- ips |>
  filter(academie == "RENNES", secteur == "public")
nrow(rennes_public)

rennes_public |>
  select(nom_de_l_etablissement, nom_de_la_commune, ips) |>
  arrange(desc(ips)) |>
  head(5)

# À vous : les 5 collèges publics les MOINS favorisés de l'académie de Lille
# (nom, commune, IPS). Indice : sans desc(), arrange() trie par ordre croissant.
# À COMPLÉTER

# À vous : combien de collèges de l'académie de Créteil ont un IPS
# inférieur à 80 ?
# À COMPLÉTER


# --- Exercice 5 : importer et préparer les résultats du brevet -------
dnb <- read_csv2("data/dnb_etablissements_2017_2021.csv")

# À vous : combien de lignes ? Quelles sessions ? Quels types d'établissements ?
# À COMPLÉTER

# Exemple du cours : exécutez-le.
# Garder la session 2021 et les collèges ayant au moins un présent,
# puis créer le taux de réussite et la part de mentions TB (en %).
dnb_2021 <- dnb |>
  filter(session == 2021, type_d_etablissement == "COLLEGE", presents > 0)
nrow(dnb_2021)

dnb_2021 <- dnb_2021 |>
  mutate(taux_reussite = admis / presents * 100,
         part_tb = admis_mention_tres_bien / presents * 100)

# À vous : sur le même modèle, créer part_ab (colonne nombre_d_admis_mention_ab)
# et part_b (colonne admis_mention_bien), puis ne garder que les colonnes
# numero_d_etablissement, presents, admis, taux_reussite, part_ab, part_b, part_tb.
# À COMPLÉTER


# --- Exercice 6 : joindre IPS et brevet ------------------------------
# Exemple du cours : exécutez-le.
# La clé commune est le code UAI, qui ne porte pas le même nom
# dans les deux fichiers.
colleges <- ips |>
  left_join(dnb_2021, by = c("uai" = "numero_d_etablissement"))

# Combien de collèges n'ont pas de résultat au brevet ?
sum(is.na(colleges$presents))

# À vous : ne garder que les collèges présents dans les deux fichiers,
# c'est-à-dire ceux dont presents n'est PAS manquant. Compter les lignes.
# Indice : ! veut dire « non » : !is.na(presents)
# À COMPLÉTER

# À vous : IPS, taux de réussite et part de mentions TB du collège
# Saint-Exupéry de Valserhône (UAI "0010008D").
# À COMPLÉTER


# --- Exercice 7 : synthèses par académie et par secteur --------------
# Exemple du cours : exécutez-le.
# Par secteur : nombre de collèges, IPS moyen, taux de réussite moyen,
# part moyenne de mentions TB.
par_secteur <- colleges |>
  group_by(secteur) |>
  summarise(nb_colleges = n(),
            ips_moyen = mean(ips),
            taux_moyen = mean(taux_reussite),
            part_tb_moyenne = mean(part_tb))
par_secteur

# À vous : la même synthèse par académie (nombre de collèges, IPS moyen,
# taux de réussite moyen), triée par IPS moyen décroissant.
# À COMPLÉTER

# À vous : quelle académie a le taux de réussite moyen le plus élevé ?
# À COMPLÉTER


# --- Exercice 8 : enregistrer le résultat ----------------------------
# À vous : vérifier d'abord que colleges compte bien 6935 lignes (sinon,
# reprendre l'exercice 6), puis l'enregistrer dans
# "data/colleges_ips_dnb_2021.csv" avec write_csv2().
# Ce fichier servira de point de départ au jour 2.
# À COMPLÉTER


# =====================================================================
# Pour aller plus loin
# =====================================================================

# Lister les collèges de l'IPS absents du fichier du brevet.
# Fonction : anti_join()
# À COMPLÉTER

# Synthèse croisée académie x secteur : nombre de collèges et IPS moyen.
# Indice : group_by(academie, secteur)
# À COMPLÉTER

# Écrire sa propre fonction ecart_moyenne(x) qui renvoie x - mean(x),
# puis l'utiliser dans mutate() pour créer une colonne ecart_ips.
# À COMPLÉTER

# Vérifier notre calcul du taux de réussite avec la colonne d'origine,
# écrite en texte (« 83,90% ») : parse_number() la convertit en nombre.
# Indice : parse_number(taux_de_reussite, locale = locale(decimal_mark = ","))
# À COMPLÉTER

# Retrouver la moyenne par académie de l'exercice 2, sans boucle.
# Fonction : tapply()
# À COMPLÉTER