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

source(here::here("solutions", "theme.R"))
theme_set(theme_workshop())

gap_continent <- gapminder |>
  summarise(mean_lifeExp = mean(lifeExp), .by = c(continent, year))

# Starting plot, no color palette applied yet
p_lines <- ggplot(gap_continent, aes(x = year, y = mean_lifeExp, color = continent)) +
  geom_line(linewidth = 1) +
  scale_y_continuous(labels = label_number(suffix = " yrs")) +
  labs(
    x     = NULL,
    y     = "Mean life expectancy",
    color = "Continent"
  )

p_lines

# Task 1 ---------------------------------------------------------------------
# Apply a colorblind-safe palette to p_lines. Pick ONE:
#   - viridis: scale_colour_viridis_d()           (browse: ?scale_colour_viridis)
#   - scico:   scale_colour_scico_d(palette = ".") (browse: scico_palette_names(categorical = TRUE))



# Task 2 ---------------------------------------------------------------------
# Check your palette with cvdPlot(). Does it hold up? If not, try another.



# Stretch --------------------------------------------------------------------
# Build a named vector so each continent keeps a fixed color, then filter
# gap_continent to Africa and Europe and confirm the colors don't shift.
