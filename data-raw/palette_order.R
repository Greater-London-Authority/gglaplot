library(usethis)

core_order <- c("blue", "ldnmyr", "yellow", "red", "green", "purple",
                "turquoise", "pink", "orange", "ldnpink")
ldn_order <- c("blue", "ldnpink", "yellow", "ldnmyr", "orange", "turquoise",
               "purple", "red", "pink", "green")
light_order <- c("blue", "purple", "yellow", "red", "green", "turquoise",
                 "orange")
dark_order <- c("blue", "magenta", "yellow", "red", "green", "turquoise",
                "purple", "orange")

use_data(core_order, internal = TRUE, overwrite = TRUE)
use_data(ldn_order, internal = TRUE, overwrite = TRUE)
use_data(light_order, internal = TRUE, overwrite = TRUE)
use_data(dark_order, internal = TRUE, overwrite = TRUE)
