# Bonus: Directing attention
#
# Not covered in the live workshop — included as bonus material to explore on your own.
# Required packages (not in install_packages.R): gghighlight, ggrepel, ggtext
# Install with: pak::pak(c("gghighlight", "ggrepel", "ggtext"))

library(ggplot2)
library(dplyr)
library(gapminder)
library(gghighlight)
library(ggrepel)
library(ggtext)
library(scales)

source(here::here("demo_solutions", "theme.R")) # loads theme_workshop()
theme_set(theme_workshop())

gap_europe <- gapminder |> filter(continent == "Europe")

# The default: a spaghetti chart ---------------------------------------------

# 30 lines, a legend nobody can read, no story.
p_default <- ggplot(gap_europe, aes(x = year, y = lifeExp, color = country)) +
  geom_line(linewidth = 1) +
  labs(
    x = NULL,
    y = "Life expectancy"
  )

p_default

# gghighlight: dim everything except Germany and Poland ----------------------

p_highlight <- p_default +
  gghighlight(
    country %in% c("Germany", "Poland"),
    use_direct_label = FALSE
  )

p_highlight

# Assign deliberate colors ---------------------------------------------------

# Named vector ties back to Module 2
highlight_colors <- c(Germany = "#E69F00", Poland = "#0072B2")

p_colored <- p_default +
  gghighlight(
    country %in% c("Germany", "Poland"),
    use_direct_label = FALSE
  ) +
  scale_color_manual(values = highlight_colors)

p_colored

# ggrepel: label the endpoints, drop the legend ------------------------------

endpoints <- gap_europe |>
  filter(year == max(year), country %in% c("Germany", "Poland"))

p_labeled <- p_colored +
  geom_text_repel(
    data = endpoints,
    aes(label = country),
    nudge_x = 3,
    hjust = "left",
    direction = "y",
    segment.color = NA
  ) +
  theme(legend.position = "none")

p_labeled

# ggtext: tell the story in the title ----------------------------------------

# element_markdown() enables HTML/inline CSS in text elements
p_final <- p_labeled +
  labs(
    title = "**<span style='color:#E69F00'>Germany</span>** climbed steadily; **<span style='color:#0072B2'>Poland</span>** stalled under communism, then caught up after 1989"
  ) +
  theme(plot.title = element_markdown())

p_final

# annotate(): a contextual note ----------------------------------------------

p_final +
  annotate(
    "label",
    x = 1992, y = 66,
    label = "1989: fall of the\nBerlin Wall",
    hjust = 0,
    color = "grey40",
    size = 3.5,
    label.size = 0,
    fill = "white"
  )

# Optional: arrow to 1992 data point (if time allows) ------------------------

p_final +
  annotate(
    "label",
    x = 1992, y = 66,
    label = "1989: fall of the\nBerlin Wall",
    hjust = 0,
    color = "grey40",
    size = 3.5,
    label.size = 0,
    fill = "white"
  ) +
  annotate(
    "segment",
    x = 1993, xend = 1992, y = 68.5, yend = 70.9,
    arrow = arrow(length = unit(0.2, "cm")),
    color = "grey40"
  )
