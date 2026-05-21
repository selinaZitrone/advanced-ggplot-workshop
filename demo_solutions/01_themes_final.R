# Module 1: Custom themes (completed script)
# Open this if you fell behind during the demo.

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)

# Load the custom theme function from theme.R
source(here::here("demo_solutions", "theme.R"))

# Data -----------------------------------------------------------------------

gap_2007 <- gapminder |>
  filter(year == 2007)

# Base plot ------------------------------------------------------------------

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

p_bubble

# Apply the custom workshop theme defined in theme.R ------------------------

p_bubble + theme_workshop(base_size = 18)

# Or set ink and paper colors:
p_bubble + theme_workshop(ink = "grey90", paper = "grey20")

# Apply globally with theme_set() --------------------------------------------

# Set once and every plot that follows picks it up automatically.
# Normally, this goes on top of your script or in theme.R
theme_set(theme_workshop())

p_bubble

# Any new plot inherits the theme without an explicit call
ggplot(gap_2007, aes(x = continent, y = lifeExp)) +
  geom_boxplot() +
  labs(title = "Life expectancy by continent (2007)")
