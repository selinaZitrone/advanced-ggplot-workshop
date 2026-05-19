# Module 2: Color with intent
# If you fall behind, open 02_color_final.R to catch up

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)
library(colorBlindness)
library(scico)
# cols4all: install with pak::pak("mtennekes/cols4all") then library(cols4all)

source(here::here("R", "01_themes_final.R"))  # loads theme_workshop() and p_bubble
theme_set(theme_workshop())

# ── The problem with default colors ───────────────────────────────────────────

p_bubble  # what does this look like for colorblind readers?

cvdPlot(p_bubble)  # wow moment: deuteranopia, protanopia, desaturated

# ── Okabe-Ito from base R ─────────────────────────────────────────────────────

# Available since R 4.0 — no package needed
palette.colors(palette = "Okabe-Ito")

# Build a named vector: assign specific colors to specific continents
continent_colors <- c(
  # build this together
)

# Apply to the plot
p_bubble +
  scale_colour_manual(values = continent_colors)

# ── Why named vectors matter ──────────────────────────────────────────────────

# What happens if we filter to just two continents?
gap_2007 |>
  filter(continent %in% c("Africa", "Europe")) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(alpha = 0.7) +
  scale_x_log10(labels = label_dollar(accuracy = 1)) +
  scale_colour_manual(values = continent_colors)  # colors stay consistent!

# ── Check colorblindness ──────────────────────────────────────────────────────

p_okabe <- p_bubble + scale_colour_manual(values = continent_colors)
cvdPlot(p_okabe)

# ── Other safe palette sources ────────────────────────────────────────────────

# viridis — built into ggplot2, great for ordered categories or greyscale printing
p_bubble + scale_colour_viridis_d()

# scico — perceptually uniform, good for publications
p_bubble + scale_colour_scico_d(palette = "batlow")
# ── cols4all: palette browser ─────────────────────────────────────────────────

# library(cols4all)
# c4a_gui()  # interactive browser with CVD simulation built in
