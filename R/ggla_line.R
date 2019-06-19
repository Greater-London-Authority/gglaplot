#' @export
GeomGLALine <- ggplot2::ggproto("GeomGLALine", ggplot2::GeomLine,
                       default_aes = ggplot2::aes(
                         colour = gla_colours$blue_core,
                         size = 3 * mm_to_pt, linetype = 1,
                         alpha = 1)
)

#' @title ggla_line
#' @description Wrapper for ggplot2::geom_line with round line ends
#' @inheritParams ggplot2::layer
#' @inheritParams ggplot2::geom_point
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname ggla_line
#' @export 
#' @import ggplot2
ggla_line <- function(mapping = NULL, data = NULL, stat = "identity",
                      position = "identity", na.rm = FALSE,
                      show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomGLALine,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      lineend = "round",
      ...
    )
  )
}
