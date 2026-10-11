# =====================================================================
# Module 2 - Bases du langage  (ÉNONCÉ)
# Formation « Langage R - initiation »
# =====================================================================
# Fil rouge : indices de position sociale (IPS) des collèges, 2020-2021.
# Plus l'IPS est élevé, plus le profil social des élèves est favorisé
# (la moyenne nationale est proche de 100).
#
# Chaque exercice commence par l'exemple vu en cours : exécutez-le,
# puis adaptez-le pour répondre aux questions « À vous ».
# ---------------------------------------------------------------------


# --- Exercice 1 : calculs --------------------------------------------
# Exemple du cours : exécutez-le.
17 / 5
17 %/% 5
17 %% 5
sqrt(144)
round(pi, 2)

# À vous : 128 élèves de 6e se répartissent en groupes de 5.
# Combien de groupes complets ? Combien d'élèves restent sans groupe ?
# À COMPLÉTER

# À vous : afficher la racine carrée de 17 avec seulement 2 chiffres
# après la virgule, en une seule ligne.
# À COMPLÉTER


# --- Exercice 2 : objets ---------------------------------------------
# Exemple du cours : exécutez-le.
# <- range une valeur dans un objet. Le signe = fonctionne aussi, mais
# on le réserve aux arguments des fonctions : round(pi, digits = 2).
effectif <- 120
nb_classes <- 5
effectif_classe <- effectif / nb_classes
effectif_classe

# À vous : le collège accueille 30 élèves de plus.
# Mettre à jour effectif, puis afficher effectif_classe. A-t-il changé ?
# Pourquoi ? Que faut-il faire pour obtenir le bon résultat ?
# À COMPLÉTER

# Piège : R distingue les majuscules et les minuscules.
exists("effectif")
exists("Effectif")

# À vous : créer un objet Effectif (majuscule) qui vaut 0.
# effectif a-t-il changé ? Combien d'objets y a-t-il en mémoire ?
# Fonction : ls(), et regardez le panneau Environnement.
# À COMPLÉTER


# --- Exercice 3 : vecteurs -------------------------------------------
# Créer un vecteur ips_exemple avec les IPS de 5 collèges :
# 98.8, 111.8, 106.3, 103.6, 88.7
# Fonction : c()
# À COMPLÉTER

# Afficher sa longueur et sa moyenne.
# À COMPLÉTER

# Calculer l'écart à 100 de chaque collège, en une seule opération.
# C'est la vectorisation : pas besoin de boucle.
# À COMPLÉTER

# Quels collèges ont un IPS supérieur à 100 ?
# À COMPLÉTER

# Combien sont-ils ? Indice : sum() compte les TRUE.
# À COMPLÉTER

# Extraire le 2e élément, puis les IPS supérieurs à 100.
# Indice : les crochets [ ]
# À COMPLÉTER

# Créer un vecteur de texte secteurs avec le secteur de ces 5 collèges :
# "public", "prive", "public", "public", "public"
# À COMPLÉTER

# Valeurs manquantes : un 6e collège n'a pas d'IPS connu.
ips_manquant <- c(98.8, 111.8, NA, 103.6, 88.7)

# Calculer la moyenne de ips_manquant. Que se passe-t-il ?
# Recommencer en ajoutant l'argument na.rm = TRUE.
# À COMPLÉTER

# Repérer les valeurs manquantes avec is.na(), puis les compter avec sum().
# À COMPLÉTER


# --- Exercice 4 : listes ---------------------------------------------
# Exemple du cours : exécutez-le.
# Une liste regroupe des objets de types différents : ici, la fiche d'un
# collège, avec ses mentions au brevet (AB = assez bien, B = bien, TB = très bien).
college <- list(nom = "COLLEGE SAINT EXUPERY",
                ips = 98.8,
                mentions = c(AB = 45, B = 42, TB = 37))
college$nom
college[["ips"]]
str(college)

# À vous : afficher les mentions du collège, puis leur nombre total.
# À COMPLÉTER

# À vous : afficher seulement le nombre de mentions TB.
# Indice : un vecteur dont les éléments ont un nom s'extrait aussi par ce nom.
# À COMPLÉTER


