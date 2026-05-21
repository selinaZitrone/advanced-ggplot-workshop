# Module 1 Exercise solution: Custom themes
# One way to solve the exercise. Your theme can look completely different.

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)

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

# A theme based on theme_minimal()
theme_custom <- function(base_size = 14) {
  theme_minimal(base_size = base_size) %+replace%
    theme(
      plot.title = element_text(face = "bold", hjust = 0),
      panel.grid.minor = element_blank(),
      legend.position = "bottom"
    )
}

p_lines + theme_custom()
