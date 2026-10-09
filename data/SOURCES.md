# Sources des données

Téléchargement : **6 octobre 2026, 16 h 30** (export CSV complet de l'API Opendatasoft de data.education.gouv.fr).
URL d'export : `https://data.education.gouv.fr/api/explore/v2.1/catalog/datasets/<identifiant>/exports/csv?delimiter=%3B&use_labels=false`

## Fichiers bruts (`data/brut/`, non distribués en TP)

| Fichier | Jeu de données | URL source | Lignes | Années couvertes |
|---|---|---|---|---|
| `fr-en-ips_colleges.csv` | Indices de position sociale des collèges (2016-2021) | https://data.education.gouv.fr/explore/dataset/fr-en-ips_colleges/ | 41 701 | rentrées 2016-2017 à 2021-2022 |
| `fr-en-dnb-par-etablissement.csv` | Diplôme national du brevet par établissement | https://data.education.gouv.fr/explore/dataset/fr-en-dnb-par-etablissement/ | 139 580 | sessions 2006 à 2021 |

Format brut : séparateur `;`, UTF-8 **avec BOM**, fins de ligne Windows, point décimal pour l'IPS.

## Concordance des années

Le jeu « DNB par établissement » s'arrête à la session 2021. On retient donc **la même année scolaire 2020-2021** des deux côtés : IPS de la rentrée 2020-2021 et DNB de la session 2021. Après jointure sur l'UAI, 6 935 collèges sont présents dans les deux fichiers ; 18 collèges de l'IPS n'ont pas de résultat au brevet.

## Extraits utilisés en TP (`data/`)

Ils sont produits par `data/preparer_extraits.R` et par le corrigé du module 3. Format : séparateur `;`, **virgule décimale**, UTF-8 **sans BOM**, donc lisibles directement par `read.csv2()` et `readr::read_csv2()`.

| Fichier | Contenu | Lignes | Taille | Produit par |
|---|---|---|---|---|
| `ips_colleges_2020_2021.csv` | IPS, rentrée 2020-2021 (colonne `nom_de_l_etablissment` renommée en `nom_de_l_etablissement`) | 6 953 | 0,7 Mo | `preparer_extraits.R` |
| `dnb_etablissements_2017_2021.csv` | DNB, sessions 2017 à 2021, tous types d'établissements | 44 018 | 6 Mo | `preparer_extraits.R` |
| `colleges_ips_dnb_2021.csv` | Table jointe IPS × DNB 2021, avec taux de réussite et parts de mentions calculés | 6 935 | 1,3 Mo | `scripts/03_scripts_corrige.R` |

**Extrait signalé :** le fichier DNB complet (19 Mo, 16 sessions) est trop lourd pour un TP ; l'extrait ne garde que les sessions 2017 à 2021, ce qui suffit pour le graphique d'évolution du jour 2.

**À savoir pour l'animation :** la session 2020 du DNB s'est déroulée sans épreuves écrites (contrôle continu seul), ce qui explique le pic de réussite cette année-là.
