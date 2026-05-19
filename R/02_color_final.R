# Module 2: Color with intent — FINAL SCRIPT
# This is the fully worked version. Open this if you fell behind during the demo.

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)
library(colorBlindness)
library(scico)
# cols4all: install with pak::pak("mtennekes/cols4all") then library(cols4all)

source(here::here("R", "01_themes_final.R")) # loads theme_workshop() and p_bubble
theme_set(theme_workshop())

# ── The problem with default colors ───────────────────────────────────────────

# The default ggplot2 palette is not colorblind-safe.
# cvdPlot() simulates how your plot looks for readers with color vision deficiency.
cvdPlot(p_bubble)

# ── Okabe-Ito from base R ─────────────────────────────────────────────────────

# Okabe-Ito is a colorblind-safe qualitative palette designed by Masataka Okabe
# and Kei Ito. Available in base R since R 4.0 — no package needed.
palette.colors(palette = "Okabe-Ito")

# Build a named vector: intentionally assign colors to continents.
# Including black (#1) — adds contrast and distinctiveness.
# Skipping yellow (#5) — low contrast on white backgrounds.
okabe <- palette.colors(palette = "Okabe-Ito")

continent_colors <- c(
  Africa = okabe[[2]], # orange
  Americas = okabe[[3]], # sky blue
  Asia = okabe[[4]], # bluish green
  Europe = okabe[[6]], # blue
  Oceania = okabe[[1]] # black
)

p_okabe <- p_bubble + scale_colour_manual(values = continent_colors)
p_okabe

# ── Why named vectors matter ──────────────────────────────────────────────────

# Without names, colors shift when you filter the data.
# With names, the mapping is locked: Africa is always orange.
gap_2007 |>
  filter(continent %in% c("Africa", "Europe")) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(alpha = 0.7) +
  scale_x_log10(labels = label_dollar(accuracy = 1)) +
  scale_size(labels = label_number(scale_cut = cut_short_scale())) +
  scale_colour_manual(values = continent_colors) + # Africa stays orange, Europe stays blue
  labs(
    x = "GDP per capita (USD, log scale)",
    y = "Life expectancy (years)",
    color = "Continent",
    size = "Population"
  )

# ── Check colorblindness ──────────────────────────────────────────────────────

# Okabe-Ito was designed to be distinguishable under all common CVD types.
cvdPlot(p_okabe)

# Compare: a bad palette
p_bad <- p_bubble + scale_colour_brewer(palette = "Set1")
cvdPlot(p_bad) # red and green collapse under deuteranopia

# ── Other safe palette sources ────────────────────────────────────────────────

# viridis: built into ggplot2, perceptually uniform, greyscale-safe
# Good for ordered categories (not ideal for unordered like continents)
p_bubble + scale_colour_viridis_d()

# scico: perceptually uniform palettes for scientific use
# Many options: sequential, diverging — all CVD-safe
p_bubble + scale_colour_scico_d(palette = "batlow")
p_bubble + scale_colour_scico_d(palette = "roma")

# ── cols4all: palette browser ─────────────────────────────────────────────────

# An interactive palette browser with built-in CVD simulation.
# Install once: pak::pak("mtennekes/cols4all")
# library(cols4all)
# c4a_gui()
