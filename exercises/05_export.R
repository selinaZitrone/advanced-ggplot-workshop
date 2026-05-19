library(ggplot2)
library(dplyr)
library(gapminder)
library(ragg)
library(scales)
library(here)

theme_set(theme_minimal(base_size = 12))

dir.create(here("plots"), showWarnings = FALSE)

gap_2007 <- gapminder |> filter(year == 2007)

p <- ggplot(
  gap_2007,
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)
) +
  geom_point(alpha = 0.7) +
  scale_x_log10(labels = label_dollar()) +
  labs(
    title = "Life expectancy vs GDP per capita (2007)",
    x = "GDP per capita",
    y = "Life expectancy (years)",
    color = NULL,
    size = "Population"
  )

p

# 1. Export p with default ggsave (no width/height/dpi):
#    ggsave(here("plots", "default.png"), p)

# 2. Export p at PLOS single-column size with ragg::agg_png:
#    width = 89, height = 70, units = "mm", dpi = 300

# 3. Open both files. Zoom in. Compare the text.

# stretch ----------------------------------------------------------------------

# - Export at double-column width (183 mm). What do you need to
#   change about font sizes so the text stays readable?

# - Export as PDF with cairo_pdf. Open the PDF and check the fonts
#   are embedded (in Acrobat: File -> Properties -> Fonts).

# - Use ggview::ggview(p, width = 89, height = 70, units = "mm")
#   to preview the export size in the plot pane.
