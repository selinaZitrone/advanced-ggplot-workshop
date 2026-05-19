library(ggplot2)
library(dplyr)
library(gapminder)
library(ragg)
library(ggview)
library(scales)
library(here)

theme_set(theme_minimal(base_size = 12))

# make sure the output directory exists
dir.create(here("plots"), showWarnings = FALSE)

# a representative plot ----------------------------------------------------

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

# default ggsave -----------------------------------------------------------

# No width/height/dpi: uses the dimensions of the plot pane.
# Whatever font size you picked will look different here than in print.
ggsave(here("plots", "default.png"), plot = p)

# ggsave at a real journal column width ------------------------------------

# PLOS-Biology single column: 89 mm. Double column: 183 mm.
# Most journals publish exact dimensions in their figure guidelines.
ggsave(
  here("plots", "single_column.png"),
  plot = p,
  width = 89,
  height = 70,
  units = "mm",
  dpi = 300
)

# use the ragg renderer for crisp text -------------------------------------

# Default png() uses the system antialiaser - fuzzy text on many setups.
# ragg::agg_png uses AGG, handles unicode/emoji/ligatures cleanly,
# and is consistent across platforms.
ggsave(
  here("plots", "single_column_ragg.png"),
  plot = p,
  device = ragg::agg_png,
  width = 89,
  height = 70,
  units = "mm",
  dpi = 300
)

# preview at export size with ggview ---------------------------------------

# Wrap your plot to see it at the requested dimensions in the plot pane.
# No need to save and re-open while you iterate on font sizes.
ggview(p, width = 89, height = 70, units = "mm")

ggview(p, width = 183, height = 100, units = "mm")

# PDF with embedded fonts --------------------------------------------------

# cairo_pdf embeds fonts. Default pdf() does not, which can break
# the figure on a reviewer's machine.
ggsave(
  here("plots", "single_column.pdf"),
  plot = p,
  device = cairo_pdf,
  width = 89,
  height = 70,
  units = "mm"
)
