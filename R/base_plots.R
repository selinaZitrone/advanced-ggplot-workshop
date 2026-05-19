library(ggplot2)
library(dplyr)
library(gapminder)

# Subset with the newest data
gap_2007 <- gapminder |>
  filter(year == 2007)

# Live expectancy by continent in 2007
ggplot(
  gap_2007,
  aes(x = continent, y = lifeExp, fill = continent)
) +
  geom_boxplot() +
  labs(
    title = "Life expectancy by continent (2007)",
    x = "Continent",
    y = "Life expectancy (years)",
    fill = "Continent"
  )

# Live expectancy by continent over time
ggplot(
  gapminder,
  aes(x = year, y = lifeExp, color = continent)
) +
  geom_line(stat = "summary", fun = "mean") +
  labs(
    title = "Life expectancy by continent over time",
    x = "Year",
    y = "Life expectancy (years)",
    color = "Continent"
  )

# Gdp and live expectancy in Asian countries over time
ggplot(
  gapminder |> filter(continent == "Asia"),
  aes(x = year, y = lifeExp, color = country)
) +
  geom_line() +
  scale_x_log10() +
  labs(
    title = "Life expectancy vs GDP per capita in Asian countries",
    x = "GDP per capita (USD)",
    y = "Life expectancy (years)",
    color = "Country"
  )

gapminder |>
  filter(country == "Germany") |>
  ggplot(aes(x = year, y = pop)) +
  geom_line() +
  labs(
    title = "Life expectancy in Germany over time",
    x = "Year",
    y = "Life expectancy (years)"
  )

gapminder |>
  filter(country == "Germany") |>
  ggplot(aes(x = year, y = lifeExp)) +
  geom_line() +
  labs(
    title = "Life expectancy in Germany over time",
    x = "Year",
    y = "Life expectancy (years)"
  )
