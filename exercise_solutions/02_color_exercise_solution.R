# Module 2 Exercise solution: Color with intent

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)
library(colorBlindness)
library(scico)

source(here::here("demo_solutions", "theme.R"))
theme_set(theme_workshop())

gap_continent <- gapminder |>
  summarise(mean_lifeExp = mean(lifeExp), .by = c(continent, year))

p_lines <- ggplot(
  gap_continent,
  aes(x = year, y = mean_lifeExp, color = continent)
) +
  geom_line(linewidth = 1) +
  scale_y_continuous(labels = label_number(suffix = " yrs")) +
  labs(x = NULL, y = "Mean life expectancy", color = "Continent")

# Task 1: scico palette (viridis also works: scale_colour_viridis_d())
p_scico <- p_lines + scale_colour_scico_d(palette = "batlow")
p_scico

# Task 2: check
cvdPlot(p_scico + theme(text = element_text(size = 8)))

# Bonus: named vector for stable continent colors
continent_colors <- setNames(
  scico::scico(5, palette = "batlow"),
  c("Africa", "Americas", "Asia", "Europe", "Oceania")
)
p_lines + scale_colour_manual(values = continent_colors)
