# A theme function lets you reuse your style across every plot and script.
# rel() sizes text relative to base_size and scales proportionally.
#
# Keeping the theme in its own file means every script can share one definition.
# To load it in any script, use source():
#   source(here::here("demo_solutions", "theme.R")) or source("demo_solutions/theme.R")

theme_workshop <- function(base_size = 16, ink = "grey20", paper = "white") {
  theme_light(base_size = base_size, ink = ink, paper = paper) %+replace%
    theme(
      legend.text = element_text(size = rel(0.85)),
      panel.grid.minor = element_blank()
    )
}
