


#' @title ggla_axisat0
#' @description Forces the y-axis to y=0 and adds a strong axis line


#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  \code{\link[ggplot2]{geom_abline}}
#' @rdname ggla_axisat0
#' @export 
#' @import ggplot2
ggla_axisat0 <- function() {
  
  colours <- get_theme_colours()

  ggla_axisat0 <- ggplot2::geom_hline(yintercept = 0, linetype = 'solid', 
                                      color = colours$`strong grid`, 
                                      size = 1 * mm_to_pt)
  
  return(ggla_axisat0)
}