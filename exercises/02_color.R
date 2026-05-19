library(ggplot2)
library(dplyr)
library(gapminder)
library(colorblindr)

theme_set(theme_minimal(base_size = 12))

gap_continent <- gapminder |>
  group_by(year, continent) |>
  summarise(mean_lifeExp = mean(lifeExp), .groups = "drop")

p <- ggplot(
  gap_continent,
  aes(x = year, y = mean_lifeExp, color = continent)
) +
  geom_line(linewidth = 1) +
  labs(
    title = "Life expectancy over time by continent",
    x = NULL,
    y = "Life expectancy (years)",
    color = NULL
  )

p

# 1. Build a named Okabe-Ito vector for the 5 continents (Africa,
#    Americas, Asia, Europe, Oceania) and apply it with
#    scale_color_manual(). See R/02_color.R for the hex codes.

# 2. Pass the colored plot to cvd_grid() and check all four
#    simulations are still distinguishable.

# stretch ----------------------------------------------------------------------

# - Try 2 or 3 other palettes from paletteer (palettes_d_names) and
#   check each with cvd_grid(). Which one survives best?

# - Make a continuous version: color points by gdpPercap with
#   scale_color_viridis_c(). Try option = "magma" or "plasma".
