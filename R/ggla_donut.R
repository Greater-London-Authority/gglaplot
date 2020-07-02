#' @title ggla_donut
#' @description This creates a donut chart, similar to a pie chart.
#' @param ... Other arguments to be passed on to geom_bar()
#' @param title String title to be used for plot. Will appear in the middle of the donut, Default: NULL
#' @param stat The statistical transformation to use on the data for this layer, as a string. Should be either 'count', for the number of cases in each group, or 'identity' to represent values in the data. Default: 'count'
#' @inheritParams ggplot2::layer
#' @inheritParams ggplot2::geom_point
#' @inheritParams ggplot2::geom_bar
#' @section Aesthetics:
#' ggla_donut() understands the following aesthetics (required aesthetics in bold).
#' \itemize{
#'     \item \strong{y}
#'     \item label \emph{(will appear outside the donut)}
#'     \item alpha
#'     \item colour
#'     \item fill
#'     \item group
#'     \item shape
#'     \item size
#'     \item stroke
#' }
#'
#' @details This works by creating a stacked bar chart and converting to polar coordinates.
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[ggplot2]{geom_bar}}
#' @rdname ggla_donut
#' @export
#' @import ggplot2
#' @importFrom utils modifyList
#' @param gla_theme Either "default" or "inverse", Default: 'default'
#' @param base_size base font size, Default: 14
#' @import checkmate

ggla_donut <- function(mapping = NULL, data = NULL, stat = "count",
                       title = NULL, gla_theme = "default", base_size = 14,
                       ...) {

  check <- checkmate::test_choice(gla_theme, choices = c("light", "dark"))
  if (check) {
    warning("The gla_themes have been renamed to default (light) and inverse (dark).")
    gla_theme <- ifelse(gla_theme == "light", "default", "inverse")
  }
  checkmate::assert_choice(gla_theme, c("default", "inverse"))

  colours <- get(paste0("gla_", gla_theme))

  title_text <- base_size * mm_to_pt * 20 / 24
  label_text <- base_size * mm_to_pt * 20 / 24
  if (is.null(mapping)) {
    bar_mapping <- ggplot2::aes(x = 2)
    label_mapping <- ggplot2::aes(x = 3)
  } else {
    bar_mapping <- utils::modifyList(ggplot2::aes(x = 2), mapping)
    bar_mapping["label"] <- NULL
    label_mapping <- utils::modifyList(ggplot2::aes(x = 3), mapping)
  }


  donut <- list(ggplot2::geom_bar(mapping = bar_mapping, stat = stat,
                                  position = "stack",
                                  colour = NA, ...),
                ggplot2::coord_polar(theta = "y", direction = -1),
                ggplot2::theme(
                  panel.grid.major.y = ggplot2::element_blank(),
                  axis.text.y = ggplot2::element_blank(),
                  axis.text.x = ggplot2::element_blank(),
                  axis.line = ggplot2::element_blank(),
                  axis.ticks.length.y = ggplot2::unit(
                    x = 0,
                    units = "pt"),
                  legend.position = "none"),
                ggplot2::xlim(c(0, 3.25)))
  if (!is.null(title)) {
    donut <- list(donut,
                 ggplot2::annotate(geom = "text", x = 0, y = 0, label = title,
                                   colour = colours$headlines,
                                   size = title_text))
  }

  donut <- list(donut,
                ggplot2::geom_text(label_mapping, stat = stat,
                          position = ggplot2::position_stack(vjust = 0.5),
                          colour = colours$`body text`,
                          size = label_text))

  return(donut)
}
