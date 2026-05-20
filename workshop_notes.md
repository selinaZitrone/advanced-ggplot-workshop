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

### Intro 

- Colors is a huge topic and there are an infinite amount of palettes out there to choose from
- In general: 3 palette types: qualitative/sequential/diverging
	- Qualitative: Discrete different data (e.g. continents)
	- Sequential: Data that follows a logical order (e.g. ascending number)
	- Diverging: E.g. Values Above and below 0
		- Decided: show the three types as simple colour-swatch strips (no gapminder plots, no map). Tie each to a gapminder example verbally: qualitative = continents, sequential = life expectancy, diverging = above/below average.

Slide 1: 3 columns with headers for the 3 palette types and a colour-swatch strip below each, plus a short bullet on when to choose which. (Swatches are generated in slides.qmd, no screenshots needed.)

- For scientific figures 2 things are very important to think about
	- Pick intuitive colors
	- Pick colorblind friendly colors

### Pick intuitive colors

- This one is easy to explain.

Slide: ![[Blogpost on colors](https://www.datawrapper.de/blog/colors) by Lisa Charlotte Muth (Datawrapper)](images/2025_04_17_data-visualisation/intuitive_colors.png)

![[Lecture  - Advanced ggplot workshop-1.png]]
  
### Use colorblind friendly colors

- R's default colors are not color-blind friendly
- Colorblind friendly options I recomend for R packages are

- Okabe-Ito palette
	- Say: designed by Okabe & Ito to stay distinguishable under all common colour-blindness types; 8 hues plus black and grey; built into base R via palette.colors(); a solid default for categorical data. We skip the yellow (low contrast on white).

Slide: Show Okabe Ito colors and link to the source. Bullet point to say integrated in base R

- Viridis color palette
	- Included in ggplot, good for sequential data
	- Say: perceptually uniform, colourblind- and greyscale-safe; built into ggplot2 (scale_*_viridis_c / _d); best for ordered or continuous data; options A-H (viridis, magma, plasma, cividis, ...).

Slide: Link to viridis do on ggplot page, show the different viridis color options (just the colors, not in a plot)

- Scico package
	-  Designed for representing scientific data in way that is
	- fairly representing data
	- universally readable
	- citable

Slide: Show scico colors (rendered as swatches in R, no screenshot needed), 2 bullte points why they are cool, link to scico package and link to the original source of the colors used in scico: https://www.fabiocrameri.ch/colourmaps/

Slide (just as reference): Shows how to install, load and use colorBlindness package and cvdPlot function on p_bubble

Slides (just as reference): Install, load and use cols4All with link to the package
### Live demo

- Load packages and explain what they do
- Show p-bubble
- How does this look like for colorblind readers?
- Simulate common types of color blindness
```r
cvdPlot(p_bubble)
```

- How can we do better?
#### Choose manual colors: Okabe-Ito
- One famouscolorblind-safe qualitative palette is the Okabe-Ito palette
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
#### Fancy tool cols4all (optional if time)

- Tool to browse all palettes and filter them by suitability
- Needs to install from Github -> Windows users need RTools installed
	- Try it out in the exercise.
	- If you can't install the package -> Install RTools first (after the workshop)
```r
library(cols4all)
c4a_gui()
```

### Exercise

- Take a plot and try different color scales
	- Check available viridis options with `?scale_color_viridis`
	- Check available options for scico with
`scico_palette_names(categorical = TRUE)`
- Use cvdPlot to inspect the colors