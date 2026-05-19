# Module 3 Exercise: Directing attention
# Apply the same techniques to a different dataset.

library(ggplot2)
library(dplyr)
library(gapminder)
library(gghighlight)
library(ggrepel)
library(ggtext)
library(scales)

source(here::here("R", "01_themes_final.R"))
theme_set(theme_workshop())

gap_asia <- gapminder |> filter(continent == "Asia")

# Starting point: GDP per capita in Asia — another spaghetti chart
p <- ggplot(gap_asia, aes(x = year, y = gdpPercap, color = country)) +
  geom_line(linewidth = 1) +
  scale_y_continuous(labels = label_dollar()) +
  labs(x = NULL, y = "GDP per capita")

p

# 1. Use gghighlight() to highlight only China and India.
#    Set use_direct_label = FALSE.

# 2. Assign deliberate colors using a named vector and scale_color_manual().
#    Suggestion: China = "#E69F00", India = "#0072B2"

# 3. Add endpoint labels using geom_text_repel() and drop the legend.

# 4. Write a ggtext title that names both countries in their colors.

# stretch ------------------------------------------------------------------

# 5. Add an annotate() label marking China's economic reform period (1978).
#    No arrow needed — just a text label placed near the China line.
