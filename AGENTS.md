
# Advanced ggplot2 Workshop — Planning Notes

## Overview
- **Duration**: ~110 min of content + 10 min buffer (total 2 h)
- **Audience**: R users who know ggplot2 basics (geoms, aesthetics, labs(), basic theme() tweaks)
- **Format**: Live workshop; instructor explains with slides then live-codes; students follow along
- **Repo**: Shared with students ahead of time

## Repository conventions
- Each module has a **starting script** in `R/` (e.g. `R/01_themes.R`) and a **final script** in `solutions/` (e.g. `solutions/01_themes_final.R`)
- Starting script = what instructor opens at the beginning of the module (scaffolded, no finished code)
- Final script = fully worked version students can open if they fall behind
- Add this comment near the top of every starting script:
  `# If you fall behind, open solutions/01_themes_final.R to catch up`
- Exercises are R scripts in `exercises/` (e.g. `exercises/01_themes_exercise.R`)

### Theme sourcing model
- `theme_workshop()` lives in **one** place per "track" instead of being copy-pasted:
  - `solutions/theme.R` — the complete theme; **ships in the repo**, always present
  - `R/theme.R` — **does not exist in the repo**; the instructor *creates it live* during the Module 1 demo (the "move your theme into its own file" beat)
- Who sources what:
  - `R/` working scripts (Modules 2–5) → `source(here::here("R", "theme.R"))` (the file built live; this is the teaching payoff — "now every script reuses your theme")
  - `solutions/` finals and **all** `exercises/` → `source(here::here("solutions", "theme.R"))` (always present + guaranteed correct, so catch-up and exercises never break on a demo typo)
- Because Modules 2–5 depend on `R/theme.R`, **creating it in Module 1 is load-bearing** — that demo beat cannot be cut for time. (If trimming Module 1, cut the optional `ink`/`paper` bit instead.)
- The recurring `p_bubble` is defined inline in each module's scripts (each module is self-contained) rather than imported across modules.

## Slides
- Slides live in **this** repo under `slides/` (Quarto revealjs)
- Plan: a **single `slides/slides.qmd`** for the whole workshop, with `#` headings as per-module section dividers (one drop-in file, since slides later transfer into a separate lecture-series website repo)
- Plots are **live-rendered** from R chunks (so slides never drift from the demo code); **default revealjs theme**, no custom scss (instructor re-themes on transfer)
- `workshop_notes.md` (repo root) is the **master narration script** — what the instructor says, step by step, with inline `Slide N:` specs — and is the source of truth for slide content (supersedes the older per-module `slides/*_notes.md`)
- Built module by module; `workshop_notes.md` currently scripts Intro + Modules 1–2

## Build progress & open items (handoff)
- **All four modules built:** Intro, Module 1 (Themes), Module 2 (Colour), Module 3 (Patchwork), Module 4 (Export), and Outro are scripted in `workshop_notes.md` and fully built in `slides/slides.qmd`. Deck renders with `quarto render slides/slides.qmd` (needs the workshop R packages; `slides/slides.html` is gitignored).
- **Module 3 (Directing attention) cut for time** on 2026-05-21 (originally planned at 22 min; would have left only ~10 min buffer in the 2 h slot). The completed final script is kept as `solutions/bonus/attention.R` for self-study; required packages (`gghighlight`, `ggrepel`, `ggtext`) are listed as optional in `install_packages.R`. After the renumbering, Patchwork is Module 3 and Export is Module 4.
- **Per-module workflow:** (1) instructor scripts the module in `workshop_notes.md`, (2) review/agree on content & length, (3) build the slides and adjust the demo/exercise scripts. Resolve `DISCUSS:` tokens in `workshop_notes.md` directly when there's a clear best answer; otherwise raise them.
- **Open review items:**
  - *General:* `theme_workshop()`'s default signature passes `ink`/`paper`, which require ggplot2 ≥ 4.0 — make sure the install refreshes ggplot2.
- **Working preference:** discuss module-specific design decisions when reaching that module, not all upfront.

