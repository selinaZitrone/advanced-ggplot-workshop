# Module 4: Exporting figures in the right format

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)
library(scico)
library(ragg)
library(ggview)
library(here)

source(here("solutions", "theme.R"))

dir.create(here("plots"), showWarnings = FALSE)

# Create the plot ---------------------------------------------------------

gap_2007 <- gapminder |> filter(year == 2007)

p_bubble <- ggplot(
  gap_2007,
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)
) +
  geom_point(alpha = 0.7) +
  scale_x_log10(labels = label_dollar(accuracy = 1)) +
  scale_size(labels = label_number(scale_cut = cut_short_scale())) +
  scale_color_scico_d(palette = "batlow") +
  labs(
    x = "GDP per capita (USD, log scale)",
    y = "Life expectancy (years)",
    color = "Continent",
    size = "Population"
  ) +
  theme_workshop() # base_size = 16 at default

p_bubble

# The problem with default ggsave() ------------------------------------------

# No width/height: ggsave() uses the current plot pane
# A colleague with a different screen pane gets a different plot size
ggsave(here("plots", "bubble_default.png"), plot = p_bubble)

# Step 1: pick a canvas for your outlet --------------------------------------

# Typical canvas widths:
#   Paper, single column:     ~89 mm
#   Paper, 1.5 / 2 column:    ~120-180 mm
#   Presentation, half slide: ~150 mm
#   Presentation, full slide: ~250 mm
#   Poster panel, depends on the layout

# Step 2: preview the canvas with ggview ------------------------------------

# canvas() shows the plot at the exact export size
# Iterate here (theme, geoms) until it looks right, and then save the plot
# E.g. for a 2 column plot in a paper
p_bubble +
  canvas(width = 180, height = 150, units = "mm")

# Step 3: tune base_size for the canvas -------------------------------------

# Starting points to iterate from:
#  Paper (89-180 mm):   base_size 8-11
# Slide (150-250 mm):  base_size 14-20
# Poster (~200 mm):    base_size 18-24
# Geoms (point size, linewidth) also scale with the canvas but here it looks good

p_bubble_paper <- p_bubble + theme_workshop(base_size = 14)

p_bubble_paper +
  canvas(width = 180, height = 150, units = "mm")

# Step 4: export with ragg --------------------------------------------------

# ragg::agg_png() is cross-platform, faster, and sharper than the default PNG
# device in ggsave
ggsave(
  here("plots", "bubble_paper.png"),
  plot = p_bubble_paper,
  width = 180,
  height = 110,
  units = "mm",
  dpi = 300,
  device = ragg::agg_png
)

# A second canvas: half slide -----------------------------------------------

# Same four steps, different numbers. For a half slide (~150 mm) the
# default base_size = 16 already looks good

p_bubble +
  canvas(width = 150, height = 130, units = "mm")

ggsave(
  here("plots", "bubble_slide.png"),
  plot = p_bubble,
  width = 150,
  height = 130,
  units = "mm",
  dpi = 300,
  device = ragg::agg_png
)

# PDF with embedded fonts ----------------------------------------------------

# cairo_pdf embeds fonts in the file and is a robust default
ggsave(
  here("plots", "bubble_paper.pdf"),
  plot = p_bubble_paper,
  width = 180,
  height = 110,
  units = "mm",
  device = cairo_pdf
)
