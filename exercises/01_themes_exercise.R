# Module 1 Exercise: Custom themes
#
# In this exercise you'll apply and adapt theme_workshop() to a different plot.
#
# Setup: run this block first ──────────────────────────────────────────────────

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)

source(here::here("R", "01_themes_final.R")) # loads theme_workshop()
theme_reset()                                 # clear any active theme_set()

gap_continent <- gapminder |>
  summarise(mean_lifeExp = mean(lifeExp), .by = c(continent, year))

# This is your starting plot for the exercise:
p_lines <- ggplot(gap_continent, aes(x = year, y = mean_lifeExp, color = continent)) +
  geom_line(linewidth = 1) +
  scale_y_continuous(labels = label_number(suffix = " yrs")) +
  labs(
    title = "Life expectancy over time by continent",
    x     = NULL,
    y     = "Mean life expectancy",
    color = "Continent"
  )

p_lines  # run this to see the unstyled plot

# ── Task 1 ────────────────────────────────────────────────────────────────────
# Apply theme_workshop() to p_lines.



# ── Task 2 ────────────────────────────────────────────────────────────────────
# Make at least ONE deliberate change to theme_workshop() to suit this plot.
# Ideas (pick one or try your own):
#   - Move the legend inside the plot panel using legend.position = c(x, y)
#   - Remove ALL gridlines (major and minor, both axes)
#   - Change the title color to something that suits you
#   - Make the axis text larger
#
# Tip: copy theme_workshop() here, modify it, and apply the new version to p_lines.



# ── Task 3 (bonus) ────────────────────────────────────────────────────────────
# Set your modified theme globally with theme_set(), then create a second plot
# (any plot you like using gapminder data) and confirm it picks up your theme
# without explicitly calling it.


