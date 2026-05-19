# Module 1: Custom themes
# If you fall behind, open 01_themes_final.R to catch up

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)

# ── Data ──────────────────────────────────────────────────────────────────────

gap_2007 <- gapminder |>
  filter(year == 2007)

# ── Base plot ─────────────────────────────────────────────────────────────────

p_bubble <- ggplot(
  gap_2007,
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)
) +
  geom_point() +
  scale_x_log10(labels = label_dollar(accuracy = 1)) +
  scale_size(labels = label_number(scale_cut = cut_short_scale())) +
  labs(
    x = "GDP per capita (USD, log scale)",
    y = "Life expectancy (years)",
    size = "Population"
  )

p_bubble

# ── Writing a theme function ───────────────────────────────────────────────────

# A theme function lets you reuse your style across every plot and script —
# like a personal style sheet.

theme_workshop <- function(base_size = 16, ink = "grey20", paper = "white") {
  # build this together during the demo
}

p_bubble + theme_workshop()

# ── Apply globally with theme_set() ───────────────────────────────────────────

# (shown after the exercise)
# theme_set(theme_workshop())
