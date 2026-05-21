# Module 4 Exercise: Exporting figures
# If you fell behind during the demo, open demo_solutions/04_export_final.R to catch up first.

library(ggplot2)
library(dplyr)
library(gapminder)
library(ragg)
library(ggview)
library(here)

source(here::here("demo_solutions", "theme.R"))

dir.create(here("plots"), showWarnings = FALSE)

# Starting plot: mean life expectancy in Asia --------------------------------

gap_asia <- gapminder |>
  filter(continent == "Asia") |>
  group_by(year) |>
  summarise(mean_lifeExp = mean(lifeExp), .groups = "drop")

p_asia <- ggplot(gap_asia, aes(x = year, y = mean_lifeExp)) +
  geom_line(linewidth = 1, color = "#0072B2") +
  theme_workshop() +
  labs(
    title = "Mean life expectancy in Asia",
    x = NULL,
    y = "Life expectancy (years)"
  )

p_asia

# Task 1 ------------------------------------------------------------------

# Pick an outlet of your choise and run the 4 steps to export the plot in the
# right format:
# 1. Pick canvas dimensions for the outlet
# 2. Preview using ggview::canvas()
# 3. Tune base_size (and other theme elements) until it looks right
# 4. Export with ggsave() using the ragg png device

# Task 2 (If you have time) -------------------------------------------------
# Re-export the same plot as a PDF using cairo_pdf

# Task 3 (If you have time) -------------------------------------------------
# Export a plot for a different outlet (e.g. presentation, poster)
