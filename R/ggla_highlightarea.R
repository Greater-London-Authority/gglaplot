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
#' #' @seealso
#'  \code{\link[ggplot2]{annotate}}
#' @rdname ggla_highlightarea
#' @export
#' @import checkmate
#' @param gla_theme Either "default" or "inverse", Default: 'default'
#' @import ggplot2
ggla_highlightarea <- function(xmin = -Inf, xmax = Inf,
                               ymin = -Inf, ymax = Inf,
                               gla_theme = "default"){

  #checks
  checkmate::assert_number(xmin)
  checkmate::assert_number(xmax)
  checkmate::assert_number(ymin)
  checkmate::assert_number(ymax)
  check <- checkmate::test_choice(gla_theme, choices = c("light", "dark"))
  if (check) {
    warning("The gla_themes have been renamed to default (light) and inverse (dark).")
    gla_theme <- ifelse(gla_theme == "light", "default", "inverse")
  }
  checkmate::assert_choice(gla_theme, c("default", "inverse"))

  colours <- get(paste0("gla_", gla_theme))

  ggplot2::annotate("rect", xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax,
         fill = colours$`highlight area`, alpha = 0.04,
         colour = NA)
}
