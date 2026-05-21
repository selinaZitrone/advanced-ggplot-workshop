# Module 2 Exercise: Color with intent
#
# Apply what you learned about colorblind-safe palettes to a different plot,
# the continent line chart.
#
# Setup: run this block first ------------------------------------------------

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)
library(colorBlindness)
library(scico)

source(here::here("demo_solutions", "theme.R"))
theme_set(theme_workshop())

gap_continent <- gapminder |>
  summarise(mean_lifeExp = mean(lifeExp), .by = c(continent, year))

# Starting plot, no color palette applied yet
p_lines <- ggplot(
  gap_continent,
  aes(x = year, y = mean_lifeExp, color = continent)
) +
  geom_line(linewidth = 1) +
  scale_y_continuous(labels = label_number(suffix = " yrs")) +
  labs(
    x = NULL,
    y = "Mean life expectancy",
    color = "Continent"
  )

p_lines

# Task 1 ---------------------------------------------------------------------
# Apply a colorblind-safe palette to p_lines. Pick ONE:
#   - viridis: scale_colour_viridis_d()           (browse: ?scale_colour_viridis)
#   - scico:   scale_colour_scico_d(palette = ".") (browse: scico_palette_names(categorical = TRUE))

# Task 2 ---------------------------------------------------------------------
# Check your palette with cvdPlot(). Does it hold up? If not, try another.

# If you have time -----------------------------------------------------------
# Build a named vector so each continent keeps a fixed color. You can access colors
# from a palette with scico(n, palette = ".") or viridis::viridis(n), where n is the number of colors you need.
# Then use scale_colour_manual(values = your_named_vector) to apply it to the plot.
