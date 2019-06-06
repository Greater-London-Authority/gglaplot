GeomGGLALine <- ggplot2::ggproto(
  'GeomGGLALine', 
  ggplot2::GeomLine, 
  default_aes = ggplot2::aes(size = 3 * mm_to_pt,
                             alpha = 1))

#' @title ggla_line
#' @description Wrapper for ggplot2::geom_line with round line ends
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
  ggplot2::geom_line(..., lineend = 'round', geom = GeomGGLALine)
}
