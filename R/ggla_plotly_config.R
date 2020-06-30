ggla_plotly_config <- function(plot) {
  ggla_plotly <- plot %>%
    config(displayModeBar = FALSE)
  return(ggla_plotly)
}