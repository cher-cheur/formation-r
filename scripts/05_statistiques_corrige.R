# =====================================================================
# Module 5 - Analyse statistique  (CORRIGÉ)
# Formation « Langage R - initiation »
# =====================================================================
# Question métier : le profil social d'un collège explique-t-il
# ses résultats au brevet ?
# Outils : corrélation (cor), régression linéaire (lm),
#          analyse en composantes principales (prcomp).
#
# Chaque exercice commence par l'exemple vu en cours : exécutez-le,
# puis adaptez-le pour répondre aux questions « À vous ».
# ---------------------------------------------------------------------

library(dplyr)
library(readr)
library(ggplot2)

colleges <- read_csv2("data/colleges_ips_dnb_2021.csv")

# Les très petits collèges ont des taux instables (1 élève absent = -5 points
# sur 20 présents). On garde les collèges d'au moins 20 présents.
colleges <- colleges |>
  filter(presents >= 20)
nrow(colleges)


# =====================================================================
# Partie 1 - Corrélation et régression linéaire
# =====================================================================

# --- Exercice 1 : corrélations ---------------------------------------
# Exemple du cours : exécutez-le.
# Corrélation entre l'IPS et la part de mentions très bien.
cor(colleges$ips, colleges$part_tb)

# À vous : corrélation entre l'IPS et le taux de réussite.
# Le lien est-il plus fort ou plus faible ?
cor(colleges$ips, colleges$taux_reussite)

# À vous : matrice des corrélations entre ips, taux_reussite, part_ab,
# part_b et part_tb, arrondie à 2 décimales.
# Indice : select() les colonnes dans un objet variables, puis round(cor(variables), 2)
# Quelle mention est la plus liée à l'IPS ? Laquelle varie en sens inverse ?
variables <- colleges |>
  select(ips, taux_reussite, part_ab, part_b, part_tb)
round(cor(variables), 2)


# --- Exercice 2 : une régression linéaire simple ---------------------
# Exemple du cours : exécutez-le.
# Expliquer la part de mentions TB par l'IPS.
# La formule se lit : part_tb « en fonction de » ips.
modele <- lm(part_tb ~ ips, data = colleges)
summary(modele)
coef(modele)
summary(modele)$r.squared

# À vous (en commentaire) : la constante a-t-elle un sens concret ?
# Réponse : constante = -26,5. C'est la valeur prédite pour un IPS de 0, qui n'existe
# pas : elle n'a pas de sens concret, elle sert seulement à placer la droite.

# À vous : la même régression pour le taux de réussite, dans un objet
# modele_reussite. Afficher son résumé, ses coefficients et son R².
modele_reussite <- lm(taux_reussite ~ ips, data = colleges)
summary(modele_reussite)
coef(modele_reussite)
summary(modele_reussite)$r.squared

# À vous (en commentaire) : traduire la pente pour une hausse de 10 points
# d'IPS. Le lien est-il significatif ?
# Réponse : pente = +0,31. Quand l'IPS augmente de 10 points, le taux de réussite
# augmente en moyenne de 3 points. p-value < 2e-16 : le lien est significatif.


# --- Exercice 3 : visualiser la droite -------------------------------
# Exemple du cours : exécutez-le.
plot(colleges$ips, colleges$part_tb,
     main = "Régression de la part de mentions TB sur l'IPS",
     xlab = "IPS", ylab = "Part de mentions TB (%)")
abline(modele, col = "red", lwd = 2)

# À vous : même graphique pour le taux de réussite et modele_reussite.
plot(colleges$ips, colleges$taux_reussite,
     main = "Régression du taux de réussite sur l'IPS",
     xlab = "IPS", ylab = "Taux de réussite (%)")
abline(modele_reussite, col = "red", lwd = 2)


# --- Exercice 4 : prédire --------------------------------------------
# Exemple du cours : exécutez-le.
# Part de mentions TB attendue pour des collèges d'IPS 80, 100 et 120.
nouveaux <- data.frame(ips = c(80, 100, 120))
predict(modele, newdata = nouveaux)

# À vous : taux de réussite attendu pour les mêmes IPS, avec modele_reussite.
predict(modele_reussite, newdata = nouveaux)

# À vous : un collège d'IPS 90 a 95 % de réussite. Fait-il mieux ou moins
# bien que ce que son IPS laisse prévoir ? De combien de points ?
predict(modele_reussite, newdata = data.frame(ips = 90))
95 - predict(modele_reussite, newdata = data.frame(ips = 90))


# --- Exercice 5 : les résidus ----------------------------------------
# Exemple du cours : exécutez-le.
# Le résidu est l'écart entre la valeur observée et la valeur prédite.
# Un résidu positif : le collège fait mieux que ce que son IPS laisse prévoir.
colleges$residu <- residuals(modele)

# À vous : histogramme des résidus, avec des titres.
hist(colleges$residu,
     main = "Distribution des résidus",
     xlab = "Résidu (points de mentions TB)",
     ylab = "Nombre de collèges")

# À vous : les 10 collèges qui dépassent le plus la prédiction
# (nom, académie, ips, part_tb, residu).
colleges |>
  arrange(desc(residu)) |>
  select(nom_de_l_etablissement, academie, ips, part_tb, residu) |>
  head(10)