# --- Exercice 5 : matrices -------------------------------------------
# Exemple du cours : exécutez-le.
# Les mentions (AB, B, TB) de 3 collèges, rangées dans une matrice :
# une ligne par collège, une colonne par mention.
# college_A est le collège Saint-Exupéry de l'exercice 4.
mentions <- matrix(c(45, 42, 37,
                     20, 25, 11,
                     30, 41, 52),
                   nrow = 3, byrow = TRUE)
rownames(mentions) <- c("college_A", "college_B", "college_C")
colnames(mentions) <- c("AB", "B", "TB")
mentions
mentions["college_B", ]
rowSums(mentions)

# À vous : afficher les dimensions de la matrice (dim).
# À COMPLÉTER

# À vous : afficher la colonne des mentions TB, puis le nombre de
# mentions TB du collège C seulement.
# Indice : [ligne, colonne] ; une place laissée vide veut dire « tout ».
# À COMPLÉTER

# À vous : total des mentions par type de mention (par colonne).
# À COMPLÉTER

# À vous : part des mentions TB dans chaque collège, en %, arrondie à 1 décimale.
# À COMPLÉTER


# --- Exercice 6 : data frames ----------------------------------------
# Exemple du cours : exécutez-le (il utilise ips_exemple et secteurs
# de l'exercice 3).
# Un data frame est un tableau : une ligne par collège, une colonne par variable.
petit_tableau <- data.frame(nom = c("A", "B", "C", "D", "E"),
                            ips = ips_exemple,
                            secteur = secteurs)
petit_tableau$ips
petit_tableau[petit_tableau$ips > 100, ]
petit_tableau$favorise <- petit_tableau$ips > 100
petit_tableau

# À vous : nombre de lignes, de colonnes, noms des colonnes.
# Fonctions : nrow(), ncol(), names()
# À COMPLÉTER

# À vous : garder les collèges du public, avec les colonnes nom et ips seulement.
# Indice : pour l'égalité, on écrit == ; plusieurs colonnes : c("nom", "ips")
# À COMPLÉTER

# À vous : ajouter une colonne ecart qui donne l'écart de l'IPS à 100.
# À COMPLÉTER

# À vous : IPS moyen des collèges du public.
# À COMPLÉTER


# --- Exercice 7 : importer le fichier des IPS ------------------------
# Le fichier utilise ";" comme séparateur et "," pour les décimales :
# c'est le format CSV « à la française », lu par read.csv2().
# Importer "data/ips_colleges_2020_2021.csv" dans un objet ips,
# avec l'argument fileEncoding = "UTF-8".
# À COMPLÉTER

# Afficher les premières lignes, la structure et le nombre de collèges.
# Fonctions : head(), str(), nrow()
# À COMPLÉTER

# Résumé statistique de la colonne ips (summary).
# À COMPLÉTER

# Nombre de collèges par secteur (table).
# À COMPLÉTER

# IPS moyen des collèges publics (même écriture qu'à l'exercice 6).
# À COMPLÉTER

# Combien de collèges ont un IPS inférieur à 80 ?
# À COMPLÉTER

# Piège de la casse : combien de collèges ont le secteur "Public" ?
# À COMPLÉTER

# Même import avec le package readr : le résultat est un « tibble »,
# un data frame qui s'affiche de façon plus lisible.
# Charger readr, puis importer le fichier dans ips2 avec read_csv2().
# À COMPLÉTER


# =====================================================================
# Pour aller plus loin
# =====================================================================

# Transformer le secteur en facteur (factor) et afficher ses modalités (levels).
# À COMPLÉTER

# Les 5 académies qui comptent le plus de collèges.
# Indice : table(), sort(..., decreasing = TRUE), head()
# À COMPLÉTER

# Les déciles de l'IPS.
# Indice : quantile(ips$ips, probs = seq(0, 1, by = 0.1))
# À COMPLÉTER

# Le collège le plus favorisé et le moins favorisé (nom, commune, IPS).
# Indice : which.max(), which.min()
# À COMPLÉTER

# Supprimer de la mémoire ips2 et petit_tableau (rm), puis vérifier avec ls().
# À COMPLÉTER
