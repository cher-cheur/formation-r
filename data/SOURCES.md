# Sources des données

Données ouvertes de l'Éducation nationale, téléchargées sur [data.education.gouv.fr](https://data.education.gouv.fr) le **6 octobre 2026**.

| Fichier | Contenu | Lignes | Source |
|---|---|---|---|
| `ips_colleges_2020_2021.csv` | Indice de position sociale (IPS) de chaque collège, rentrée 2020-2021 | 6 953 | [Indices de position sociale des collèges](https://data.education.gouv.fr/explore/dataset/fr-en-ips_colleges/) |
| `dnb_etablissements_2017_2021.csv` | Résultats au diplôme national du brevet par établissement, sessions 2017 à 2021 | 44 018 | [Diplôme national du brevet par établissement](https://data.education.gouv.fr/explore/dataset/fr-en-dnb-par-etablissement/) |

Les deux fichiers sont des extraits : on n'a gardé que les années utiles à la formation.

Ils utilisent le point-virgule comme séparateur et la virgule pour les décimales : ils se lisent avec `read.csv2()` ou `readr::read_csv2()`.

Les deux fichiers portent sur la même année scolaire, 2020-2021 (IPS de la rentrée 2020 et brevet de la session 2021). On les relie par le code établissement (UAI).


