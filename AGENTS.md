# Advanced ggplot2 Workshop — Planning Notes

## Overview
- **Duration**: ~110 min of content + 10 min buffer (total 2 h)
- **Audience**: R users who know ggplot2 basics (geoms, aesthetics, labs(), basic theme() tweaks)
- **Format**: Live workshop; instructor explains with slides then live-codes; students follow along
- **Repo**: Shared with students ahead of time

## Repository conventions
- Each module has a **starting script** (e.g. `01_themes.R`) and a **final script** (e.g. `01_themes_final.R`)
- Starting script = what instructor opens at the beginning of the module (scaffolded, no finished code)
- Final script = fully worked version students can open if they fall behind
- Add this comment near the top of every starting script:
  `# If you fall behind, open 01_themes_final.R to catch up`
- Exercises are R scripts in the repo (e.g. `exercises/01_themes_exercise.R`)

## Slides
- Instructor uses Quarto slides (separate repository, not this one)
- For now: produce **outline / bullet suggestions** for slides; instructor will author them later
- No need to produce .qmd slide files here

## Data
- All examples use the **gapminder** R package
- Key recurring objects:
  - `gap_2007` — filtered to year == 2007 (bubble chart anchor)
  - `gap_continent` — mean lifeExp per continent per year (line chart)
  - `gap_asia` — Asian countries only (spaghetti → highlight demo)
- **Thread**: bubble chart (gdpPercap vs lifeExp, colored by continent) is the main recurring plot across modules

## Timing

| Segment          | Time   |
|------------------|--------|
| Intro            | 10 min |
| Module 1 Themes  | 15 min |
| Module 2 Color   | 18 min |
| Module 3 Attention | 22 min |
| Break            | 8 min  |
| Module 4 Patchwork | 18 min |
| Module 5 Export  | 10 min |
| Outro            | 9 min  |
| **Total**        | **110 min** |

## Exercise design principles
- Exercises apply the skill to a *different* subset or plot than the demo (transfer, not copy-paste)
- Exercises are R scripts with commented task instructions
- Students who fell behind use the final script to catch up before starting the exercise

## Module content decisions

### Module 1 — Custom themes (15 min)
**Base theme:** `theme_light()` — already close to journal style, minimal tweaks needed

**theme_workshop() elements (live coded in this order):**
1. `plot.title = element_text(size = rel(1.1), face = "bold")` — introduces rel()
2. `axis.title = element_text(size = rel(0.9), color = "grey30")` — hierarchy through size not color
3. `panel.grid.minor = element_blank()` — introduces element_blank()
4. `panel.border = element_rect(color = "grey70", fill = NA)` — introduces element_rect(), why fill = NA
5. `ink` / `paper` arguments (ggplot2 4.0) — brief demo: publications = default, posters = change both

**Storyline order:**
1. Slides: show raw p_bubble → "would you submit this?" → motivates the module
2. Slide: inheritance tree diagram (text → axis.text → axis.text.x) — concept only, no live code
3. Slide: why write a function (reuse, consistency, one place to change)
4. Live code: build theme_workshop() element by element, render after each step
5. AFTER exercise: theme_set() reveal as payoff moment

**Cut:**
- `%+replace%` vs `+` — drop entirely, use %+replace% silently
- Transparent background — mention only ("use fill = 'transparent', more in Module 5")
- Deep dive on ink/paper — brief demo only

**Scales introduced here:**
- `scale_x_log10(labels = label_dollar(accuracy = 1))` on bubble chart
- `scale_size(labels = label_number(scale_cut = cut_short_scale()))` on population

**Slides:** raw plot → motivation, inheritance tree diagram, why-a-function bullets, theme_set pattern

