# install_packages.R
# Run this once before the workshop to install all required packages.
# pak handles both CRAN and GitHub installs with the same syntax.

if (!requireNamespace("pak", quietly = TRUE)) install.packages("pak")

# ── Essential: required to follow along ───────────────────────────────────────

pak::pak(c(
  "ggplot2", "dplyr", "gapminder", "scales", "here",  # core
  "scico",                                             # Module 2 (color)
  "gghighlight", "ggrepel", "ggtext",                  # Module 3 (attention)
  "patchwork",                                         # Module 4 (multipanel)
  "ragg", "ggview"                                     # Module 5 (export)
))

# ── Optional: used in demos but not required to follow along ─────────────────

# colorBlindness — CVD simulation in Module 2 (requires Rtools on Windows)
# cols4all        — interactive palette browser in Module 2 (GitHub)
# rnaturalearth + sf — map inset demo at end of Module 4 (GitHub)
# showtext        — custom/Google fonts, briefly mentioned in Module 5

# pak::pak(c(
#   "colorBlindness",
#   "mtennekes/cols4all",
#   "ropensci/rnaturalearth", "sf",
#   "showtext"
# ))
