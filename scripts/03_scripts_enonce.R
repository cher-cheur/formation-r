# =====================================================================
# Module 3 - Scripts, fonctions, boucles et dplyr  (ÉNONCÉ)
# Formation « Langage R - initiation »
# =====================================================================
# Question métier : le profil social d'un collège explique-t-il
# ses résultats au brevet ?
# Données : IPS des collèges (2020-2021) et résultats au DNB (session 2021).
# ---------------------------------------------------------------------

library(dplyr)
library(readr)

ips <- read_csv2("data/ips_colleges_2020_2021.csv")


# =====================================================================
# Partie 1 - Fonctions intégrées et boucles (R de base)
# =====================================================================

# --- Exercice 1 : fonctions intégrées --------------------------------
# Calculer la moyenne, la médiane, le minimum, le maximum
# et l'écart-type de l'IPS.
# Fonctions : mean(), median(), min(), max(), sd()
# À COMPLÉTER

# Arrondir la moyenne à 1 décimale.
# À COMPLÉTER

# Lister les académies sans doublon (unique), puis les compter (length).
# À COMPLÉTER

# Passer le secteur en majuscules avec toupper(), puis compter avec table().
# Utile plus tard : l'autre fichier écrit PUBLIC et PRIVE en majuscules.
# À COMPLÉTER


# --- Exercice 2 : une boucle sur les académies -----------------------
# Pour chaque académie, afficher l'IPS moyen de ses collèges.
academies <- sort(unique(ips$academie))

for (academie in academies) {
  # Calculer la moyenne de l'IPS des collèges de cette académie
  # À COMPLÉTER
  cat(academie, ":", round(moyenne, 1), "\n")
}


# --- Exercice 3 : une condition dans la boucle -----------------------
# Même boucle, mais en affichant « au-dessus de la moyenne » ou
# « en dessous de la moyenne » selon la comparaison avec la moyenne nationale.
moyenne_nationale <- mean(ips$ips)

# À COMPLÉTER


# =====================================================================
# Partie 2 - Manipuler les données avec dplyr
# =====================================================================
# Le symbole |> (« pipe ») passe le résultat d'une étape à la suivante.
# Raccourci clavier dans RStudio : Ctrl + Maj + M.

# --- Exercice 4 : filtrer, sélectionner, trier -----------------------
# Garder les collèges publics de l'académie de Rennes dans rennes_public,
# puis compter les lignes.
# Fonction : filter()
# À COMPLÉTER

# Ne garder que le nom, la commune et l'IPS.
# Fonction : select()
# À COMPLÉTER

# Trier par IPS décroissant et afficher les 5 premiers.
# Fonctions : arrange(desc(...)), head()
# À COMPLÉTER


# --- Exercice 5 : importer et préparer les résultats du brevet -------
# Importer "data/dnb_etablissements_2017_2021.csv" dans un objet dnb.
# À COMPLÉTER

# Combien de lignes ? Quelles sessions ? Quels types d'établissements ?
# À COMPLÉTER

# Garder la session 2021 et les collèges (type "COLLEGE") ayant au moins
# un présent, dans un objet dnb_2021. Compter les lignes.
# À COMPLÉTER

# Créer avec mutate() le taux de réussite et les parts de mentions (en %) :
#   taux_reussite = admis / presents * 100
#   part_ab = nombre_d_admis_mention_ab / presents * 100
#   part_b  = admis_mention_bien / presents * 100
#   part_tb = admis_mention_tres_bien / presents * 100
# puis ne garder que : numero_d_etablissement, presents, admis,
# taux_reussite, part_ab, part_b, part_tb
# À COMPLÉTER


# --- Exercice 6 : joindre IPS et brevet ------------------------------
# La clé commune est le code UAI, qui ne porte pas le même nom
# dans les deux fichiers : uai d'un côté, numero_d_etablissement de l'autre.
# Joindre ips et dnb_2021 avec left_join() dans un objet colleges.
# Indice : by = c("uai" = "numero_d_etablissement")
# À COMPLÉTER

# Combien de collèges n'ont pas de résultat au brevet ?
# Indice : is.na() sur la colonne presents
# À COMPLÉTER

# Ne garder que les collèges présents dans les deux fichiers.
# À COMPLÉTER


# --- Exercice 7 : synthèses par académie et par secteur --------------
# Par académie : nombre de collèges (n()), IPS moyen, taux de réussite moyen,
# triés par IPS moyen décroissant. Ranger le résultat dans par_academie.
# Fonctions : group_by(), summarise(), arrange()
# À COMPLÉTER

# Par secteur : mêmes indicateurs, plus la part moyenne de mentions TB.
# À COMPLÉTER


# --- Exercice 8 : enregistrer le résultat ----------------------------
# Enregistrer colleges dans "data/colleges_ips_dnb_2021.csv" avec write_csv2().
# Ce fichier servira de point de départ pour le jour 2.
# À COMPLÉTER


# =====================================================================
# Pour aller plus loin
# =====================================================================

# Lister les collèges de l'IPS absents du fichier du brevet.
# Fonction : anti_join()
# À COMPLÉTER

# Synthèse croisée académie x secteur : nombre de collèges et IPS moyen.
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
