
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
  - `gap_asia` — Asian countries only (used in Module 3 exercise)
  - `gap_europe` — European countries only (used in Module 3 demo)
- **Thread**: bubble chart (gdpPercap vs lifeExp, colored by continent) is the main recurring plot across modules 1–2

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

### Module 1 — Custom themes (15 min) ✅ COMPLETE
**Scripts:** `R/01_themes.R`, `R/01_themes_final.R`, `exercises/01_themes_exercise.R`

**`theme_workshop()` — settled design:**
```r
theme_workshop <- function(base_size = 16, ink = "grey20", paper = "white") {
  theme_light(base_size = base_size, ink = ink, paper = paper) %+replace%
    theme(
      legend.text = element_text(size = rel(0.85)),
      panel.grid.minor = element_blank()
    )
}
```
Key decisions:
- `base_size = 16` — larger default for screenshare readability; Module 5 will show `base_size = 11/12` for publication
- `panel.border` removed — `theme_light()` + `ink` already handles it; no need to hard-code a color
- `plot.title` not suppressed — just don't include it in `labs()` (except Module 3 where ggtext title is the point)
- Only `legend.text` is stepped down with `rel()` — axis text stays at `base_size` (that's what it means)
- `ink`/`paper` passed through to `theme_light()` — brief demo of changing both for poster vs paper

**Scales on bubble chart:**
- `scale_x_log10(labels = label_dollar(accuracy = 1))`
- `scale_size(labels = label_number(scale_cut = cut_short_scale()))`

**Labels:** `color = "Continent"`, `size = "Population"` (both capitalised)

**Storyline order:**
1. Slides: raw p_bubble → motivation, inheritance tree diagram, why-a-function bullets
2. Live code: build theme_workshop() element by element
3. AFTER exercise: theme_set() reveal as payoff moment

**Cut:** `%+replace%` explanation (used silently), transparent background (mention only), deep ink/paper dive

### Module 2 — Color with intent (18 min) ✅ COMPLETE
**Scripts:** `R/02_color.R`, `R/02_color_final.R`, `exercises/02_color_exercise.R`
- Deleted outdated draft `exercises/02_color.R` (used old `colorblindr`/`paletteer` API)

**Okabe-Ito palette — settled design:**
```r
okabe <- palette.colors(palette = "Okabe-Ito")
continent_colors <- c(
  Africa   = okabe[[2]], # orange
  Americas = okabe[[3]], # sky blue
  Asia     = okabe[[4]], # bluish green
  Europe   = okabe[[6]], # blue
  Oceania  = okabe[[1]]  # black
)
```
- Black (`okabe[[1]]`) included — more distinguishable; assigned to Oceania (fewest points)
- Yellow (`okabe[[5]]`) skipped — low contrast on white

**Double-encoding removed** from both scripts — varying shapes breaks the bubble size encoding.
Double-encoding concept mentioned on slides only (works better on line/bar charts).

**Storyline order:**
1. Slide: default → cvdPlot() screenshot → motivation
2. Slide: 3 palette types (qualitative/sequential/diverging)
3. Slide: Okabe-Ito swatches + which color is skipped and why
4. Slide: named vector rationale (position-based vs. name-based, filtering problem)
5. Live code: `palette.colors()`, build named vector, apply, consistency demo, `cvdPlot()`
6. Live code: viridis, scico
7. Demo: `cols4all::c4a_gui()`

**Packages:** `colorBlindness`, `scico`, `cols4all` (GitHub: mtennekes/cols4all)

### Module 3 — Directing attention (22 min) ✅ COMPLETE
**Scripts:** `R/03_attention.R`, `R/03_attention_final.R`, `exercises/03_attention_exercise.R`

**Demo story: Europe — life expectancy, Germany vs Poland**
- `gap_europe` = all European countries (spaghetti background)
- Highlight: **Germany** (`#E69F00`) and **Poland** (`#0072B2`)
- Story: Germany climbed steadily (post-WWII recovery); Poland plateaued under communism (1965–1990), then accelerated sharply after 1989
- Key data: Poland lifeExp 70.8 (1972) → 71.0 (1992) → 75.6 (2007)
- `annotate()` label: "1989: fall of the Berlin Wall" — placed near x=1992, y=66
- Arrow to Poland's 1992 point is **optional / if time allows** (marked in script)
- Title uses `element_markdown()` with colored country names

**Exercise story: Asia — GDP per capita, China vs India**
- `gap_asia` = all Asian countries
- Highlight: China and India
- 5 tasks: gghighlight → named colors → ggrepel endpoints → ggtext title → annotate (stretch)
- Stretch: annotate China's 1978 reform period

**Progression (both demo and exercise):**
gghighlight → scale_color_manual (named vector) → geom_text_repel + drop legend → element_markdown title → annotate

**Status:** Scripts written, not yet reviewed/tested by instructor.
TODO: Run `03_attention_final.R` end-to-end to verify annotation position looks right on screen.

**Slides for Module 3:**
- Before/after spaghetti → highlighted plot
- One principle: "A plot should have one story"
- When to use direct labels vs legend

### Module 4 — Multipanel with patchwork (18 min) ✅ COMPLETE
**Scripts:** `R/04_patchwork.R`, `R/04_patchwork_final.R`, `exercises/04_patchwork_exercise.R`

**Three plots used (all colored by continent via `scale_color_scico_d(palette = "batlow")`):**
- `p_bubble` — gdpPercap vs lifeExp, sized by pop (2007 snapshot) — recurring anchor
- `p_life` — mean lifeExp over time by continent (line chart)
- `p_gdp` — mean GDP per capita over time by continent (line chart)

**Data objects:**
- `gap_2007` — filtered to year == 2007
- `gap_continent` — mean lifeExp and mean gdpPercap per continent per year

**Narrative arc:**
1. Assign three named plot objects (assign when composing)
2. Two-plot composition: `+` (side by side), `/` (stacked)
3. Three-panel layout with `()` grouping — discuss which arrangement tells the story better
4. `plot_layout(guides = "collect")` — merge identical continent legends
5. `&` refactor — strip `theme_workshop()` and `scale_color_scico_d()` from individual plots, apply once at composition level; `_bare` plot variants make before/after explicit
6. `plot_annotation(tag_levels = "A")` — automatic panel tags
7. `inset_element()` — `p_life` inset into corner of `p_bubble` (if time allows)
8. Optional map inset at end of final script (commented out, requires `rnaturalearth`)

**Key decision:** Scripts are self-contained — `theme_workshop()` redefined inline with a `# from Module 1` comment.

### Module 5 — Export (10 min) ✅ COMPLETE
**Scripts:** `R/05_export.R`, `R/05_export_final.R`, `exercises/05_export_exercise.R`

**Narrative arc:**
1. Default `ggsave()` — no dimensions, problem with reproducibility
2. Explicit `width`/`height`/`units`/`dpi` — target sizes: paper 89 mm, slide 150 mm, poster 200 mm
3. `ggview()` — preview at exact export size in plot pane before saving
4. `base_size` payoff: `base_size = 16` for screenshare → `base_size = 11/12` for print
5. `device = ragg::agg_png` — cross-platform, sharper text
6. `device = cairo_pdf` — embedded fonts for journal submission
7. `showtext` — brief mention for custom/Google fonts (commented example)

**Exercise:** Uses Asia summary line chart (single color, no legend — simpler than demo).

## Packages used across workshop
- ggplot2, dplyr, gapminder, scales
- colorBlindness, scico, cols4all (GitHub)
- gghighlight, ggrepel, ggtext
- patchwork
- ragg, ggview
