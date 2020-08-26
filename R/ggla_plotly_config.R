#' @title ggla_plotly_config
#' @description Adds default ggla config to a plotly plot
#' @param plot A plotly plot, created either using plot_ly or ggplotly.
#' @param ... Other parameters passed to plotly::config
#' @return A plotly plot
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname ggla_plotly_config
#' @export
#' @importFrom plotly config
ggla_plotly_config <- function(plot, ...) {
  ggla_plotly <- plot %>%
    plotly::config(displayModeBar = FALSE) %>%
    plotly::config(...)
  return(ggla_plotly)
}
