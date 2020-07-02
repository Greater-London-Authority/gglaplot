ggla_plotly_settings <- function(plot, gla_theme = "default",
                                 x_axis_title = FALSE, y_axis_title = FALSE,
                                 xgridlines = FALSE, legend = TRUE,
                                 base_size = 14, ...) {


  ggla_plotly <- plot %>%
    ggla_plotly_layout(gla_theme = gla_theme,
                       x_axis_title = x_axis_title, y_axis_title = y_axis_title,
                       xgridlines = xgridlines, legend = legend,
                       base_size = base_size, ...) %>%
    ggla_plotly_style(gla_theme = gla_theme, base_size = base_size) %>%
    ggla_plotly_config()

  return(ggla_plotly)
}
