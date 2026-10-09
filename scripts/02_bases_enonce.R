# =====================================================================
# Module 2 - Bases du langage  (ÉNONCÉ)
# Formation « Langage R - initiation »
# =====================================================================
# Fil rouge : indices de position sociale (IPS) des collèges, 2020-2021.
# Plus l'IPS est élevé, plus le profil social des élèves est favorisé
# (la moyenne nationale est proche de 100).
# ---------------------------------------------------------------------


# --- Exercice 1 : calculs --------------------------------------------
# Calculer 17 divisé par 5, puis le quotient entier (%/%) et le reste (%%).
# À COMPLÉTER

# Calculer la racine carrée de 144 (sqrt) et arrondir pi à 2 décimales (round).
# À COMPLÉTER


# --- Exercice 2 : objets ---------------------------------------------
# Créer un objet effectif qui vaut 120, puis l'afficher.
# L'affectation s'écrit <-
effectif <- 120
effectif

# Créer un objet nb_classes qui vaut 5, puis calculer l'effectif moyen
# par classe dans un nouvel objet effectif_classe.
# À COMPLÉTER

# Piège : R distingue les majuscules et les minuscules.
# Dans la console, taper Effectif renvoie une erreur « objet introuvable ».
exists("effectif")
exists("Effectif")

# Lister tous les objets en mémoire (voir aussi le panneau Environnement).
# Fonction : ls()
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


# --- Exercice 4 : matrices -------------------------------------------
# Nombre de mentions (AB, B, TB) pour 3 collèges, rangé dans une matrice.
mentions <- matrix(c(38, 34, 45,
                     20, 25, 11,
                     30, 41, 52),
                   nrow = 3, byrow = TRUE)

# Donner des noms aux lignes et aux colonnes.
rownames(mentions) <- c("college_A", "college_B", "college_C")
colnames(mentions) <- c("AB", "B", "TB")
mentions

# Afficher les dimensions (dim), puis la ligne du collège B.
# À COMPLÉTER

# Total des mentions par collège (rowSums) et par type de mention (colSums).
# À COMPLÉTER


# --- Exercice 5 : listes ---------------------------------------------
# Une liste regroupe des objets de types différents.
college <- list(nom = "COLLEGE SAINT EXUPERY",
                ips = 98.8,
                mentions = c(AB = 38, B = 34, TB = 45))

# Afficher le nom (avec $), puis l'IPS (avec [[ ]]), puis la structure (str).
# À COMPLÉTER


# --- Exercice 6 : data frames ----------------------------------------
# Un data frame est un tableau : une ligne par collège, une colonne par variable.
# Créer petit_tableau avec trois colonnes :
#   nom = "A", "B", "C", "D", "E" ; ips = ips_exemple ; secteur = secteurs
# Fonction : data.frame()
# À COMPLÉTER

# Nombre de lignes, de colonnes, noms des colonnes.
# Fonctions : nrow(), ncol(), names()
# À COMPLÉTER

# Extraire la colonne ips avec $.
# À COMPLÉTER

# Garder les lignes dont l'IPS dépasse 100 (syntaxe [lignes, colonnes]).
# À COMPLÉTER

# Ajouter une colonne favorise qui vaut TRUE si l'IPS dépasse 100.
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

# IPS moyen des collèges publics.
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
