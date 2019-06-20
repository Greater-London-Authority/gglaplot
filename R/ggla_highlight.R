#' @export
StatHighlight <- ggplot2::ggproto(
  "StatHighlight", ggplot2::Stat,
  required_aes = c("x", "y", "group"),
  compute_group = function(
    data, scales, filter_type = "end",
    x_filt = NULL,
    y_filt = NULL) {
    if (filter_type == "end") {
      data <- data %>%
        dplyr::arrange(group, dplyr::desc(x)) %>%
        dplyr::distinct(., group, .keep_all = TRUE)
    } else if (filter_type == "start") {
      data <- data %>%
        dplyr::arrange(group, x) %>%
        dplyr::distinct(., group, .keep_all = TRUE)
    } else if (filter_type == "max") {
      data <- data %>%
        dplyr::arrange(group, dplyr::desc(y)) %>%
        dplyr::distinct(., group, .keep_all = TRUE)
    } else if (filter_type == "min") {
      data <- data %>%
        dplyr::arrange(group, y) %>%
        dplyr::distinct(., group, .keep_all = TRUE)
    } else if (filter_type == "xy") {
      if (!is.null(x_filt)) {
        data <- data %>%
          dplyr::filter(x == x_filt)
      }
      if (!is.null(y_filt)) {
        data <- data %>%
          dplyr::filter(y == y_filt)
      }
    }
    data
  })

#' @title GeomGLAPointHighlight
#' @description Geom to be used for highlighting points on a line chart with ggla_highlight()
#' @export
GeomGLAPointHighlight <- ggplot2::ggproto(
  "GeomGLAPointHighlight",
  ggplot2::GeomPoint,
  default_aes = ggplot2::aes(
    size = 6 * mm_to_pt, stroke = 3 * mm_to_pt,
    shape = 21,
    fill = ifelse(
      ggplot2::theme_get()$panel.background$fill == gla_inverse$background,
      gla_inverse$background,
      gla_default$background),
    colour = gla_colours$blue_core,
    alpha = 1))

#' @title GeomGLATextHighlight
#' @description Geom to be used for adding labels to points on a chart with ggla_highlight()
#' @export
GeomGLATextHighlight <- ggplot2::ggproto(
  "GeomGLATextHighlight",
  ggplot2::GeomText,
  default_aes = ggplot2::aes(
    colour = ifelse(
      ggplot2::theme_get()$panel.background$fill == gla_inverse$background,
      gla_inverse$label,
      gla_default$label),
    size = 12 * mm_to_pt,
    angle = 0,
    hjust = 0.5,
    vjust = 0.5,
    alpha = NA,
    family = "sans",
    fontface = 1,
    lineheight = 1))

#' @title GeomGLAAnnotate
#' @description Geom to be used for adding annotations to plots.
#' @export
GeomGLAAnnotate <- ggplot2::ggproto(
  "GeomGLAAnnotate",
  ggplot2::GeomText,
  default_aes = ggplot2::aes(
    colour = ifelse(
      ggplot2::theme_get()$panel.background$fill == gla_inverse$background,
      gla_inverse$`axis text & labels`,
      gla_default$`axis text & labels`
    ),
    size = 12 * mm_to_pt,
    angle = 0,
    hjust = 0,
    vjust = 0,
    alpha = NA,
    family = "sans",
    fontface = 1,
    lineheight = 1
  )
)


#' @title ggla_highlight
#' @description Highlight selected data points
#' @param filter_type One of string "end", "start", "max", "min" or "xy", Default: 'end'
#' @param x_filt If filter_type = "xy" use this to select which x-values to highlight, Default: NULL
#' @param y_filt If filter_type = "xy" use this to select which y-values to highlight, Default: NULL
#' @param geom Override the default connection between geom_highlight() and GeomGLAPointHighlight, for text use GeomGLATextHighlight Default: GeomGLAPointHighlight
#' @inheritParams ggplot2::layer
#' @inheritParams ggplot2::geom_point
#' @details To use gla_inverse theme this must be set using theme_set() prior to calling ggla_highlight()
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  \code{\link[ggplot2]{geom_point}}
#' @rdname ggla_highlight
#' @export 
#' @param data The data to be displayed in this layer. There are three options: If NULL, the default, the data is inherited from the plot data as specified in the call to ggplot(). A data.frame, or other object, will override the plot data. All objects will be fortified to produce a data frame. See fortify() for which variables will be created. A function will be called with a single argument, the plot data. The return value must be a data.frame, and will be used as the layer data, Default: NULL
#' @param mapping Set of aesthetic mappings created by aes() or aes_(). If specified and inherit.aes = TRUE (the default), it is combined with the default mapping at the top level of the plot. You must supply mapping if there is no plot mapping, Default: NULL
#' @import ggplot2
ggla_highlight <- function(mapping = NULL, data = NULL,
                           geom = GeomGLAPointHighlight, stat = "identity",
                           position = "identity", ...,
                           filter_type = "end", x_filt = NULL, y_filt = NULL,
                           na.rm = FALSE, show.legend = FALSE,
                           inherit.aes = TRUE) {
  ggplot2::layer(
    stat = StatHighlight, data = data, mapping = mapping, geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(filter_type = filter_type,
                  x_filt = x_filt,
                  y_filt = y_filt,
                  na.rm = na.rm,
                  ...)
  )
}
