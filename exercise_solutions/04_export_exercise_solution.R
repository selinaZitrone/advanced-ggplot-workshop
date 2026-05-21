# Module 4 Exercise solution: Exporting figures

library(ggplot2)
library(dplyr)
library(gapminder)
library(ragg)
library(ggview)
library(here)

source(here("demo_solutions", "theme.R"))

dir.create(here("plots"), showWarnings = FALSE)

gap_asia <- gapminder |>
  filter(continent == "Asia") |>
  group_by(year) |>
  summarise(mean_lifeExp = mean(lifeExp), .groups = "drop")

p_asia <- ggplot(gap_asia, aes(year, mean_lifeExp)) +
  geom_line(linewidth = 1, color = "#0072B2") +
  labs(
    title = "Mean life expectancy in Asia",
    x = NULL,
    y = "Life expectancy (years)"
  )

# Task 1: paper double-column, 180 x 110 mm
p_paper <- p_asia + theme_workshop(base_size = 11)

p_paper + canvas(width = 180, height = 110, units = "mm")

ggsave(
  here("plots", "asia_paper.png"),
  plot = p_paper,
  width = 180, height = 110, units = "mm",
  dpi = 300, device = ragg::agg_png
)

# Task 2: same canvas as PDF with embedded fonts
ggsave(
  here("plots", "asia_paper.pdf"),
  plot = p_paper,
  width = 180, height = 110, units = "mm",
  device = cairo_pdf
)

# Task 3: half slide, 150 x 100 mm with a larger base_size
p_slide <- p_asia + theme_workshop(base_size = 16)

ggsave(
  here("plots", "asia_slide.png"),
  plot = p_slide,
  width = 150, height = 100, units = "mm",
  dpi = 300, device = ragg::agg_png
)
