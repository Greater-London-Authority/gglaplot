library(ggplot2)
library(devtools)

mm_to_pt = 1 / (ggplot2::.pt * 72/96)
devtools::use_data(mm_to_pt, overwrite = TRUE)
