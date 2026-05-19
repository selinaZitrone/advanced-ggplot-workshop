library(ggplot2)
library(dplyr)
library(gapminder)
library(colorblindr)
library(paletteer)

theme_set(theme_minimal(base_size = 12))

gap_continent <- gapminder |>
  group_by(year, continent) |>
  summarise(mean_lifeExp = mean(lifeExp), .groups = "drop")

# default colors -----------------------------------------------------------

p_default <- ggplot(
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

p_default

# Okabe-Ito with a named vector --------------------------------------------

# A named vector means colors stick to groups, even if a group
# disappears after filtering.
okabe_ito_continent <- c(
  Africa = "#E69F00",
  Americas = "#56B4E9",
  Asia = "#009E73",
  Europe = "#0072B2",
  Oceania = "#D55E00"
)

p_okabe <- p_default +
  scale_color_manual(values = okabe_ito_continent)

p_okabe

# check with cvd_grid() ----------------------------------------------------

# Simulates the plot under deuteranopia, protanopia, tritanopia,
# and grayscale.
cvd_grid(p_okabe)

# browse other palettes via paletteer --------------------------------------

# paletteer wraps ~2500 palettes from dozens of packages.
# Run `paletteer::palettes_d_names` (or `palettes_c_names`) to browse.

p_default +
  paletteer::scale_color_paletteer_d("ggthemes::colorblind")

# double-coding with color + linetype --------------------------------------

# When you have <= 4 categories, encoding the same group with two
# channels (color + shape, color + linetype) helps anyone who
# struggles with color and also helps in B/W print.
gap_three <- gap_continent |>
  filter(continent %in% c("Africa", "Asia", "Europe"))

ggplot(
  gap_three,
  aes(
    x = year, y = mean_lifeExp,
    color = continent, linetype = continent
  )
) +
  geom_line(linewidth = 1) +
  scale_color_manual(values = okabe_ito_continent) +
  labs(
    title = "Same group encoded twice: color + linetype",
    x = NULL,
    y = "Life expectancy (years)",
    color = NULL, linetype = NULL
  )
