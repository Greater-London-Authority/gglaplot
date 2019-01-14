#' @title ggla_highlightarea
#' @description Add a shaded rectangle behind a plot.
#' @param xmin lower x-extent of highlighted area, Default: -Inf
#' @param xmax higher x-extent of highlighted area, Default: Inf
#' @param ymin lower y-extent of highlighted area, Default: -Inf
#' @param ymax higher y-extent of highlighted area, Default: Inf
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  \code{\link[ggplot2]{annotate}}
#' @rdname ggla_highlightarea
#' @export 
#' @import checkmate
#' @import ggplot2
ggla_highlightarea <- function(xmin = -Inf, xmax = Inf,
                               ymin = -Inf, ymax = Inf){
  
  #checks
  checkmate::assert_number(xmin)
  checkmate::assert_number(xmax)
  checkmate::assert_number(ymin)
  checkmate::assert_number(ymax)
  
  
  colours <- get_theme_colours()
  
  ggplot2::annotate('rect', xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, 
         fill = colours$`highlight area`, alpha = 0.04,
         colour = NA)
}
