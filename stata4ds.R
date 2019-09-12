library(ggplot2)
mpg %>%
  haven::write_dta("mpg.dta")
mpg %>%
  select(manufacturer:cyl) %>%
  slice(1:10) %>%
  knitr::kable(align = "c")

diamonds %>%
  haven::write_dta("diamonds.dta")

library(nycflights13)
library(tidyverse)

nycflights13::flights %>%
  haven::write_dta("nycflights13.dta")

Lahman::Batting %>%
  as_tibble() %>%
  haven::write_dta("batting.dta")