## Data
- All examples use the **gapminder** R package
- Key recurring objects:
  - `gap_2007` — filtered to year == 2007 (bubble chart anchor)
  - `gap_continent` — mean lifeExp per continent per year (line chart, Module 3)
  - `gap_asia` — Asian countries only (Module 4 exercise)
- **Thread**: bubble chart (gdpPercap vs lifeExp, colored by continent) is the recurring plot across all four modules

## Timing

| Segment          | Time   |
|------------------|--------|
| Intro            | 10 min |
| Module 1 Themes  | 15 min |
| Module 2 Color   | 18 min |
| Break            | 8 min  |
| Module 3 Patchwork | 18 min |
| Module 4 Export  | 10 min |
| Outro            | 9 min  |
| **Total**        | **88 min** (32 min buffer in 2 h slot) |

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
- `base_size = 16` — larger default for screenshare readability; Module 4 drops to `base_size = 14` for a 180 mm paper canvas
- `panel.border` removed — `theme_light()` + `ink` already handles it; no need to hard-code a color
- `plot.title` not suppressed — just don't include it in `labs()`
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

**Packages:** `colorBlindness`, `scico`

### Bonus — Directing attention (cut for time, kept as self-study)
**Script:** `solutions/bonus/attention.R` (renamed from `solutions/03_attention_final.R`).
Required packages — `gghighlight`, `ggrepel`, `ggtext` — are in the *optional* block of `install_packages.R`.

Originally Module 3 (22 min); cut on 2026-05-21 to leave healthy buffer in the 2 h slot. The demo story (Europe life expectancy, Germany vs Poland) and exercise story (Asia GDP, China vs India) live in the script for anyone who wants to work through it.

### Module 3 — Multipanel with patchwork (18 min) ✅ COMPLETE
**Scripts:** `R/03_patchwork.R`, `solutions/03_patchwork_final.R`, `exercises/03_patchwork_exercise.R`

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
8. Optional Europe locator-map inset at end of final script — Germany/Poland life-expectancy lines with a map inset (requires `rnaturalearth` + `sf`; skip if running behind)

**Key decision:** Scripts are self-contained — `theme_workshop()` redefined inline with a `# from Module 1` comment.

### Module 4 — Export (10 min) ✅ COMPLETE
**Scripts:** `R/04_export.R`, `solutions/04_export_final.R`, `exercises/04_export_exercise.R`

**Narrative arc — the 4-step workflow:**
1. **Pick canvas** for the outlet (demo: 180 × 110 mm, double-column paper)
2. **Preview with `ggview::canvas()`** — see the plot at true export size in the plot pane
3. **Tune `base_size`** for the canvas (demo drops 16 → 14)
4. **Export with `ragg::agg_png`** at the chosen dimensions and 300 dpi

Also covered:
- Default `ggsave()` shown first as the failure mode (no dimensions → not reproducible)
- Second canvas (half slide, 150 × 130 mm) at the end to reinforce that the workflow is fixed but the numbers change
- `cairo_pdf` for vector PDF with embedded fonts (one-block mention for journal submission)
- **Cut:** `showtext` removed entirely on 2026-05-20 (user decision)

**Key decisions:**
- No `theme_set()` in this module — `theme_workshop()` applied explicitly per plot so the `base_size` choice stays visible
- Colour thread: stays with `scale_color_scico_d("batlow")` from Module 3 (resolved — does not switch back to Module 2's `continent_colors`)
- Slides: 2 content slides only (problem side-by-side + rule-of-thumb table); the 4-step workflow lives in the live demo, not on slides

**Exercise:** Uses Asia summary line chart (single colour, no legend — simpler than demo). One workflow, one save, plus PDF stretch.

## Packages used across workshop
- ggplot2, dplyr, gapminder, scales, here (core)
- colorBlindness, scico (Module 2)
- patchwork (Module 3)
- ragg, ggview (Module 4)
- **Bonus only:** gghighlight, ggrepel, ggtext (for `solutions/bonus/attention.R`; in the optional block of `install_packages.R`)
- **Optional demo extra:** rnaturalearth, sf (Module 3 map-inset bonus)
