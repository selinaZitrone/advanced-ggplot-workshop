# Module 2: Color with intent (completed script)
# Open this if you fell behind during the demo.

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)
library(colorBlindness)
library(scico)

source(here::here("demo_solutions", "theme.R")) # loads theme_workshop()
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

# The default ggplot2 palette is not colorblind-safe.
# cvdPlot() simulates how the plot looks with color vision deficiency.
cvdPlot(p_bubble + theme(text = element_text(size = 8)))

# Okabe-Ito from base R ------------------------------------------------------

# Okabe-Ito: a colorblind-safe qualitative palette, built into base R (>= 4.0).
palette.colors(palette = "Okabe-Ito")

# Build a named vector: assign a fixed color to each continent.
# Include black (#1) for extra contrast; skip yellow (#5), low contrast on white.
okabe <- palette.colors(palette = "Okabe-Ito")

continent_colors <- c(
  Oceania = okabe[1],
  Africa = okabe[2],
  Americas = okabe[3],
  Asia = okabe[4],
  Europe = okabe[6]
)

p_okabe <- p_bubble + scale_colour_manual(values = continent_colors)
p_okabe

# Check colorblindness -------------------------------------------------------

# Okabe-Ito stays distinguishable under all common CVD types.
cvdPlot(p_okabe + theme(text = element_text(size = 8)))

# Other safe palette sources -------------------------------------------------

# viridis: built into ggplot2, perceptually uniform, greyscale-safe.
# Good for ordered categories, less so for unordered ones like continents.
p_bubble + scale_colour_viridis_d()

# scico: perceptually uniform palettes for scientific use, all CVD-safe.
p_bubble + scale_colour_scico_d(palette = "batlow")
p_bubble + scale_colour_scico_d(palette = "roma")
