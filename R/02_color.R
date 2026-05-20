# Module 2: Color with intent
# If you fall behind, open solutions/02_color_final.R to catch up

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)
library(colorBlindness)
library(scico)

source(here::here("R", "theme.R")) # theme_workshop() (you create theme.R in Module 1)
theme_set(theme_workshop())

gap_2007 <- gapminder |> filter(year == 2007)

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

# The problem with default colors --------------------------------------------

p_bubble


# Choose better colors --------------------------------------------------------------

# Manual colors: Okabe-Ito ---------------------------------------------------------------
okabe_colors <- palette.colors(palette = "Okabe-Ito")

p_bubble + scale_colour_manual(values = okabe_colors)


# Named color vectors ---------------------------------------------------

# What happens if we filter to just two continents?
gap_2007 |>
  filter(continent %in% c("Africa", "Europe")) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(alpha = 0.7) +
  scale_x_log10(labels = label_dollar(accuracy = 1)) +
  scale_colour_manual(values = okabe_colors)

# Other safe palette sources -------------------------------------------------
