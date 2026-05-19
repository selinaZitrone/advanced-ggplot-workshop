# Module 1: Custom themes — FINAL SCRIPT
# This is the fully worked version. Open this if you fell behind during the demo.

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
  geom_point(alpha = 0.7) +
  scale_x_log10(labels = label_dollar(accuracy = 1)) +
  scale_size(labels = label_number(scale_cut = cut_short_scale())) +
  labs(
    title = "Life expectancy vs. GDP per capita (2007)",
    x = "GDP per capita (USD, log scale)",
    y = "Life expectancy (years)",
    color = "Continent",
    size = "Population"
  )

p_bubble

# ── Writing a theme function ───────────────────────────────────────────────────

# A theme function lets you reuse your style across every plot and script —
# like a personal style sheet.
#
# rel() sizes text relative to base_size — change one number and everything
# scales proportionally. This is the theme inheritance tree in action.

theme_workshop <- function(base_size = 12, ink = "grey20", paper = "white") {
  theme_light(base_size = base_size, ink = ink, paper = paper) %+replace%
    theme(
      plot.title = element_text(size = rel(1.1), face = "bold"),
      axis.title = element_text(size = rel(0.9), color = "grey30"),
      panel.grid.minor = element_blank(),
      panel.border = element_rect(color = "grey70", fill = NA)
    )
}

p_bubble + theme_workshop()

# ── Apply globally with theme_set() ───────────────────────────────────────────

# Set once — every plot that follows picks it up automatically.
theme_set(theme_workshop())

p_bubble

# Any new plot inherits the theme without an explicit call
ggplot(gap_2007, aes(x = continent, y = lifeExp)) +
  geom_boxplot() +
  labs(title = "Life expectancy by continent (2007)")
