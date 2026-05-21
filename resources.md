# Resources

Further reading and links from the workshop, grouped by topic.

## Module 1 — Custom themes

- [ggplot2 theme system cheatsheet](slides/ggplot_theme_system_cheatsheet.pdf) — every theme element on one page (Henry Wang)
- [`theme()` reference](https://ggplot2.tidyverse.org/reference/theme.html) — canonical docs for every theme argument
- [`ggthemes`](https://jrnold.github.io/ggthemes/) — ready-made themes if you don't want to build your own

## Module 2 — Colour with intent

- [Which color scale to use](https://blog.datawrapper.de/which-color-scale-to-use-in-data-vis/) — Lisa Charlotte Muth, Datawrapper
- [Colour pitfalls (Wilke, *Fundamentals of Data Visualization*)](https://clauswilke.com/dataviz/color-pitfalls.html) — background on Okabe-Ito and CVD-safe palettes
- [`viridis`](https://sjmgarnier.github.io/viridis/) — perceptually uniform colour scales
- [`scico`](https://github.com/thomasp85/scico) and [Fabio Crameri's colour maps](https://www.fabiocrameri.ch/colourmaps/) — scientific palettes, designed to be fair and citable
- [`colorBlindness`](https://cran.r-project.org/package=colorBlindness) — `cvdPlot()` for CVD checks

## Module 3 — Multi-panel layouts with patchwork

- [patchwork documentation](https://patchwork.data-imaginist.com/) — excellent and exhaustive
- [`cowplot`](https://wilkelab.org/cowplot/) — an alternative; useful for fine alignment of axes across plots

## Module 4 — Exporting figures

- [Export module — ggplot2-uncharted](https://www.ggplot2-uncharted.com/module1/export)
- [`ggview`](https://github.com/idmn/ggview) — preview a plot at its true export size
- [`ragg`](https://ragg.r-lib.org/) — fast, high-quality raster device for PNG/TIFF

## Bonus — Directing attention (self-study)

Originally a module; cut for time. The script `solutions/bonus/attention.R` walks through three packages for guiding the reader's eye:

- [`gghighlight`](https://yutannihilation.github.io/gghighlight/) — fade non-focal data with one line
- [`ggrepel`](https://ggrepel.slowkow.com/) — non-overlapping text labels
- [`ggtext`](https://wilkelab.org/ggtext/) — markdown / HTML in titles, axis text, and annotations

Install these three (they're in the optional block of `install_packages.R`) and work through the script at your own pace.

## Honorable mentions

A couple more packages briefly shown on the closing slides:

- [`ggdist`](https://mjskay.github.io/ggdist/) — distributions and uncertainty (raincloud, halfeye, interval plots)
- [`ggridges`](https://wilkelab.org/ggridges/) — ridgeline / joy plots

## Browse more ggplot2 extensions

The official gallery lists ~120 community extension packages — worth a browse: [exts.ggplot2.tidyverse.org/gallery](https://exts.ggplot2.tidyverse.org/gallery/)