# À vous : les 5 collèges les plus en dessous de la prédiction.
# Leurs chiffres vous paraissent-ils plausibles ?
colleges |>
  arrange(residu) |>
  select(nom_de_l_etablissement, academie, ips, part_tb, residu) |>
  head(5)


# --- Exercice 6 : comparer les deux modèles --------------------------
# À vous : afficher côte à côte les R² des deux modèles.
# Pourquoi l'IPS explique-t-il moins bien le taux de réussite ?
# Indice : repensez à l'histogramme du taux de réussite (module 4).
c(mentions_tb = summary(modele)$r.squared,
  reussite = summary(modele_reussite)$r.squared)

# Réponse : R² = 0,38 contre 0,48 : l'IPS explique moins bien le taux de réussite.
# Beaucoup de collèges sont proches de 100 % de réussite : le taux « plafonne »
# et distingue mal les collèges entre eux, contrairement aux mentions TB.


# =====================================================================
# Partie 2 - Analyse en composantes principales (ACP)
# =====================================================================

# --- Exercice 7 : préparer et lancer l'ACP ---------------------------
# Exemple du cours : exécutez-le.
# Variables numériques décrivant chaque collège.
donnees_acp <- colleges |>
  select(ips, ecart_type_de_l_ips, presents,
         taux_reussite, part_ab, part_b, part_tb)

# scale. = TRUE : on centre et on réduit, car les variables
# n'ont pas les mêmes unités (IPS, effectifs, pourcentages).
acp <- prcomp(donnees_acp, scale. = TRUE)

# À vous : relancer l'ACP SANS scale. = TRUE, dans un objet acp_brute,
# puis afficher les coordonnées des variables sur l'axe 1, arrondies.
# Indice : round(acp_brute$rotation[, 1], 2)
# Quelle variable écrase toutes les autres ? Pourquoi ?
acp_brute <- prcomp(donnees_acp)
round(acp_brute$rotation[, 1], 2)

# Réponse : le nombre de présents (des centaines d'élèves) a des valeurs bien plus
# grandes que les autres variables : sans réduction, il forme l'axe 1 à lui seul.


# --- Exercice 8 : combien d'axes retenir ? ---------------------------
# Exemple du cours : exécutez-le.
# Part de variance expliquée par chaque composante.
summary(acp)

# À vous : tracer l'éboulis des valeurs propres avec plot(acp, type = "l").
# Combien d'axes retenir ?
plot(acp, type = "l", main = "Éboulis des valeurs propres")

# Réponse : la courbe se casse après le 2e axe : on retient les deux premiers.


# --- Exercice 9 : interpréter les axes -------------------------------
# Exemple du cours : exécutez-le.
# Coordonnées des variables sur les deux premiers axes.
round(acp$rotation[, 1:2], 2)

# Biplot : variables (flèches) et collèges (points) sur le plan 1-2.
biplot(acp, xlabs = rep(".", nrow(donnees_acp)), cex = 0.7)

# À vous (en commentaire, en binôme) :
# - Quelle part de l'information les deux premiers axes résument-ils ?
# - Quelles variables contribuent à l'axe 1 ? Comment le nommer ?
# - Que semble opposer l'axe 2 ?
# Réponse :
# - Les deux premiers axes résument 59 % de l'information (39 % + 19 %).
# - Axe 1 : IPS, taux de réussite, mentions TB et B y contribuent ensemble.
#   C'est un axe « profil social favorisé et bons résultats » : il confirme
#   le lien mis en évidence par la régression.
# - Axe 2 : il oppose les mentions AB et B et le taux de réussite (en haut)
#   au nombre de présents, aux mentions TB et à l'écart-type de l'IPS (en bas).
#   Il distingue des collèges où l'on réussit avec des mentions moyennes
#   de collèges plus grands et socialement plus mélangés.
#   Cet axe est plus délicat à lire : il faut rester prudent.


# =====================================================================
# Pour aller plus loin
# =====================================================================

# Ajouter le secteur dans la régression : à IPS égal,
# le secteur change-t-il la part de mentions TB ?
# Indice : lm(part_tb ~ ips + secteur, data = colleges)
modele_secteur <- lm(part_tb ~ ips + secteur, data = colleges)
summary(modele_secteur)

# Réponse : le coefficient secteurpublic vaut -0,4 avec une p-value de 0,12 :
# il n'est pas significatif. À IPS égal, public et privé obtiennent
# en moyenne la même part de mentions TB. L'écart observé entre secteurs
# (31 % contre 24 % au module 3) s'explique surtout par le profil social.

# Diagnostic : résidus en fonction des valeurs prédites.
# Indice : plot(modele, which = 1)
plot(modele, which = 1)

# Projeter les collèges sur le plan 1-2 de l'ACP avec ggplot2,
# colorés par secteur.
# Indice : scores <- as.data.frame(acp$x), puis ajouter scores$secteur
scores <- as.data.frame(acp$x)
scores$secteur <- colleges$secteur
ggplot(scores, aes(x = PC1, y = PC2, colour = secteur)) +
  geom_point(alpha = 0.3) +
  labs(title = "Collèges sur le premier plan de l'ACP",
       x = "Composante 1", y = "Composante 2", colour = "Secteur")
