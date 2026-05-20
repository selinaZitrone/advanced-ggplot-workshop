# Module 4: Multipanel layouts with patchwork - FINAL SCRIPT
# This is the fully worked version. Open this if you fell behind during the demo.

library(ggplot2)
library(dplyr)
library(gapminder)
library(patchwork)
library(scales)
library(scico)

source(here::here("solutions", "theme.R")) # loads theme_workshop()

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
    y = "GDP per capita (USD)",
    color = "Continent"
  )

# Combining two plots --------------------------------------------------------

p_bubble + p_life # side by side
p_life / p_gdp # stacked

# Adding a third plot --------------------------------------------------------

# () groups panels like arithmetic; experiment with the arrangement.
p_bubble / (p_gdp + p_life) # bubble on top, two lines below
(p_bubble + p_life) / p_gdp # lines share a row, GDP anchors below

# Collecting shared legends --------------------------------------------------

# All three plots share the continent color legend; merge into one.
p_life /
  p_gdp +
  plot_layout(guides = "collect", axes = "collect", axis_titles = "collect")

# Add plot annotation --------------------------------------------------------
p_life /
  p_gdp +
  plot_layout(guides = "collect", axes = "collect", axis_titles = "collect") +
  plot_annotation(tag_levels = "A", tag_suffix = ")") # adds tags "A", "B", etc. to each panel

# Add individual plot level layers -------------------------------------------

p_life_bare <- ggplot(
  gap_continent,
  aes(x = year, y = mean_lifeExp, color = continent)
) +
  labs(
    title = "Life expectancy over time",
    y = "Life expectancy (years)",
    x = "Year",
    color = "Continent"
  )

p_gdp_bare <- ggplot(
  gap_continent,
  aes(x = year, y = mean_gdpPercap, color = continent)
) +
  scale_y_continuous(labels = label_dollar(accuracy = 1)) +
  labs(
    title = "GDP per capita over time",
    x = "Year",
    y = "GDP per capita (USD)",
    color = "Continent"
  )

# & applies to every panel in the composition
p_life_bare /
  p_gdp_bare +
  plot_layout(guides = "collect", axes = "collect", axis_titles = "collect") +
  plot_annotation(tag_levels = "A", tag_suffix = ")") &
  geom_line(linewidth = 1) &
  scale_color_scico_d(palette = "batlow") &
  theme_workshop()


# Inset (if time allows) -----------------------------------------------------

# Place p_life as a small inset in the bottom-right corner of p_bubble.
# Coordinates are fractions of the parent panel (0 = left/bottom, 1 = right/top).
p_bubble +
  inset_element(
    p_life + theme(legend.position = "none"),
    left = 0.6,
    bottom = 0.01,
    right = 0.99,
    top = 0.4
  )

# OPTIONAL: map inset --------------------------------------------------------
# This is a common inset you often see

library(rnaturalearth)
library(sf)

gap_europe <- gapminder |> filter(continent == "Africa")

world <- ne_countries(scale = "medium", returnclass = "sf")
europe_names <- unique(gap_europe$country) # gap_europe from Module 3

p_map <- ggplot(world) +
  geom_sf(
    aes(fill = name_long %in% europe_names),
    color = NA
  ) +
  scale_fill_manual(
    values = c("TRUE" = "#0072B2", "FALSE" = "grey85"),
    guide = "none"
  ) +
  theme_void()

p_bubble +
  gghighlight::gghighlight(country %in% gap_europe$country) +
  inset_element(p_map, left = 0.01, bottom = 0.6, right = 0.4, top = 0.999)
