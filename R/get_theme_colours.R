#' @title get_theme_colours()
#' @description Fetches the colours for the current GLA theme
#' @return A named list of colours
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname get_theme_colours
#' @export 
#' @import ggplot2
get_theme_colours <- function() {
  
  theme_current <- ggplot2::theme_get()
  
  if (theme_current$panel.background$fill == gla_light$background) {
    colours <- gla_light
  } else if (theme_current$panel.background$fill == gla_dark$background) {
    colours <- gla_dark
  } else {
    colours <- gla_light
    warning('No valid GLA theme set, GLA light has been used')
  }
  return(colours)
}
