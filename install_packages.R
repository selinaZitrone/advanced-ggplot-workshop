# install_packages.R
# Run this once before the workshop.

cran_packages <- c(
  # Core
  "ggplot2", "dplyr", "tidyr", "gapminder", "scales", "here",
  # Module 2 (color)
  "paletteer", "colorspace",
  # Module 3 (directing attention)
  "ggtext", "ggrepel", "gghighlight",
  # Module 4 (patchwork)
  "patchwork",
  # Module 5 (export)
  "ragg", "systemfonts", "ggview",
  # Honorable mentions
  "ggdist", "ggsignif", "ggpubr", "ggridges", "ggh4x", "ggExtra", "cowplot",
  # For Module 1 stretch goals (Google fonts)
  "sysfonts", "showtext",
  # For installing colorblindr from GitHub
  "remotes"
)

# Install missing CRAN packages
installed <- rownames(installed.packages())
missing <- cran_packages[!cran_packages %in% installed]

if (length(missing) > 0) {
  message("Installing ", length(missing), " CRAN packages...")
  install.packages(missing)
}

# colorblindr is GitHub-only
if (!"colorblindr" %in% rownames(installed.packages())) {
  message("Installing colorblindr from GitHub...")
  remotes::install_github("clauswilke/colorblindr")
}

# Verify
required <- c(cran_packages, "colorblindr")
still_missing <- required[!required %in% rownames(installed.packages())]

if (length(still_missing) == 0) {
  message("\nAll packages installed. You're ready for the workshop!")
} else {
  warning(
    "\nSome packages failed to install: ",
    paste(still_missing, collapse = ", "),
    "\nTry installing them manually with install.packages()."
  )
}
