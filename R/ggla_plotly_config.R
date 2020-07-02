ggla_plotly_config <- function(plot, ...) {
  ggla_plotly <- plot %>%
    plotly::config(displayModeBar = FALSE) %>%
    plotly::config(...)
  return(ggla_plotly)
}
