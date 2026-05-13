library(ggplot2)
library(dplyr)
library(gapminder)
library(here)

gap_2007 <- gapminder |>
  filter(year == 2007)

p <- ggplot(
  gap_2007,
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)
) +
  geom_point(alpha = 0.7) +
  scale_x_log10() +
  labs(
    title = "Life expectancy vs GDP per capita (2007)",
    x = "GDP per capita (USD)",
    y = "Life expectancy (years)"
  )

p

# 1. Create R/theme_lab.R with a function theme_lab() that has:
#    - theme_minimal() as base
#    - no minor gridlines
#    - axis title size 12, plot title size 14
#    - sans-serif font
#    (use theme_workshop() in R/01_themes.R as a starting point)

# 2. Source and apply:
# source(here("R", "theme_lab.R"))
# theme_set(theme_lab())
# print(p)

# stretch ----

# - custom plot background color
# - Google font via sysfonts + showtext
# - make a second plot and confirm the theme applies automatically
