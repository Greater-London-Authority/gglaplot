ggla_plotly_style <- function(plot, gla_theme = "default", base_size = 14, ...) {
  
  colours <- get(paste0("gla_", gla_theme))
  label_size <- base_size * (12 / 14)
  
  ggla_plot <- plot %>%
    style(
      hoverlabel = list(bgcolor = colours$headlines,
                        bordercolor = colours$headlines,
                        font = list(family = "Arial",
                                    color = colours$background,
                                    size = label_size)),
      hoveron = "fill") %>%
    style(...)
  
  return(ggla_plot)
}