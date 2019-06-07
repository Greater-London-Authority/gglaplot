StatHighlight <- ggplot2::ggproto("StatHighlight", ggplot2::Stat,
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


GeomPointHighlight <- ggplot2::ggproto(
  "GeomPointHighlight",
  ggplot2::GeomPoint,
  default_aes = ggplot2::aes(size = 6 * mm_to_pt, stroke = 3 * mm_to_pt,
                             shape = 21,
                             fill = ggplot2::theme_get()$panel.background$fill,
                             alpha = 1))


#' @title ggla_highlight
#' @description Highlight selected data points
#' @param filter_type One of string "end", "start", "max", "min" or "xy", Default: 'end'
#' @param x_filt If filter_type = "xy" use this to select which x-values to highlight, Default: NULL
#' @param y_filt If filter_type = "xy" use this to select which y-values to highlight, Default: NULL
#' @param geom Override the default connection between geom_highlight() and GeomPointHighlight, Default: GeomPointHighlight
#' @param position Position adjustment, either as a string, or the result of a call to a position adjustment function., Default: 'identity'
#' @inheritParams ggplot2::geom_point
#' @param ... Other arguments to be passed on to geom_bar()
#' @details DETAILS
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
#' @import ggplot2
ggla_highlight <- function(filter_type = "end", x_filt = NULL, y_filt = NULL,
                           data = NULL, mapping = NULL,
                           geom = GeomPointHighlight,
                           position = "identity", ...) {
  ggplot2::layer(
    stat = StatHighlight, data = data, mapping = mapping, geom = geom,
    position = position,
    params = list(filter_type = filter_type,
                  x_filt = x_filt,
                  y_filt = y_filt,
                  ...)
  )
}
