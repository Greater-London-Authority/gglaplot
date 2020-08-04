#' @title ggla_plotly_style
#' @description Adds default ggla style to a plotly plot
#' @param plot A plotly plot, created either using plot_ly or ggplotly.
#' @param gla_theme Either "default" or "inverse", Default: 'default'
#' @param base_size base font size, Default: 14
#' @param ... Other parameters passed to plotly::style
#' @return A plotly plot
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname ggla_plotly_style
#' @export
#' @importFrom plotly style
ggla_plotly_style <- function(plot, gla_theme = "default",
                              base_size = 14, ...) {

  colours <- get(paste0("gla_", gla_theme))
  label_size <- base_size * (12 / 14)

  ggla_plot <- plot %>%
    plotly::style(
      hoverlabel = list(bgcolor = colours$headlines,
                        bordercolor = colours$headlines,
                        font = list(family = "Arial",
                                    color = colours$background,
                                    size = label_size)),
      hoveron = "fill") %>%
    plotly::style(...)

  return(ggla_plot)
}
