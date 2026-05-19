library(ggplot2)
library(dplyr)
library(gapminder)
library(patchwork)
library(scales)

theme_set(theme_minimal(base_size = 12))

gap_2007 <- gapminder |> filter(year == 2007)
gap_continent <- gapminder |>
  group_by(year, continent) |>
  summarise(mean_lifeExp = mean(lifeExp), .groups = "drop")

p_scatter <- ggplot(
  gap_2007,
  aes(x = gdpPercap, y = lifeExp, color = continent)
) +
  geom_point(alpha = 0.7, size = 3) +
  scale_x_log10(labels = label_dollar()) +
  labs(
    title = "2007 snapshot",
    x = "GDP per capita",
    y = "Life expectancy (years)"
  )

p_lines <- ggplot(
  gap_continent,
  aes(x = year, y = mean_lifeExp, color = continent)
) +
  geom_line(linewidth = 1) +
  labs(
    title = "Over time",
    x = NULL,
    y = "Life expectancy (years)"
  )

p_box <- ggplot(
  gap_2007,
  aes(x = continent, y = lifeExp, color = continent)
) +
  geom_boxplot(fill = "white") +
  labs(
    title = "By continent (2007)",
    x = NULL,
    y = "Life expectancy (years)"
  )

# 1. Combine the three plots into a single A/B/C figure with:
#    - automatic panel tags (A, B, C)
#    - one collected legend (at the bottom)
#    - a shared y-axis title where it makes sense

# stretch ----------------------------------------------------------------------

# - Compare (p_scatter + p_lines) / p_box  vs  p_scatter / (p_lines + p_box).
#   Which layout tells the story better?

# - Set the widths so p_scatter is twice as wide as p_lines.

# - Add an inset_element() with a small overview plot in the corner
#   of one of the panels.
