# =====================================================================
# Module 2 - Bases du langage  (CORRIGÉ)
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
128 %/% 5
128 %% 5

# À vous : afficher la racine carrée de 17 avec seulement 2 chiffres
# après la virgule, en une seule ligne.
round(sqrt(17), 2)


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
effectif <- effectif + 30
effectif_classe

# Non : effectif_classe a gardé l'ancienne valeur. Un objet contient une
# valeur, pas une formule. Il faut relancer le calcul.
effectif_classe <- effectif / nb_classes
effectif_classe

# Piège : R distingue les majuscules et les minuscules.
exists("effectif")
exists("Effectif")

# À vous : créer un objet Effectif (majuscule) qui vaut 0.
# effectif a-t-il changé ? Combien d'objets y a-t-il en mémoire ?
Effectif <- 0
effectif
ls()


# --- Exercice 3 : vecteurs -------------------------------------------
# Créer un vecteur ips_exemple avec les IPS de 5 collèges :
# 98.8, 111.8, 106.3, 103.6, 88.7
ips_exemple <- c(98.8, 111.8, 106.3, 103.6, 88.7)

# Afficher sa longueur et sa moyenne.
length(ips_exemple)
mean(ips_exemple)

# Calculer l'écart à 100 de chaque collège, en une seule opération.
# C'est la vectorisation : pas besoin de boucle.
ips_exemple - 100

# Quels collèges ont un IPS supérieur à 100 ?
ips_exemple > 100

# Combien sont-ils ? (sum() compte les TRUE)
sum(ips_exemple > 100)

# Extraire le 2e élément, puis les IPS supérieurs à 100.
ips_exemple[2]
ips_exemple[ips_exemple > 100]

# Créer un vecteur de texte avec le secteur de ces 5 collèges.
secteurs <- c("public", "prive", "public", "public", "public")
secteurs

# Valeurs manquantes : un 6e collège n'a pas d'IPS connu.
ips_manquant <- c(98.8, 111.8, NA, 103.6, 88.7)

# La moyenne vaut NA tant qu'on ne demande pas d'ignorer les manquants.
mean(ips_manquant)
mean(ips_manquant, na.rm = TRUE)

# Repérer et compter les valeurs manquantes.
is.na(ips_manquant)
sum(is.na(ips_manquant))


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
college$mentions
sum(college$mentions)

# À vous : afficher seulement le nombre de mentions TB.
# Indice : un vecteur dont les éléments ont un nom s'extrait aussi par ce nom.
college$mentions["TB"]


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

# À vous : afficher les dimensions de la matrice.
dim(mentions)

# À vous : afficher la colonne des mentions TB, puis le nombre de
# mentions TB du collège C seulement.
mentions[, "TB"]
mentions["college_C", "TB"]

# À vous : total des mentions par type de mention (par colonne).
colSums(mentions)

# À vous : part des mentions TB dans chaque collège, en %, arrondie à 1 décimale.
round(mentions[, "TB"] / rowSums(mentions) * 100, 1)


# --- Exercice 6 : data frames ----------------------------------------
# Exemple du cours : exécutez-le.
# Un data frame est un tableau : une ligne par collège, une colonne par variable.
petit_tableau <- data.frame(nom = c("A", "B", "C", "D", "E"),
                            ips = ips_exemple,
                            secteur = secteurs)
petit_tableau$ips
petit_tableau[petit_tableau$ips > 100, ]
petit_tableau$favorise <- petit_tableau$ips > 100
petit_tableau

# À vous : nombre de lignes, de colonnes, noms des colonnes.
nrow(petit_tableau)
ncol(petit_tableau)
names(petit_tableau)

# À vous : garder les collèges du public, avec les colonnes nom et ips seulement.
petit_tableau[petit_tableau$secteur == "public", c("nom", "ips")]

# À vous : ajouter une colonne ecart qui donne l'écart de l'IPS à 100.
petit_tableau$ecart <- petit_tableau$ips - 100
petit_tableau

# À vous : IPS moyen des collèges du public.
mean(petit_tableau$ips[petit_tableau$secteur == "public"])


# --- Exercice 7 : importer le fichier des IPS ------------------------
# Le fichier utilise ";" comme séparateur et "," pour les décimales :
# c'est le format CSV « à la française », lu par read.csv2().
ips <- read.csv2("data/ips_colleges_2020_2021.csv", fileEncoding = "UTF-8")

# Afficher les premières lignes, la structure et le nombre de collèges.
head(ips)
str(ips)
nrow(ips)

# Résumé statistique de la colonne ips.
summary(ips$ips)

# Nombre de collèges par secteur.
table(ips$secteur)

# IPS moyen des collèges publics (même écriture qu'à l'exercice 6).
mean(ips$ips[ips$secteur == "public"])

# Combien de collèges ont un IPS inférieur à 80 ?
sum(ips$ips < 80)

# Piège de la casse : "Public" n'existe pas dans les données.
sum(ips$secteur == "Public")

# Même import avec le package readr : le résultat est un « tibble »,
# un data frame qui s'affiche de façon plus lisible.
library(readr)
ips2 <- read_csv2("data/ips_colleges_2020_2021.csv")
ips2


# =====================================================================
# Pour aller plus loin
# =====================================================================

# Transformer le secteur en facteur (variable qualitative) et afficher ses modalités.
ips$secteur <- factor(ips$secteur)
levels(ips$secteur)

# Les 5 académies qui comptent le plus de collèges.
nb_par_academie <- table(ips$academie)
head(sort(nb_par_academie, decreasing = TRUE), 5)

# Les déciles de l'IPS.
quantile(ips$ips, probs = seq(0, 1, by = 0.1))

# Le collège le plus favorisé et le moins favorisé.
ips[which.max(ips$ips), c("nom_de_l_etablissement", "nom_de_la_commune", "ips")]
ips[which.min(ips$ips), c("nom_de_l_etablissement", "nom_de_la_commune", "ips")]

# Supprimer de la mémoire les objets qui ne servent plus.
rm(ips2, petit_tableau)
ls()
