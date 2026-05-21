# Advanced ggplot2 workshop

A 2-hour hands-on workshop on publication-ready figures with ggplot2.  
**Audience:** R users who know the basics — geoms, aesthetics, `labs()`, simple `theme()` tweaks.

## Setup

Install the required packages by running this once before the workshop:

```r
source("install_packages.R")
```

> **Windows users:** The script uses `pak`, which will be installed automatically if needed. No Rtools required for the essential packages.

## Modules

| # | Topic | Demo script | Final script | Exercise |
|---|-------|-------------|--------------|---------|
| 1 | Custom themes | `demo/01_themes.R` | `demo_solutions/01_themes_final.R` | `exercises/01_themes_exercise.R` |
| 2 | Color with intent | `demo/02_color.R` | `demo_solutions/02_color_final.R` | `exercises/02_color_exercise.R` |
| 3 | Multipanel layouts | `demo/03_patchwork.R` | `demo_solutions/03_patchwork_final.R` | `exercises/03_patchwork_exercise.R` |
| 4 | Exporting figures | `demo/04_export.R` | `demo_solutions/04_export_final.R` | `exercises/04_export_exercise.R` |

## How to follow along

- Open the **demo script** at the start of each module and code along with the instructor.
- If you fall behind, open the **final script** to catch up before the exercise.
- At the end of each module, work through the **exercise script** on your own.

## Bonus material

`demo_solutions/bonus/attention.R` is a self-study module on directing attention with `gghighlight`, `ggrepel`, and `ggtext`. Not covered live — install the extra packages and explore at your own pace.
