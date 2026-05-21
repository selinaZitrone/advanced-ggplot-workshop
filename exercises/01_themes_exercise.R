# Module 1 Exercise: Custom themes (about 5 min)

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)

theme_set(theme_grey()) # start from the default theme

# A plot to style: life expectancy over time, by continent
gap_continent <- gapminder |>
  summarise(mean_lifeExp = mean(lifeExp), .by = c(continent, year))

p_lines <- ggplot(
  gap_continent,
  aes(x = year, y = mean_lifeExp, color = continent)
) +
  geom_line(linewidth = 1) +
  scale_y_continuous(labels = label_number(suffix = " yrs")) +
  labs(
    title = "Life expectancy over time by continent",
    x = NULL,
    y = "Mean life expectancy",
    color = "Continent"
  )

p_lines

# Your task ------------------------------------------------------------------
# 1. Create a file: exercises/theme_custom.R
# 2. In it, write theme_custom() based on a built-in theme of your choice
# 3. Source it here:   source(here::here("exercises", "theme_custom.R"))
# 4. Apply theme_custom() to p_lines
#
# Finished early? Try different base_size values, or add more customizations.
# Stuck? See demo_solutions/01_themes_final.R
