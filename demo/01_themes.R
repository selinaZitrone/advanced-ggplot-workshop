# Module 1: Custom themes
# If you fall behind, open demo_solutions/01_themes_final.R to catch up

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)

# Data -----------------------------------------------------------------------

gap_2007 <- gapminder |>
  filter(year == 2007)

# Base plot ------------------------------------------------------------------

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
    color = "Continent",
    size = "Population"
  )

p_bubble

# Apply a theme ---------------------------------------------------------------
p_bubble +
  theme_light(base_size = 18) +
  theme(
    legend.text = element_text(size = rel(0.85)),
    panel.grid.minor = element_blank()
  )
