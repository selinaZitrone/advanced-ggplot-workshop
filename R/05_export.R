# Module 5: Exporting figures in the right format

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)
library(scico)
library(ragg)
library(ggview)
library(here)

source(here("solutions", "theme.R"))

# Create a plot director (if it doesn't already exist)
dir.create(here("plots"), showWarnings = FALSE)

# Create the plot ---------------------------------------------------------

gap_2007 <- gapminder |> filter(year == 2007)

p_bubble <- ggplot(
  gap_2007,
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)
) +
  geom_point(alpha = 0.7) +
  scale_x_log10(labels = label_dollar(accuracy = 1)) +
  scale_size(labels = label_number(scale_cut = cut_short_scale())) +
  scale_color_scico_d(palette = "batlow") +
  labs(
    x = "GDP per capita (USD, log scale)",
    y = "Life expectancy (years)",
    color = "Continent",
    size = "Population"
  ) +
  theme_workshop() # base_size = 16 at default

p_bubble

# The problem with default ggsave() ------------------------------------------

# Step 1: pick a canvas size

# Step 2: use ggview to preview and tweak the plot

# Step 3: export with ragg and explicit dimensions

# pdf with embedded fonts
