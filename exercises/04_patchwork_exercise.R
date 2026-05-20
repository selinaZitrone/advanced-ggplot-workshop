# Module 4 Exercise: Multipanel layouts with patchwork
# If you fell behind during the demo, open 04_patchwork_final.R to catch up first.

library(ggplot2)
library(dplyr)
library(gapminder)
library(patchwork)
library(scales)
library(scico)

# theme_workshop() — from Module 1
theme_workshop <- function(base_size = 16, ink = "grey20", paper = "white") {
  theme_light(base_size = base_size, ink = ink, paper = paper) %+replace%
    theme(
      legend.text  = element_text(size = rel(0.85)),
      panel.grid.minor = element_blank()
    )
}

# ── Data ──────────────────────────────────────────────────────────────────────

# This exercise uses Asian countries — a different subset from the demo.

gap_asia <- gapminder |> filter(continent == "Asia")

gap_asia_summary <- gap_asia |>
  group_by(year) |>
  summarise(
    mean_lifeExp   = mean(lifeExp),
    mean_gdpPercap = mean(gdpPercap),
    .groups = "drop"
  )

gap_asia_2007 <- gap_asia |> filter(year == 2007)

# ── Three starting plots ───────────────────────────────────────────────────────

# These plots are ready — your job is to compose them.

p_scatter <- ggplot(
  gap_asia_2007,
  aes(x = gdpPercap, y = lifeExp, size = pop)
) +
  geom_point(alpha = 0.7, color = "steelblue") +
  scale_x_log10(labels = label_dollar(accuracy = 1)) +
  scale_size(labels = label_number(scale_cut = cut_short_scale()), guide = "none") +
  labs(
    title = "Asia 2007",
    x = "GDP per capita (USD, log scale)",
    y = "Life expectancy (years)"
  )

p_life_asia <- ggplot(
  gap_asia_summary,
  aes(x = year, y = mean_lifeExp)
) +
  geom_line(linewidth = 1, color = "steelblue") +
  labs(
    title = "Life expectancy over time",
    x = NULL,
    y = "Life expectancy (years)"
  )

p_gdp_asia <- ggplot(
  gap_asia_summary,
  aes(x = year, y = mean_gdpPercap)
) +
  geom_line(linewidth = 1, color = "steelblue") +
  scale_y_continuous(labels = label_dollar(accuracy = 1)) +
  labs(
    title = "GDP per capita over time",
    x = NULL,
    y = "GDP per capita (USD)"
  )

# ── Task 1: Combine two plots ─────────────────────────────────────────────────

# Stack p_scatter and p_life_asia vertically.


# ── Task 2: Add the third plot ────────────────────────────────────────────────

# Arrange all three plots so the scatter is on the left and the two line charts
# are stacked on the right. Use () to group panels.


# ── Task 3: Apply theme_workshop() with & ─────────────────────────────────────

# Apply theme_workshop() to the whole composition using &.
# Also move any axis label that is "NULL" to reduce clutter.


# ── Task 4: Add panel tags ────────────────────────────────────────────────────

# Add automatic A/B/C panel tags using plot_annotation().


# ── Stretch: Inset ────────────────────────────────────────────────────────────

# Place p_life_asia as a small inset in a corner of p_scatter.
# Adjust left/bottom/right/top until the positioning looks good.
