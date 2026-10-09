# Installer son poste

Formation « Langage R – initiation » · Windows 11 · environ 25 minutes

Chacun installe son propre poste, en suivant les six étapes dans l'ordre. Votre binôme est là pour vous aider : en cas de doute, comparez vos écrans.

Gardez cette page ouverte pendant toute l'installation.

---

## Étape 1 — Installer R

1. Ouvrir <https://cran.r-project.org/bin/windows/base/>
2. Cliquer sur **Download R-4.x.x for Windows** (le numéro de version peut changer).
3. Lancer le fichier téléchargé. Windows demande l'autorisation : répondre **Oui**.
4. Choisir la langue **Français**, puis cliquer sur **Suivant** à chaque écran sans rien changer, jusqu'à **Terminer**.

---

## Étape 2 — Installer RStudio

R est le moteur, RStudio est l'environnement de travail. Il faut les deux, **R d'abord**.

1. Ouvrir <https://posit.co/download/rstudio-desktop/>
2. Cliquer sur **Download RStudio Desktop for Windows**.
3. Lancer le fichier téléchargé, répondre **Oui**, puis **Suivant** à chaque écran, jusqu'à **Terminer**.

RStudio est en anglais : les menus sont donnés ci-dessous en anglais.

---

## Étape 3 — Télécharger les fichiers de la formation

1. Revenir sur cette page (le dépôt GitHub de la formation, dont l'adresse est au tableau).
2. En haut de la page, cliquer sur le bouton vert **Code**, puis sur **Download ZIP**.
3. Dans le dossier **Téléchargements**, faire un clic droit sur le fichier `.zip` > **Extraire tout** > **Extraire**.

**Attention :** il faut travailler dans le dossier **extrait**, jamais dans le `.zip` lui-même. Le dossier qui compte est celui qui contient directement `data`, `scripts` et `installation`. Il se trouve parfois un niveau plus bas, dans un dossier du même nom.

---

## Étape 4 — Ouvrir le projet dans RStudio

1. Lancer **RStudio** depuis le menu Démarrer.
2. Menu **File > New Project… > Existing Directory**.
3. **Browse…** : choisir le dossier qui contient `data`, `scripts` et `installation`.
4. **Create Project**. RStudio redémarre dans ce dossier.

À partir de maintenant, on rouvre la formation en double-cliquant sur le fichier `.Rproj` de ce dossier.

---

## Étape 5 — Installer les quatre packages

Dans la **console** de RStudio (panneau en bas à gauche), taper puis valider avec **Entrée** :

```r
install.packages(c("dplyr", "ggplot2", "readr", "haven"))
```

- Si une fenêtre demande *Would you like to use a personal library instead?*, répondre **Yes**, puis encore **Yes** à la question suivante.
- Le téléchargement dure quelques minutes. C'est fini quand le symbole `>` réapparaît dans la console.
- Les lignes en rouge ne sont pas forcément des erreurs : c'est l'étape 6 qui tranche.

---

## Étape 6 — Vérifier le poste

1. Dans le panneau **Files** (en bas à droite), ouvrir le dossier `installation`, puis le fichier `verifier_poste.R`.
2. Tout exécuter avec **Ctrl + Maj + Entrée**.
3. Lire la fin de la console :
   - **`==> POSTE PRÊT`** : c'est terminé ;
   - **`==> CE QUI MANQUE`** : suivre les consignes affichées, puis relancer le script.

---

## En cas de problème

| Symptôme | Solution |
|---|---|
| RStudio affiche qu'il ne trouve pas R | R n'est pas installé : refaire l'étape 1, puis relancer RStudio |
| `verifier_poste.R` ne trouve pas les fichiers de données | Le projet n'est pas ouvert sur le bon dossier : refaire l'étape 4 |
| Un package est signalé manquant | Relancer la ligne de l'étape 5 |
| `installation of package … had non-zero exit status` | Fermer RStudio, le rouvrir, relancer l'étape 5 |
| Autre chose | Appeler le formateur |
