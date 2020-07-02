ggla_plotly_config <- function(plot, ...) {
  ggla_plotly <- plot %>%
    config(displayModeBar = FALSE) %>%
    config(...)
  return(ggla_plotly)
}
