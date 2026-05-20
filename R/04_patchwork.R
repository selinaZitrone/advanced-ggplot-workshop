# Module 4: Multipanel layouts with patchwork
# If you fall behind, open solutions/04_patchwork_final.R to catch up

library(ggplot2)
library(dplyr)
library(gapminder)
library(patchwork)
library(scales)
library(scico)

source(here::here("R", "theme.R")) # theme_workshop() (you create theme.R in Module 1)

# Data -----------------------------------------------------------------------

gap_2007 <- gapminder |>
  filter(year == 2007)

gap_continent <- gapminder |>
  group_by(year, continent) |>
  summarise(
    mean_lifeExp = mean(lifeExp),
    mean_gdpPercap = mean(gdpPercap),
    .groups = "drop"
  )

# Three named plots ----------------------------------------------------------

# When you plan to compose plots, assign them to variables first.

p_bubble <- ggplot(
  gap_2007,
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)
) +
  geom_point(alpha = 0.7) +
  scale_x_log10(labels = label_dollar(accuracy = 1)) +
  scale_size(labels = label_number(scale_cut = cut_short_scale())) +
  scale_color_scico_d(palette = "batlow") +
  theme_workshop() +
  labs(
    title = "2007 snapshot",
    x = "GDP per capita (USD, log scale)",
    y = "Life expectancy (years)",
    color = "Continent",
    size = "Population"
  )

p_life <- ggplot(
  gap_continent,
  aes(x = year, y = mean_lifeExp, color = continent)
) +
  geom_line(linewidth = 1) +
  scale_color_scico_d(palette = "batlow") +
  theme_workshop() +
  labs(
    title = "Life expectancy over time",
    x = NULL,
    y = "Life expectancy (years)",
    color = "Continent"
  )

p_gdp <- ggplot(
  gap_continent,
  aes(x = year, y = mean_gdpPercap, color = continent)
) +
  geom_line(linewidth = 1) +
  scale_y_continuous(labels = label_dollar(accuracy = 1)) +
  scale_color_scico_d(palette = "batlow") +
  theme_workshop() +
  labs(
    title = "GDP per capita over time",
    x = NULL,
    y = "GDP per capita (USD)",
    color = "Continent"
  )

# The three plots
p_bubble
p_life
p_gdp

# Combining two plots --------------------------------------------------------

# + places plots side by side; / stacks them.

# Adding a third plot --------------------------------------------------------

# Use () to group panels, like arithmetic.
# Try both arrangements and notice which tells the story better:
#   p_bubble / (p_gdp + p_life)   bubble on top, two lines below
#   (p_bubble + p_life) / p_gdp   different emphasis

# Collecting shared legends --------------------------------------------------

# All three plots share a continent color legend, no need to repeat it.
# plot_layout(guides = "collect") merges identical legends into one.

# & vs + ---------------------------------------------------------------------

# Each plot carries its own theme_workshop() and scale_color_scico_d().
# That is repetitive; patchwork can factor shared layers to the composition level.
# & applies an expression to every panel; + only modifies the last one.

# Step 1: remove theme_workshop() and scale_color_scico_d() from individual plots
# Step 2: apply them once with &

# Panel tags -----------------------------------------------------------------

# plot_annotation(tag_levels = "A") labels panels automatically.

# Inset (if time allows) -----------------------------------------------------

# inset_element() places a plot on top of another.
# left/bottom/right/top are fractional coordinates (0-1) within the parent panel.
