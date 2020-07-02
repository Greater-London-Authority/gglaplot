#' @title ggla_horizbar
#' @description Create a horizontal bar chart
#' @param ... other parameters to be passed to geom_bar
#' @param stat The statistical transformation to use on the data for this layer, as a string, Default: "identity"
#' @param to100 boolean, If TRUE a context layer will be added below to bar chart up to 100, Default: FALSE
#' @inheritParams ggplot2::geom_bar
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[ggplot2]{geom_bar}}
#' @rdname ggla_horizbar
#' @export
#' @import checkmate
#' @param gla_theme Either "default" or "inverse", Default: 'default'
ggla_horizbar <- function(..., stat = "identity", position = "stack",
                         to100 = FALSE, gla_theme = "default") {

  # checks
  checkmate::assert_logical(to100)
  check <- checkmate::test_choice(gla_theme, choices = c("light", "dark"))
  if (check) {
    warning("The gla_themes have been renamed to default (light) and inverse (dark).")
    gla_theme <- ifelse(gla_theme == "light", "default", "inverse")
  }
  checkmate::assert_choice(gla_theme, c("default", "inverse"))

  colours <- get(paste0("gla_", gla_theme))

  horizbar <- list()
  if (to100 == TRUE) {
    horizbar <- list(horizbar,
                    ggplot2::geom_bar(ggplot2::aes(y = 100), stat = "identity",
                             fill = ggplot2::alpha(colours$`highlight area`,
                                                   0.04)))
  }
  if (position == "stack") {
    horizbar <- list(horizbar,
                    ggplot2::geom_bar(..., position = position,
                                      colour = colours$background, stat = stat))
  } else {
    horizbar <- list(horizbar,
                    ggplot2::geom_bar(..., position = position, stat = stat))
  }

  horizbar <- list(
    horizbar,
    ggplot2::coord_flip(),
    ggplot2::theme(panel.grid.major.y = ggplot2::element_blank(),
                   axis.text.y = ggplot2::element_text(
                     hjust = 0, vjust = 0.5,
                     margin = ggplot2::margin(t = 0, r = 0, b = 0, l = 0,
                                              unit = "pt")),
                   axis.ticks.length.y = unit(x = 0, units = "pt")))

  return(horizbar)

}
