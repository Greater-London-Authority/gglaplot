#' @title ggla_plotly_settings
#' @description AAdds default ggla layout, style and config to a plotly plot
#' @param plot A plotly plot, created either using plot_ly or ggplotly.
#' @param gla_theme Either "default" or "inverse", Default: 'default'
#' @param x_axis_title boolean, If TRUE an x-axis label/title can be added, Default: FALSE
#' @param y_axis_title boolean, If TRUE a y-axis label/title can be added, Default: FALSE
#' @param xgridlines boolean, If TRUE, theme will include gridlines on the x-axis, Default: FALSE
#' @param legend boolean, If TRUE, theme will include a legend at the top left of the plot, Default: TRUE
#' @param base_size base font size, Default: 14
#' @param ... Other parameters passed to plotly::layout
#' @return A plotly plot
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname ggla_plotly_settings
#' @export
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
