# Module 3 Exercise solution: Multipanel layouts

library(ggplot2)
library(dplyr)
library(gapminder)
library(patchwork)
library(scales)

source(here::here("demo_solutions", "theme.R"))

gap_asia <- gapminder |> filter(continent == "Asia")
gap_asia_summary <- gap_asia |>
  group_by(year) |>
  summarise(
    mean_lifeExp = mean(lifeExp),
    mean_gdpPercap = mean(gdpPercap),
    .groups = "drop"
  )
gap_asia_2007 <- gap_asia |> filter(year == 2007)

p_scatter <- ggplot(gap_asia_2007, aes(gdpPercap, lifeExp, size = pop)) +
  geom_point(alpha = 0.7, color = "steelblue") +
  scale_x_log10(labels = label_dollar(accuracy = 1)) +
  scale_size(
    labels = label_number(scale_cut = cut_short_scale()),
    guide = "none"
  ) +
  labs(
    title = "Asia 2007",
    x = "GDP per capita (USD, log scale)",
    y = "Life expectancy"
  )

p_life_asia <- ggplot(gap_asia_summary, aes(year, mean_lifeExp)) +
  geom_line(linewidth = 1, color = "steelblue") +
  labs(title = "Life expectancy over time", x = "Year", y = "Life expectancy")

p_gdp_asia <- ggplot(gap_asia_summary, aes(year, mean_gdpPercap)) +
  geom_line(linewidth = 1, color = "steelblue") +
  scale_y_continuous(labels = label_dollar(accuracy = 1)) +
  labs(title = "GDP per capita over time", x = "Year", y = "GDP per capita")

# Tasks 1 + 2: scatter on the left, line charts stacked on the right
# Tasks 3 + 4: apply theme_workshop() with & and add panel tags
p_scatter + (p_life_asia / p_gdp_asia) +
  plot_annotation(tag_levels = "A", tag_suffix = ")") &
  theme_workshop()

# Bonus: life-expectancy inset on the scatter
p_scatter +
  theme_workshop() +
  inset_element(
    p_life_asia + theme_workshop(base_size = 10),
    left = 0.55, bottom = 0.05, right = 0.99, top = 0.45
  )
