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
#' @param gla_theme Either "default" or "inverse", Default: 'default'
#' @import checkmate
ggla_axisat0 <- function(gla_theme = "default") {

  check <- checkmate::test_choice(gla_theme, choices = c("light", "dark"))
  if (check) {
    warning("The gla_themes have been renamed to default (light) and inverse (dark).")
    gla_theme <- ifelse(gla_theme == "light", "default", "inverse")
  }
  checkmate::assert_choice(gla_theme, c("default", "inverse"))

  colours <- get(paste0("gla_", gla_theme))

  ggla_axisat0 <- list(ggplot2::geom_hline(yintercept = 0, linetype = "solid",
                                           color = colours$`strong grid`,
                                           size = 1 * mm_to_pt),
                       ggplot2::theme(axis.ticks.y = element_line(
                         color = c(colours$`strong grid`,
                                   rep(colours$`light grid`, 1000)),
                         size = 1 * mm_to_pt)))
  return(ggla_axisat0)
}
