## From default to publication-ready ggplot2

In this hands-on workshop, you’ll learn how to transform standard ggplot2 outputs into clear, polished, publication-ready figures. Working through practical examples, we will cover:

- choosing and customizing color scales and themes (e.g. colorblind-safe palettes)
- improving typography and annotations (e.g. with `ggtext` or `ggrepel`)
- combining plots into multi-panel layouts (e.g. with `patchwork`)
- exporting figures at the resolution and dimensions journals expect

Along the way I will show you a few useful extension packages from the ggplot2 ecosystem and you will learn techniques you can apply directly to your own plots.

**Format**: 2-hour hands-on workshop (participants follow along on their own computer)
### Requirements

Participants should have prior experience creating basic plots with ggplot2.

Please install [R](https://cran.r-project.org/) (4.2 or later) and an IDE of your choice ([RStudio](https://posit.co/download/rstudio-desktop/), [Positron](https://positron.posit.co/), or [VS Code](https://code.visualstudio.com/) all work). A list of required R packages will be shared at the beginning of the workshop. At minimum, you'll need the `tidyverse`.

# Content

## Intro

Default ggplot -> Publication ready

So many things that can be done
- Plot itself -> the geoms to pick
- Themes, colors, fonts
- How to highlight the results
- Combining plots into panels
- Export your plot in a readable size for different purposes

Different publications require/allow for different tweaks:

- Poster/presentation vs. Publication

- ggplot has separate packages for all of these things

- It's a rabbithole
- I want to show you some techniques and extension packages that I find particularly useful
	- Not an exhaustive list -> there is much more

## Today

Focus on:

- Custom themes
- Colors
- How to highlight your results and guide the readers
- Combine multiple plots into one
- Export plots at a good size
- Some other cool extension packages

How it works:
- There is a repository you can download from Github and open in the IDE of your choice -> I will use positron
- I will demonstrate each topic -> You can follow along or watch, both is fine
	- There will be short time to an exercise/playing around with the concept
- Questions: Always welcome in the chat or just unmute

- Steps (also in chat as text):
	1. Click the green **Code** button → **Download ZIP**
	2. Unzip somewhere you can find it
	3. Double-click the `.Rproj` file → opens in RStudio
		- *(Positron users: open the folder)*
	4. Run the code in `install_packages.R` to install the required packages for today

- Drop link in chat: **[GitHub repo URL]**

## Module 1: Themes

### Slides

- We all know the default ggplot theme that is not the most pretty
- But we can customize it with custom theme layers
- A quick win is just using one of the pre-defined `theme_*` layers
- And then we can further customize with a `theme()` layer
- The theme controls everything in your plot that is not related to the data like:
	- all the text: font size, bold or not, font family, ...

- Elements form an inheritance tree:
	- Setting a parent will affect all the children

- So we can take our default plot from before and we can add some theme layers to it to make it look nicer

- The problem: This works once. But what happens when you have ten scripts, or you change your mind about the font size?

- Switch to live demo

### Live demo custom theme

#### Intro

- Note: You can follow along or just watch. There will be an exercise afterwards
- Show the original plot
- Hint at the scales package -> Very useful to manipulate scales e.g. if numbers are really big or you need currencies etc. -> check it out -> link on website
- Show the original plot with a custom theme
	- Explain the `base_size` argument of `theme_light`
- Show second plot -> Copy past the custom theme to make them look the same
- How can we do this better? -> Define a custom theme once, then apply it everywhere
#### Building a custom theme

- A theme is a function -> You know this because you have to call e.g. `theme_bw()` with the brackets.
- So if we write a custom theme, it needs to be a function
	- Write basic function skeleton
```r
theme_workshop <- function(){

}
```
- How should our theme look like?
- We can just start with a predefined theme like in the example we just looked at:
```r
theme_workshop <- function(){
	theme_light()
}
```
- This function does not do much, but we can already use it
- Apply `theme_workshop` to the plot that does not have a theme yet
- We also want to be able to control the `base_size` in `theme_workshop`
	- We define 16 as the default value -> Will be used if we don't specify otherwise
	- Value for theme light will be taken from `theme_workshop`
```r
theme_workshop <- function(base_size = 16){
	theme_light(base_size = base_size) %+replace%
    theme(
      legend.text = element_text(size = rel(0.85)),
      panel.grid.minor = element_blank()
    )
}
```

- Now we are done with this basic theme and we can apply it to both plots
- Apply theme_workshop to both plots

### Move it to a different file
- Theme might be shared by plots produced in different files in your project
- Good practice: Define the theme in a separate file and source it where ever it is needed

- Create `theme.R`
- Copy paste the theme in there
- Use `source(here::here("R", "theme.R"))` to load the theme

- Now it can also be used in other files. Just add the source line on top

### Optional (if I have still time)

- Two more interesting arguments a theme can take: ink and paper
	- ink: Easy way to change the color of all lines and text
	- paper: Easy way to change all the area element colors
- Add ink and paper with sensible defaults to the theme

```r
theme_workshop <- function(base_size = 16, ink = "grey20", paper = "white") {
  theme_light(base_size = base_size, ink = ink, paper = paper) %+replace%
    theme(
      legend.text = element_text(size = rel(0.85)),
      panel.grid.minor = element_blank()
    )
}
```
- Show how the plot changed
- Apply the same theme but in dark mode:
```r
p_bubble + theme_workshop(ink = "grey90", paper = "grey20")
```

## Exercise 1: Now you with the theme

- Create your own theme function `theme_custom`
- Apply it to the plot
- Try out different base_sizes and colors 

### Set theme globally

- One more trick before we move on
- Already convenient
- But we can also set a default theme globally for all plots in this R session with `theme_set()`
- Set the theme globally, then create a new plot and show it is already styled (no theme layer needed)
	- Note: theme_set() is session-scoped, it does not persist after restarting R
```r 
theme_set(theme_workshop())
```

## Module 2: Color with intent

### Pick intuitive colors

- This one is easy to explain.
- Use colors your reader already associates with the thing (warm = hot, blue = water)
- Reference: Blogpost on colors by Lisa Charlotte Muth (Datawrapper)

### Two things that matter

- For scientific figures 2 things are very important to think about
	- Pick intuitive colors
	- Pick colorblind friendly colors (about 1 in 12 men has a colour vision deficiency)

### Three palette types

- Colors is a huge topic and there are an infinite amount of palettes out there to choose from
- In general: 3 palette types: qualitative/sequential/diverging
	- Qualitative: Discrete different data (e.g. continents)
	- Sequential: Data that follows a logical order (e.g. ascending number) — note both strips on the slide: same palette used continuously *and* as discrete bins
	- Diverging: E.g. Values Above and below 0
- Tie each to a gapminder example verbally: qualitative = continents, sequential = life expectancy, diverging = above/below average.

### Colorblind friendly options

- R's default colors are not color-blind friendly
- Colorblind friendly options I recomend for R packages are

- Okabe-Ito palette
	- Say: designed by Okabe & Ito to stay distinguishable under all common colour-blindness types; 8 hues plus black and grey; built into base R via palette.colors(); a solid default for categorical data. We skip the yellow (low contrast on white).

- Viridis color palette
	- Included in ggplot, good for sequential data
	- Say: perceptually uniform, colourblind- and greyscale-safe; built into ggplot2 (scale_*_viridis_c / _d); best for ordered or continuous data; options A-H (viridis, magma, plasma, cividis, ...).

- Scico package
	-  Designed for representing scientific data in way that is
	- fairly representing data
	- universally readable
	- citable

### Live demo

- Load packages and explain what they do
- Show p_bubble
- The slides said about 1 in 12 men can't read default ggplot colours — let's see what that actually looks like for our plot
- Simulate common types of color blindness
- Tip: shrink the text via the `text` parent so the 4-panel output stays readable (callback to Module 1's inheritance tree — one change cascades to axis, legend title, legend labels)
```r
cvdPlot(p_bubble + theme(text = element_text(size = 8)))
```

- That's the proof. How can we do better?
#### Choose manual colors: Okabe-Ito
- One famous colorblind-safe qualitative palette is the Okabe-Ito palette
- It comes with R
- Access the color values like this:
```r
palette.colors(palette = "Okabe-Ito")
```
- We could now just save these colors in a variable and use it in our plot
```r
okabe <- palette.colors(palette = "Okabe-Ito")
p_bubble +
  scale_color_manual(values = okabe)
```
- If I do this, I have one problem: 
	- If I have multiple plots with continents, I would like to have a consistent color for each continent for every plot
	- But if I have another plot, that only looks at two continents, the colors change because it takes the 2 first colors

```r 
gap_2007 |>
  filter(continent %in% c("Africa", "Europe")) |>
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(alpha = 0.7) +
  scale_x_log10(labels = label_dollar(accuracy = 1)) +
  scale_colour_manual(values = okabe_colors)
```

- Solution: Create a named vector of colors where each continent gets it's own color
	- something I always recommend you to do if you create custom colors
		- Here we can first of all choose which country gets which color
		- And we could even skip the yellow color because it does not have such a high contrast
```r
continent_colors <- c(
  Oceania = okabe[1],
  Africa = okabe[2],
  Americas = okabe[3],
  Asia = okabe[4],
  Europe = okabe[6]
)  
```
- Now we can apply the continent colors to both plots and you see that the colors are consistent
- Replace `okabe_colors` with `continent_colors` and show the result

- Extra: Add the custom color definitions to the `theme.R` so it is available also in other scripts that might need the same colors

#### Other safe palettes

- Instead of custom colors, you can also use color scale functions for ggplot
- Viridis color palette (`_d` for discrete `_c` for continuous): 
```r
p_bubble + scale_colour_viridis_d()
```
- Use with different options, check out
```r
scale_colour_viridis_d()
```

- Or scico palettes with (same pattern `_d` for discreete, `c` for continuous )

```r
p_bubble + scale_colour_scico_d(palette = "batlow")
```

- Find all options with
```r
scico_palette_names(categorical = TRUE)
```
### cvdPlot reference

- Brief reference slide — same `cvdPlot()` from the opening reveal
- Here so students have the code visible to use on their own plots

### Exercise

- Take a plot and try different color scales
	- Check available viridis options with `?scale_color_viridis`
	- Check available options for scico with
`scico_palette_names(categorical = TRUE)`
- Use cvdPlot to inspect the colors

## Module 4: patchwork

### Slides

- In scientific work it's very common to have nested and combined plots
- `patchwork` is the ggplot2 extension package for composing plots — exactly the kind of thing you'd otherwise reach for Inkscape or PowerPoint to do, but here it stays reproducible inside the ggplot pipeline
- The patchwork docs are excellent — point students there for anything beyond what we cover

Slide: Destination — a finished 3-panel composite with collected legend + A/B/C tags. Live-rendered from the demo plots so the slide can't drift from the demo.
Slide: Meet patchwork — header, one-line description, link to https://patchwork.data-imaginist.com/.

- Switch to live demo

### Live demo

#### Intro

- Here we have 3 plots built from the same gapminder data: the bubble, mean life expectancy over time per continent, mean GDP per capita over time per continent
- Quick teaching point before we compose anything: when you plan to combine plots, **assign them to named variables first**. patchwork can only combine plot objects.
- Show the three plots in turn

#### Combine two plots

- Once patchwork is loaded, you can combine plots with `+` and `/`
  - `+` places plots side by side
  - `/` stacks plots vertically
```r
p_bubble + p_life # side by side
p_life / p_gdp # stacked
```

#### Adding a third plot

- For three plots, use brackets to group — works just like arithmetic
```r
p_bubble / (p_gdp + p_life)   # bubble on top, two lines below
(p_bubble + p_life) / p_gdp   # bubble + life on top, GDP anchors below
```
- Ask the room: which arrangement tells the story better?

#### Apply layout and annotation

- You can add layers on the composition with `+`, just like you do on a single ggplot
- `plot_layout()` collects shared elements — all three plots share the continent legend and the year axis; no need to repeat them
```r
p_life / p_gdp +
  plot_layout(guides = "collect", axes = "collect", axis_titles = "collect")
```

- `plot_annotation()` adds things at the *composition* level, e.g. automatic panel tags
```r
p_life / p_gdp +
  plot_layout(guides = "collect", axes = "collect", axis_titles = "collect") +
  plot_annotation(tag_levels = "A", tag_suffix = ")")
```

#### Apply layers to every panel with `&`

- Now look at the three plot definitions: each one carries its own `theme_workshop()` and its own `scale_color_scico_d(palette = "batlow")`. That's redundant — if I want to change the theme, I have to change it in three places.
- patchwork lets us factor shared layers out and apply them once across the whole composition
- The operator is `&` — applies the layer to **every panel**; `+` only adds at the composition level
- Step 1: build `_bare` versions of the plots — strip `theme_workshop()` and the scale (and `geom_line()` for the demo) out of each individual plot
- Step 2: apply them once with `&`
```r
p_life_bare /
  p_gdp_bare +
  plot_layout(guides = "collect", axes = "collect", axis_titles = "collect") +
  plot_annotation(tag_levels = "A", tag_suffix = ")") &
  geom_line(linewidth = 1) &
  scale_color_scico_d(palette = "batlow") &
  theme_workshop()
```
- High-leverage idea: define once, apply everywhere. This is what makes patchwork worth learning beyond just "put two plots next to each other".

#### Insets (if time allows)

- `inset_element()` places one plot inside another
- Coordinates are fractions of the parent panel (0 = left/bottom, 1 = right/top)
```r
p_bubble +
  inset_element(
    p_life + theme(legend.position = "none"),
    left = 0.6,
    bottom = 0.01,
    right = 0.99,
    top = 0.4
  )
```
- Bonus if still time: the final script has a Europe locator map inset into the Module 3 lines plot — a more typical paper-figure pattern. Either demo it or just point students to it. **Skip this whole section if running behind.**

### Exercise

- Open `exercises/04_patchwork_exercise.R`
- Asia data (a different subset from the demo): scatter, life-expectancy lines, GDP lines, already styled in steelblue
- Tasks: stack two plots → arrange all three with `()` → apply `theme_workshop()` with `&` → add A/B/C tags via `plot_annotation()`
- Stretch: try `inset_element()` on a corner of `p_scatter`
- Catch-up: `solutions/04_patchwork_final.R`