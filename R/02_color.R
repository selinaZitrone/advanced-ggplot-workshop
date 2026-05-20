# Module 2: Color with intent
# If you fall behind, open solutions/02_color_final.R to catch up

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)
library(colorBlindness)
library(scico)
# cols4all: install with pak::pak("mtennekes/cols4all") then library(cols4all)

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

p_bubble # how does this look for colorblind readers?

cvdPlot(p_bubble) # simulate common types of color vision deficiency

# Okabe-Ito from base R ------------------------------------------------------

# Built into base R since version 4.0
palette.colors(palette = "Okabe-Ito")

# Assign a fixed color to each continent
continent_colors <- c(
  # build this together
)

p_bubble +
  scale_colour_manual(values = continent_colors)

# Why named vectors matter ---------------------------------------------------

# What happens if we filter to just two continents?
gap_2007 |>
  filter(continent %in% c("Africa", "Europe")) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(alpha = 0.7) +
  scale_x_log10(labels = label_dollar(accuracy = 1)) +
  scale_colour_manual(values = continent_colors) # colors stay consistent

# Check colorblindness -------------------------------------------------------

p_okabe <- p_bubble + scale_colour_manual(values = continent_colors)
cvdPlot(p_okabe)

# Other safe palette sources -------------------------------------------------

# viridis: built into ggplot2, good for ordered categories or greyscale
p_bubble + scale_colour_viridis_d()

# scico: perceptually uniform, good for publications
p_bubble + scale_colour_scico_d(palette = "batlow")

# cols4all: palette browser --------------------------------------------------

# library(cols4all)
# c4a_gui() # interactive browser with CVD simulation built in
