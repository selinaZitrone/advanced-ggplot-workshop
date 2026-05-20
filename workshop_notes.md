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
- Set the theme globally, remove the theme layer, restart the session and show it is still the same theme
	- Other option: set theme, create a new plot and show it already has the theme -> DISCUSS
```r 
theme_set(theme_workshop())
```


