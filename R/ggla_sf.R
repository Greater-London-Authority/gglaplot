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
ggla_sf <- function(...) {
  colours <- get_theme_colours()

  ggla_sf = list(ggplot2::geom_sf(colour = colours$background,...),
                 ggplot2::coord_sf(datum = NA),
                 ggplot2::theme(panel.grid = ggplot2::element_blank(),
                       axis.line = element_blank()))
  
  return(ggla_sf)
}
