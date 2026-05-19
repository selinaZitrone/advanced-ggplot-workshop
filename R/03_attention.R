library(ggplot2)
library(dplyr)
library(gapminder)
library(gghighlight)
library(ggrepel)
library(ggtext)
library(scales)

theme_set(theme_minimal(base_size = 12))

gap_asia <- gapminder |> filter(continent == "Asia")

# default plot --------------------------------------------------------------

# 33 lines, an oversized legend, no story.
p_default <- ggplot(gap_asia, aes(x = year, y = gdpPercap, color = country)) +
  geom_line(linewidth = 1) +
  scale_y_continuous(labels = label_dollar()) +
  labs(
    title = "GDP per capita in Asia, 1952-2007",
    x = NULL,
    y = "GDP per capita"
  )

p_default

# gghighlight: dim everything except China and India ------------------------

p_highlight <- p_default +
  gghighlight(country %in% c("China", "India"), use_direct_label = FALSE)

p_highlight

# control which colors the highlighted lines get ---------------------------

# gghighlight sets its own internal color scale, so adding
# scale_color_manual after it prints a "Scale already present"
# message - the new scale wins, the message is harmless.
highlight_colors <- c(China = "#E69F00", India = "#0072B2")

p_colored <- p_default +
  gghighlight(country %in% c("China", "India"), use_direct_label = FALSE) +
  scale_color_manual(values = highlight_colors)

p_colored

# ggrepel: label the endpoints, then drop the legend -----------------------

endpoints <- gap_asia |>
  filter(year == max(year), country %in% c("China", "India"))

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

# ggtext: colored words in the title ---------------------------------------

# element_markdown() on plot.title enables HTML/markdown.
p_final <- p_labeled +
  labs(
    title = "**<span style='color:#E69F00'>China</span>** and **<span style='color:#0072B2'>India</span>**: GDP per capita 1952-2007"
  ) +
  theme(plot.title = element_markdown())

p_final

# annotate(): a one-off contextual note ------------------------------------

p_final +
  annotate(
    "label",
    x = 1960, y = 55000,
    label = "China's reform period\nbegan in 1978",
    hjust = 0,
    color = "grey40",
    size = 3.5,
    label.size = 0,
    fill = "white"
  ) +
  annotate(
    "segment",
    x = 1972, xend = 1978, y = 50000, yend = 3000,
    arrow = arrow(length = unit(0.2, "cm")),
    color = "grey40"
  )
