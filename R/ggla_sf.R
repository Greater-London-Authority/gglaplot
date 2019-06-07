#' @title ggla_sf
#' @description Wrapper for ggplot2::geom_sf simplyfying coordinates and appearance
#' @param ... paramters to pass to geom_sf
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname ggla_sf
#' @export 
#' @import ggplot2
#' @param gla_theme Either "default" or "inverse", Default: 'default'
ggla_sf <- function(gla_theme = "default", ...) {

  check <- checkmate::test_choice(gla_theme, choices = c("light", "dark"))
  if (check) {
    warning("The gla_themes have been renamed to default (light) and inverse (dark).")
    gla_theme <- ifelse(gla_theme == "light", "default", "inverse")
  }
  checkmate::assert_choice(gla_theme, c("default", "inverse"))

  colours <- get(paste0("gla_", gla_theme))

  ggla_sf <- list(ggplot2::geom_sf(colour = colours$background, ...),
                 ggplot2::coord_sf(datum = NA),
                 ggplot2::theme(panel.grid = ggplot2::element_blank(),
                       axis.line = ggplot2::element_blank()))

  return(ggla_sf)
}
