gglaplotly <- function(plot, ...) {
  
  # Get plot into
  plot_layers <- sapply(plot$layers, function(x) class(x$geom)[1])
  plot_title <- plot$labels$title
  has_legend <- !is.null(cowplot::get_legend(plot))
  
  if ("GeomSf" %in% plot_layers) {
    plot <- plot +
      theme(axis.text.x = element_blank(),
            axis.text.y = element_blank(),
            panel.grid = element_blank())
  }
  
  plotl <- plotly::ggplotly(plot, ...) %>%
    layout(
      xaxis = list(tickfont = list(family = "Arial")),
      yaxis = list(tickfont = list(family = "Arial")),
      
      margin = list(l = 0, r = 0, b = 0,
                    t = 0,
                    pad = 0)) %>%
    style(
      hoverlabel = list(bgcolor = plot$theme$text$colour,
                        bordercolor = plot$theme$text$colour,
                        font = list(family = "Arial",
                                    color = plot$theme$plot.background$colour)),
      hoveron = "fill") %>%
    config(displayModeBar = FALSE)
  if (has_legend) {
    plotl <- plotl %>%
      layout(legend = list(orientation = "h", x = 0, y = 100,
                           xanchor = "left", yanchor = "bottom",
                           font = list(family = "Arial")))
  } else {
    plotl <- plotl %>%
      layout(showlegend = FALSE)
  }
  if (!is.null(plot_title)) {
    plotl <- plotl %>%
      layout(
        title = list(text = plot_title,
                     font = list(family = "Arial", 
                                 color = plot$theme$plot.title$colour),
                     x = 0, y = 100,
                     xref = "container", yref = "container"),
        margin = list(t = plot$theme$plot.title$size * 4.5))
  }
  return(plotl)
}