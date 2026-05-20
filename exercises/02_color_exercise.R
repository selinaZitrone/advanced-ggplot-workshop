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
# Pick a colorblind-safe palette from ONE of these sources:
#   - Okabe-Ito from base R:  palette.colors(palette = "Okabe-Ito")
#   - viridis:                scale_colour_viridis_d()
#   - scico:                  scale_colour_scico_d(palette = "...")
#                             (run scico::scico_palette_names() to browse)
#   - cols4all (if installed): c4a_gui() to explore interactively
#
# Apply your chosen palette to p_lines using scale_colour_manual() or the
# relevant scale function.



# Task 2 ---------------------------------------------------------------------
# Build a named vector so that each continent gets a fixed color.
# Then filter gap_continent to only Africa and Europe, recreate the plot,
# and confirm the colors stay consistent (Africa doesn't change color).



# Task 3 ---------------------------------------------------------------------
# Run cvdPlot() on your plot. Does your palette hold up?
# If not, try a different one until it does.



# Task 4 ---------------------------------------------------------------------
# Add a second encoding: map continent to linetype as well as color.
# Hint: add aes(linetype = continent) and scale_linetype_manual().
# This keeps the plot readable even in black and white.
