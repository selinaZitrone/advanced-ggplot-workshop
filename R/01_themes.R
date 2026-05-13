library(ggplot2)
library(dplyr)
library(gapminder)

gap_2007 <- gapminder |>
  filter(year == 2007)

# default plot ----

p_default <- ggplot(
  gap_2007,
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)
) +
  geom_point(alpha = 0.7) +
  scale_x_log10() +
  labs(
    title = "Life expectancy vs GDP per capita (2007)",
    x = "GDP per capita (USD)",
    y = "Life expectancy (years)",
    color = "Continent",
    size = "Population"
  )

p_default

# anatomy of theme() ----

# Elements form an inheritance tree:
# text -> axis.text -> axis.text.x
# Setting a parent affects all its children.

# parent: all text becomes serif
p_default + theme(text = element_text(family = "serif"))

# child overrides parent
p_default +
  theme(
    text = element_text(family = "serif"),
    axis.text = element_text(family = "sans")
  )

# + vs %+replace% ----

# + keeps the base theme and tweaks it
p_default +
  theme_minimal() +
  theme(panel.grid.minor = element_blank())

# %+replace% starts fresh (better for theme functions)
my_theme <- theme_minimal() %+replace%
  theme(panel.grid.minor = element_blank())

p_default + my_theme

# theme_workshop() as a function ----

theme_workshop <- function() {
  theme_minimal(base_size = 12) %+replace%
    theme(
      plot.title = element_text(
        size = 14, hjust = 0,
        margin = margin(b = 10)
      ),
      plot.subtitle = element_text(
        size = 12, hjust = 0,
        margin = margin(b = 10)
      ),
      axis.title = element_text(size = 12),
      axis.text = element_text(size = 10),
      panel.grid.minor = element_blank(),
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(color = "grey90"),
      legend.title = element_text(size = 10),
      legend.text = element_text(size = 9),
      legend.position = "bottom",
      plot.background = element_rect(fill = "transparent", color = NA),
      panel.background = element_rect(fill = "transparent", color = NA)
    )
}

p_default + theme_workshop()

# apply globally with theme_set() ----

theme_set(theme_workshop())

ggplot(gap_2007, aes(x = continent, y = lifeExp, fill = continent)) +
  geom_boxplot() +
  labs(title = "Life expectancy by continent (2007)")

# source the theme from its own file ----

# In a real project, theme_workshop() lives in its own file:
# R/theme_lab.R, sourced at the top of every analysis script:
#   source(here::here("R", "theme_lab.R"))
#   theme_set(theme_lab())
