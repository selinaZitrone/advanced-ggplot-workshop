# Module 5 Exercise: Exporting figures
# If you fell behind during the demo, open 05_export_final.R to catch up first.

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)
library(scico)
library(ragg)
library(ggview)
library(here)

# theme_workshop() — from Module 1
theme_workshop <- function(base_size = 16, ink = "grey20", paper = "white") {
  theme_light(base_size = base_size, ink = ink, paper = paper) %+replace%
    theme(
      legend.text = element_text(size = rel(0.85)),
      panel.grid.minor = element_blank()
    )
}

dir.create(here("plots"), showWarnings = FALSE)

# ── Starting plot: Asian countries over time ──────────────────────────────────

gap_asia <- gapminder |>
  filter(continent == "Asia") |>
  group_by(year) |>
  summarise(
    mean_lifeExp = mean(lifeExp),
    mean_gdpPercap = mean(gdpPercap),
    .groups = "drop"
  )

p_asia <- ggplot(gap_asia, aes(x = year, y = mean_lifeExp)) +
  geom_line(linewidth = 1, color = "#0072B2") +
  theme_workshop() +
  labs(
    title = "Mean life expectancy in Asia",
    x = NULL,
    y = "Life expectancy (years)"
  )

p_asia

# ── Task 1: Default vs. explicit dimensions ───────────────────────────────────

# Export p_asia twice:
#   (a) with default ggsave() — no width/height/dpi
#   (b) at presentation slide size (150 mm wide, 100 mm tall, 150 dpi)
# Open both files. What's different?

# ── Task 1b: Preview with ggview() ───────────────────────────────────────────

# Before saving the slide-sized version, preview it with ggview() at those
# exact dimensions so you can check font sizes without opening the file.

# ── Task 2: Adjust base_size for print ───────────────────────────────────────

# Export p_asia at single-column paper size (89 mm wide, 65 mm tall, 300 dpi).
# Before saving, recreate p_asia with a base_size appropriate for print (11 or 12).

# ── Task 3: Use ragg ─────────────────────────────────────────────────────────

# Re-export the print version using device = ragg::agg_png.
# Compare the output to Task 2 — zoom in on the axis labels.

# ── Stretch: PDF ─────────────────────────────────────────────────────────────

# Export p_asia (print size) as a PDF using device = cairo_pdf.
# (No dpi needed for vector formats — remove that argument.)
