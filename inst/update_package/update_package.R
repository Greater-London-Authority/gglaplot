# Process to go through when updating package
detach(package:gglaplot)
remove.packages('gglaplot')

R_files <- dir(path = "R", pattern = ".R$", full.names = TRUE)

R_files <- R_files[R_files != "R/data.R"]

# Run files through lintr
n <- 1
lintr::lint(R_files[n])

# Run files through pretty_namespace

force_list <- list(
  base = c("is.list", "as.list", "unique", "is.character", "as.vector",
           "is.null", "names", "split", "is.logical", "tolower",
           "nrow", "as.name", "attr", "transform", "match"),
  dplyr = c("desc", "filter"),
  graphics = c("rect", "plot", "text"),
  ggplot2 = c("alpha", "unit"),
  plotly = c("config", "layout", "style")
)
ignore_list = list(gglaplot = gsub("\\.R|R/", "", R_files))

# Run pretty_namespace on directory with overwrite = FALSE and check results
# If there are no changes to make this will throw an error with sinew 3.8
sinew::pretty_namespace('R', force = force_list,
                        ignore = ignore_list, overwrite = FALSE)

# TODO: Make necessary changes to force_list + ignore_list

# Run pretty_namespace on directory with overwrite = TRUE
sinew::pretty_namespace("R", force = force_list,
                        ignore = ignore_list, overwrite = TRUE)

# Run moga on directory with dry.run = TRUE and overwrite = FALSE and check results
# This won't add doc strings to new functions
for (file in R_files) {
  sinew::moga(file, cut = 3, use_dictionary = "man-roxygen/Dictionary-1.R", overwrite = FALSE)
}

# TODO: Make necessary changes to the dictionary

# Run moga on directory with dry.run = FALSE and overwrite = TRUE
for (file in R_files) {
  sinew::moga(file, cut = 3, use_dictionary = "man-roxygen/Dictionary-1.R",
              dry.run = FALSE, overwrite = TRUE)
}

# TODO: Make any necessary manual changes to .R files


roxygen2::roxygenise()

sinew::makeImport('R/', cut = 3, print = FALSE, format = 'description', desc_loc = '.')
# This won't appear automatically as only %||% is used
usethis::use_package('rlang')
# Need new functionality included in 3.3
usethis::use_package('ggplot2', min_version = 3.3)


# TODO: Run vignettes and resolve any errors

vignettes <- dir(path = "vignettes", pattern = "\\.Rmd$", full.names = TRUE)

# Run vignettes through lintr
n <- 4
lintr::lint(vignettes[n])


devtools::load_all()
# Build vignettes

devtools::build_vignettes()

# TODO: delete doc folder
devtools::install()
# TODO: Write NEWS
# TODO: Check version
pkgdown::build_site()


# TODO: commit and push

# TODO: Merge
