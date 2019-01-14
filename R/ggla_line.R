#' @title ggla_line
#' @description Wrapper for ggplot2::geom)line with round line ends
#' @param ... parameters passed to geom_line
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  \code{\link[ggplot2]{geom_path}}
#' @rdname ggla_line
#' @export 
#' @import ggplot2 
ggla_line <- function(...){
  ggplot2::geom_line(..., lineend = 'round')
}
