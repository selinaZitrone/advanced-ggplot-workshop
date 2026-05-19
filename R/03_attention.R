# Module 3: Directing attention
# If you fall behind, open 03_attention_final.R to catch up

library(ggplot2)
library(dplyr)
library(gapminder)
library(gghighlight)
library(ggrepel)
library(ggtext)
library(scales)

source(here::here("R", "01_themes_final.R"))
theme_set(theme_workshop())

gap_europe <- gapminder |> filter(continent == "Europe")

# ── The default: a spaghetti chart ────────────────────────────────────────────

p_default <- ggplot(gap_europe, aes(x = year, y = lifeExp, color = country)) +
  geom_line(linewidth = 1) +
  labs(
    x = NULL,
    y = "Life expectancy"
  )

p_default

# ── gghighlight: dim everything except Germany and Poland ─────────────────────



# ── Assign deliberate colors ──────────────────────────────────────────────────



# ── ggrepel: label the endpoints, drop the legend ─────────────────────────────



# ── ggtext: tell the story in the title ───────────────────────────────────────



# ── annotate(): a contextual note ─────────────────────────────────────────────


