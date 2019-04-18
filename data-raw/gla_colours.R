library(dplyr)
library(usethis)
library(tibble)

gla_theme_colours <- read.csv("data-raw/gla_theme_colours.csv",
                              stringsAsFactors = FALSE)

gla_palette_colours <- read.csv("data-raw/gla_palette_colours.csv",
                                stringsAsFactors = FALSE)

gla_themes <- c("dark", "light")

for (gla_theme in gla_themes) {
  colours <- gla_theme_colours %>%
    filter(theme == gla_theme) %>%
    select(colour, hex) %>%
    deframe() %>%
    as.list()
  assign(paste("gla_", gla_theme, sep = ""), colours)
}

use_data(gla_dark, overwrite = TRUE)
use_data(gla_light, overwrite = TRUE)

gla_colours <- gla_palette_colours %>%
  mutate(colour = paste(colour, palette, sep = "_")) %>%
  select(-palette) %>%
  deframe() %>%
  as.list()

use_data(gla_colours, overwrite = TRUE)
use_data(gla_palette_colours, internal = TRUE, overwrite = TRUE)
