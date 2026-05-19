library(ggplot2)
library(dplyr)
library(gapminder)
library(patchwork)
library(scales)

theme_set(theme_minimal(base_size = 12))

gap_2007 <- gapminder |> filter(year == 2007)
gap_continent <- gapminder |>
  group_by(year, continent) |>
  summarise(mean_lifeExp = mean(lifeExp), .groups = "drop")

# build three named plots --------------------------------------------------

# Always assign plots to named objects when you want to compose them.
p_scatter <- ggplot(
  gap_2007,
  aes(x = gdpPercap, y = lifeExp, color = continent)
) +
  geom_point(alpha = 0.7, size = 3) +
  scale_x_log10(labels = label_dollar()) +
  labs(
    title = "2007 snapshot",
    x = "GDP per capita",
    y = "Life expectancy (years)"
  )

p_lines <- ggplot(
  gap_continent,
  aes(x = year, y = mean_lifeExp, color = continent)
) +
  geom_line(linewidth = 1) +
  labs(
    title = "Over time",
    x = NULL,
    y = "Life expectancy (years)"
  )

p_box <- ggplot(
  gap_2007,
  aes(x = continent, y = lifeExp, color = continent)
) +
  geom_boxplot(fill = "white") +
  labs(
    title = "By continent (2007)",
    x = NULL,
    y = "Life expectancy (years)"
  )

# basic composition --------------------------------------------------------

p_scatter + p_lines      # side by side
p_scatter / p_lines      # stacked
(p_scatter + p_lines) / p_box  # 2 on top, 1 below

# collect guides and axis titles -------------------------------------------

# guides = "collect" merges identical legends into one.
# axis_titles = "collect" merges identical axis labels.
(p_scatter + p_lines) / p_box +
  plot_layout(guides = "collect") &
  theme(legend.position = "bottom")

# add panel tags -----------------------------------------------------------

# Tag panels A/B/C automatically.
(p_scatter + p_lines) / p_box +
  plot_layout(guides = "collect") +
  plot_annotation(tag_levels = "A") &
  theme(legend.position = "bottom")

# control relative widths and heights --------------------------------------

# widths argument inside plot_layout sets the column proportions.
(p_scatter + p_lines + plot_layout(widths = c(2, 1))) / p_box

# & vs + : apply a theme tweak to all panels ------------------------------

# `&` applies to every plot in the composition.
# `+` only modifies the last plot.
(p_scatter + p_lines) / p_box +
  plot_layout(guides = "collect") &
  theme(
    legend.position = "bottom",
    plot.title = element_text(size = 11, face = "bold")
  )

# inset_element() ---------------------------------------------------------

# Place a smaller plot on top of another.
p_scatter +
  inset_element(
    p_box +
      theme_void() +
      theme(legend.position = "none"),
    left = 0.55, bottom = 0.05, right = 0.98, top = 0.45
  )