### Module 2 — Color with intent (18 min)
**Keep:**
- Why colorblind-safe matters (brief theory on slides)
- Okabe-Ito palette from base R (`palette.colors()`) — no package needed
- Named vector pattern with continent-to-color assignment
- Named vector consistency demo: filter to 2 continents, show colors stay locked
- `colorBlindness::cvdPlot()` to simulate CVD on the actual plot
- viridis (`scale_colour_viridis_d()`) — built into ggplot2
- scico (`scale_colour_scico_d()`) — CRAN, perceptually uniform
- cols4all (`c4a_gui()`) — GitHub install, interactive browser, "wow" moment at the end
- Double-encoding (color + shape) — brief, at the end

**Cut:**
- paletteer — replaced by scico + cols4all
- Deep dive on CVD types — one slide, mention protanopia/deuteranopia only

**Storyline order:**
1. Slide: show default bubble chart → cvdPlot() output side by side → "your reader may not see what you see"
2. Slide: three palette types (qualitative / sequential / diverging) — visual reference only, no code
3. Slide: brief mention of protanopia (~2%) and deuteranopia (~6%) as the two main CVD types
4. Live code: `palette.colors(palette = "Okabe-Ito")` — introduce the source
5. Live code: build named vector, assign continents deliberately
6. Live code: apply with `scale_colour_manual(values = continent_colors)`
7. Live code: consistency demo — filter to Africa + Europe, show named colors don't shift
8. Live code: `cvdPlot(p_okabe)` → confirm it holds up; contrast with a bad palette (`Set1`)
9. Live code: viridis — one line, mention greyscale-safe use case
10. Live code: scico — one or two palettes, mention `scico_palette_names()` to browse
11. Live code: double-encoding with `aes(shape = continent)` + `scale_shape_manual()`
12. Demo: `cols4all::c4a_gui()` — launch browser, let students explore during exercise

**Slides:**
- Default plot → cvdPlot() 4-panel (on slide as screenshot, not live)
- Three palette type reference (qualitative / sequential / diverging)
- Okabe-Ito swatch with color names
- Named vector rationale: position-based vs. name-based — show the filtering problem
- cols4all screenshot or live demo prompt

**Packages:**
- `colorBlindness` (CRAN) — `cvdPlot()`
- `scico` (CRAN) — `scale_colour_scico_d()`, `scico_palette_names()`
- `cols4all` (GitHub: mtennekes/cols4all) — `c4a_gui()`

### Module 3 — Directing attention (22 min)
**Keep:**
- Asia spaghetti as starting point
- `gghighlight` for China + India
- `scale_color_manual` with named color vector
- `ggrepel::geom_text_repel()` for endpoint labels
- `ggtext::element_markdown()` for colored title
- `scales::label_dollar()` on y-axis (reinforces module 1)
- Brief `annotate()` with label only (drop the arrow — too fiddly)

**Cut:**
- Arrow annotation (coordinates fiddly, low pedagogical value)

**Slides:** the "before/after" story, when to use direct labels vs legend

### Module 4 — Multipanel with patchwork (18 min)
**Keep:**
- `+` (side by side), `/` (stacked), nested `()` layouts
- `plot_layout(guides = "collect")`
- `&` vs `+` for applying theme to all panels
- `plot_annotation(tag_levels = "A")`
- `inset_element()` — keep as "wow" moment but cut if time is short

**Replace:** boxplot panel with bar chart of median GDP by continent
  (echoes bubble chart x-variable, more coherent)

**Slides:** patchwork operator overview, & vs + distinction

### Module 5 — Export (10 min)
**Keep:**
- `ggsave()` with explicit width/height/units/dpi
- Target sizes: paper figure (~3.5 in), presentation (~6 in), poster (~8 in)
- `ragg::agg_png()` or `device = ragg::agg_png` for crispy text
- Mention `showtext` or system fonts briefly

**Slides:** DPI table, size targets per output type

## Packages used across workshop
- ggplot2, dplyr, gapminder
- scales
- colorblindr, paletteer
- gghighlight, ggrepel, ggtext
- patchwork
- ragg
