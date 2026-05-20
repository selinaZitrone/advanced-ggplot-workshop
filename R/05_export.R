# Module 5: Exporting figures
# If you fall behind, open solutions/05_export_final.R to catch up

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)
library(scico)
library(ragg)
library(ggview)
library(here)

source(here::here("R", "theme.R")) # theme_workshop() (you create theme.R in Module 1)
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

# No explicit dimensions: ggsave() uses whatever size the plot pane happens to be.
# The font that looked right at base_size = 16 on screen may look huge in print.

# Set dimensions explicitly --------------------------------------------------

# Always specify width, height, units, and dpi.
# Target sizes used in practice:
#   Paper figure (single column): ~89 mm  (~3.5 in)
#   Presentation slide:           ~150 mm (~6 in)
#   Poster panel:                 ~200 mm (~8 in)

# Preview at export size with ggview() ---------------------------------------

# Before saving, use ggview() to see the plot at the exact output dimensions
# in the plot pane, no need to save and re-open while iterating.

# base_size for screen vs. print ---------------------------------------------

# base_size = 16 was chosen for screenshare readability.
# At 89 mm / 300 dpi that same font is too large.
# Match base_size to the output size, not the screen.

# Render with ragg -----------------------------------------------------------

# The default PNG renderer varies across platforms and can produce fuzzy text.
# ragg::agg_png() is cross-platform and sharper. Pass it as the device argument.

# PDF with embedded fonts ----------------------------------------------------

# cairo_pdf embeds fonts in the file, important for journal submission.
# The default pdf() does not embed fonts, which can cause rendering issues.

# showtext (brief mention) ---------------------------------------------------

# To use Google Fonts or custom system fonts, load them with the showtext package
# before rendering. Add a base_family argument to theme_workshop() to wire it in.
#
# library(showtext)
# font_add_google("Lato", "lato")
# showtext_auto()
# theme_workshop(base_family = "lato") # add base_family arg to the function
