# =====================================================================
# Vérification du poste
# Formation « Langage R - initiation »
# =====================================================================
# À lancer dans RStudio, une fois le projet de la formation ouvert :
# ouvrir ce script, puis Ctrl + Maj + Entrée pour tout exécuter.
# Le script affiche « POSTE PRÊT » ou la liste de ce qui manque.
# ---------------------------------------------------------------------

problemes <- c()


# --- 1. Version de R (4.1 au minimum) --------------------------------
cat("Version de R :", R.version.string, "\n")

if (getRversion() < "4.1.0") {
  problemes <- c(problemes,
                 "R est trop ancien : installer la version actuelle de R.")
}


# --- 2. Les quatre packages de la formation --------------------------
packages <- c("dplyr", "ggplot2", "readr", "haven")

for (p in packages) {
  if (requireNamespace(p, quietly = TRUE)) {
    cat("Package", p, ": OK, version", as.character(packageVersion(p)), "\n")
  } else {
    cat("Package", p, ": MANQUANT\n")
    problemes <- c(problemes,
                   paste0("Le package ", p, " manque : lancer ",
                          "install.packages(\"", p, "\") dans la console."))
  }
}


# --- 3. Les fichiers de données --------------------------------------
cat("Dossier de travail :", getwd(), "\n")

fichiers <- c("data/ips_colleges_2020_2021.csv",
              "data/dnb_etablissements_2017_2021.csv")

for (f in fichiers) {
  if (file.exists(f)) {
    cat("Fichier", f, ": OK\n")
  } else {
    cat("Fichier", f, ": INTROUVABLE\n")
    problemes <- c(problemes,
                   paste0("Fichier ", f, " introuvable : vérifier que le ",
                          "projet RStudio est ouvert sur le dossier de la ",
                          "formation (celui qui contient data/ et scripts/)."))
  }
}


# --- 4. Bilan ---------------------------------------------------------
cat("\n")
if (length(problemes) == 0) {
  cat("==> POSTE PRÊT\n")
} else {
  cat("==> CE QUI MANQUE :\n")
  for (pb in problemes) {
    cat(" -", pb, "\n")
  }
}
