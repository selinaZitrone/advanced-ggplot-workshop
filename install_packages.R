# install_packages.R
# Run this once before the workshop to install all required packages.
# pak handles both CRAN and GitHub installs with the same syntax.

if (!requireNamespace("pak", quietly = TRUE)) install.packages("pak")

# Essential: required to follow along ----------------------------------------

pak::pak(c(
  "ggplot2", "dplyr", "gapminder", "scales", "here",  # core
  "colorBlindness", "scico",                          # Module 2 (color)
  "patchwork",                                         # Module 3 (multipanel)
  "ragg", "ggview"                                     # Module 4 (export)
))

# Optional: used in demos / bonus material, not required to follow along ----

# rnaturalearth + sf     map inset demo at end of Module 3 (GitHub)
# gghighlight, ggrepel, ggtext  bonus module on directing attention
#                               (solutions/bonus/attention.R)

# pak::pak(c(
#   "ropensci/rnaturalearth", "sf",
#   "gghighlight", "ggrepel", "ggtext"
# ))
