GeomGLALine <- ggplot2::ggproto("GeomGLALine", ggplot2::GeomLine,
                       default_aes = ggplot2::aes(
                         colour = gla_colours$blue_core,
                         size = 3 * mm_to_pt, linetype = 1,
                         alpha = 1)
)

#' @title ggla_line
#' @description Wrapper for ggplot2::geom_line with round line ends
#' @param ... parameters passed to layer()
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname ggla_line
#' @export 
#' @param mapping Set of aesthetic mappings created by aes() or aes_(). If specified and inherit.aes = TRUE (the default), it is combined with the default mapping at the top level of the plot. You must supply mapping if there is no plot mapping, Default: NULL
#' @param data The data to be displayed in this layer. There are three options: If NULL, the default, the data is inherited from the plot data as specified in the call to ggplot(). A data.frame, or other object, will override the plot data. All objects will be fortified to produce a data frame. See fortify() for which variables will be created. A function will be called with a single argument, the plot data. The return value must be a data.frame, and will be used as the layer data, Default: NULL
#' @param stat The statistical transformation to use on the data for this layer, as a string., Default: 'identity'
#' @param position Position adjustment, either as a string, or the result of a call to a position adjustment function., Default: 'identity'
#' @param na.rm If FALSE, the default, missing values are removed with a warning. If TRUE, missing values are silently removed, Default: FALSE
#' @param show.legend logical. Should this layer be included in the legends? NA, the default, includes if any aesthetics are mapped. FALSE never includes, and TRUE always includes. It can also be a named logical vector to finely select the aesthetics to display., Default: NA
#' @param inherit.aes If FALSE, overrides the default aesthetics, rather than combining with them. This is most useful for helper functions that define both data and aesthetics and shouldn't inherit behaviour from the default plot specification, e.g. borders(), Default: TRUE
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
