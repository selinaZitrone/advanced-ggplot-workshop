# Module 5: Exporting figures - FINAL SCRIPT
# This is the fully worked version. Open this if you fell behind during the demo.

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)
library(scico)
library(ragg)
library(ggview)
library(here)

source(here::here("solutions", "theme.R")) # loads theme_workshop()
theme_set(theme_workshop())

# Create an output directory for saved figures
dir.create(here("plots"), showWarnings = FALSE)

# The recurring plot ---------------------------------------------------------

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
  )

p_bubble

# The problem with default ggsave() ------------------------------------------

# No explicit dimensions: output size depends on the plot pane.
# Reproducibility breaks: a colleague with a different screen gets a different file.
ggsave(here("plots", "bubble_default.png"), plot = p_bubble)

# Set dimensions explicitly --------------------------------------------------

# Target sizes used in practice:
#   Paper figure (single column): ~89 mm  (~3.5 in)
#   Presentation slide:           ~150 mm (~6 in)
#   Poster panel:                 ~200 mm (~8 in)

ggsave(
  here("plots", "bubble_paper.png"),
  plot = p_bubble,
  width = 89,
  height = 70,
  units = "mm",
  dpi = 300
)

ggsave(
  here("plots", "bubble_slide.png"),
  plot = p_bubble,
  width = 150,
  height = 110,
  units = "mm",
  dpi = 150
)

# Preview at export size with ggview() ---------------------------------------

# Before saving, use ggview() to see the plot at the exact output dimensions
# in the plot pane, no need to save and re-open while iterating on font sizes.
ggview(p_bubble, width = 89, height = 70, units = "mm")
ggview(p_bubble, width = 150, height = 110, units = "mm")

# base_size for screen vs. print ---------------------------------------------

# base_size = 16 was chosen for screenshare readability.
# At 89 mm / 300 dpi the text is too large, drop to 11 or 12 for print.

p_bubble_print <- p_bubble + theme_workshop(base_size = 11)

ggsave(
  here("plots", "bubble_paper_sized.png"),
  plot = p_bubble_print,
  width = 89,
  height = 70,
  units = "mm",
  dpi = 300
)

# Open bubble_paper.png and bubble_paper_sized.png side by side to compare.

# Render with ragg -----------------------------------------------------------

# ragg::agg_png() is cross-platform, faster, and produces sharper text than
# the default PNG renderer. Pass it via the device argument.
ggsave(
  here("plots", "bubble_ragg.png"),
  plot = p_bubble_print,
  device = ragg::agg_png,
  width = 89,
  height = 70,
  units = "mm",
  dpi = 300
)

# PDF with embedded fonts ----------------------------------------------------

# cairo_pdf embeds fonts, required for most journal submissions.
# The default pdf() subsets fonts but does not always embed them fully.
ggsave(
  here("plots", "bubble_print.pdf"),
  plot = p_bubble_print,
  device = cairo_pdf,
  width = 89,
  height = 70,
  units = "mm"
)

# showtext (brief mention) ---------------------------------------------------

# To use Google Fonts or custom system fonts, load them with the showtext package
# before rendering. Add a base_family argument to theme_workshop() to wire it in.
#
# library(showtext)
# font_add_google("Lato", "lato")
# showtext_auto()
# theme_workshop(base_family = "lato")
