library(ggplot2)
library(dplyr)
library(gapminder)
library(gghighlight)
library(ggrepel)
library(ggtext)
library(scales)

theme_set(theme_minimal(base_size = 12))

# top 5 countries by GDP per capita growth (1952 -> 2007)
top_growth <- gapminder |>
  group_by(country) |>
  summarise(growth = last(gdpPercap) / first(gdpPercap), .groups = "drop") |>
  slice_max(growth, n = 5) |>
  pull(country) |>
  as.character()

top_growth

# starter: all countries, no highlight, log y because GDP varies hugely
p <- ggplot(gapminder, aes(x = year, y = gdpPercap, color = country)) +
  geom_line(linewidth = 0.6) +
  scale_y_log10(labels = label_dollar()) +
  labs(
    title = "GDP per capita worldwide, 1952-2007",
    x = NULL,
    y = "GDP per capita (log)"
  )

p

# 1. Use gghighlight to keep only the top_growth countries colored;
#    dim everything else.

# 2. Add ggrepel labels for the top 5 at the line endpoints
#    (year == 2007).

# 3. Drop the legend (the direct labels make it redundant).

# stretch ----------------------------------------------------------------------

# - Color all 5 with an Okabe-Ito named vector and apply via
#   scale_color_manual().
#   (Hint: print `top_growth` to see which 5 country names you need.)

# - Add a ggtext title that lists the 5 countries in their colors.

# - annotate() a note like "Top 5 = largest GDP per capita increase
#   from 1952 to 2007".
