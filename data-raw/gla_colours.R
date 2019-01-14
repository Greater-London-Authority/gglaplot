library(dplyr)
library(devtools)

gla_colours <- read.csv('data-raw/gla_colours.csv',
                        colClasses = c('Colour' = 'character',
                                       'Theme' = 'character',
                                       'Muted' = 'logical',
                                       'Hex' = 'character',
                                       'endOfPaletteHex' = 'character'))

main_colours <- gla_colours %>%
  dplyr::filter(endOfPaletteHex != '') %>%
  dplyr::pull(Colour) %>%
  unique()

muted_colours <- gla_colours %>%
  dplyr::filter(Muted == TRUE) %>%
  dplyr::pull(Colour) %>%
  unique()

for (theme in c('dark','light')) {
  colours <- gla_colours %>%
    dplyr::filter(Theme == theme) %>%
    dplyr::filter(Muted == FALSE) %>%
    dplyr::select(Colour, Hex)
  colours <- base::split(colours$Hex, colours$Colour)
  for (colour in main_colours) {
    colours[paste(colour, 'end', sep = '_')] <- gla_colours %>%
      dplyr::filter(Theme == theme) %>%
      dplyr::filter(Muted == FALSE) %>%
      dplyr::filter(Colour == colour) %>%
      dplyr::pull(endOfPaletteHex)
  }
  for (colour in muted_colours) {
    colours[paste(colour, 'muted', sep = '_')] <- gla_colours %>%
      dplyr::filter(Theme == theme) %>%
      dplyr::filter(Muted == TRUE) %>%
      dplyr::filter(Colour == colour) %>%
      dplyr::pull(Hex)
  }
  assign(paste('gla_', theme, sep = ''), colours)
  
}
devtools::use_data(gla_colours, internal = TRUE, overwrite = TRUE)
devtools::use_data(gla_dark, overwrite = TRUE)
devtools::use_data(gla_light, overwrite = TRUE)
