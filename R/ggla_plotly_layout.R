ggla_plotly_layout <- function(plot, gla_theme = "default",
                        x_axis_title = FALSE, y_axis_title = FALSE,
                        xgridlines = FALSE, legend = TRUE,
                        base_size = 14,
                        annotations = NULL, ...) {
  colours <- get(paste0("gla_", gla_theme))
  
  # Text size
  title_size <- base_size * (18 / 14)
  label_size <- base_size * (12 / 14)
  axis_size <- base_size * (12 / 14)
  plot_margin <- base_size * (5 / 14)
  
  has_title <- !is.null(plot$x$layout$title$text)
  has_geom <- "geometry" %in% names(unname(plot$x$attrs)[[1]])
  
  
  ggla_plotly <- plot %>%
    plotly::layout(
      margin = list(t = plot_margin, b = plot_margin, r = plot_margin, l = plot_margin, pad = 0),
      plot_bgcolor = colours$background,
      paper_bgcolor = colours$background,
      font = list(
        color = colours$`body text`,
        family = "Arial",
        size = base_size),
      title = list(
        font = list(
          color = colours$headlines,
          family = "Arial",
          size = title_size),
        x = 0,
        xref = "container"),
      xaxis = list(
        domain = c(0, 1),
        automargin = TRUE,
        ticks = "",
        tickcolor = NA,
        ticklen = plot_margin,
        tickwidth = 0,
        showticklabels = TRUE,
        tickfont = list(
          color = colours$`axis text & labels`,
          family = "Arial",
          size = axis_size),
        tickangle = 0,
        showline = FALSE,
        linecolor = colours$`light grid`,
        linewidth = 2/3,
        showgrid = xgridlines,
        gridcolor = colours$`light grid`,
        gridwidth = 2/3,
        zeroline = FALSE,
        anchor = "y",
        title = list(
          font = list(
            color = colours$`axis text & labels`,
            family = "Arial",
            size = axis_size)),
        hoverformat = ".2f"),
      yaxis = list(
        domain = c(0, 1),
        automargin = TRUE,
        type = "linear",
        autorange = FALSE,
        tickmode = "array",
        nticks = NA,
        ticks = "outside",
        tickcolor = NA,
        ticklen = 0,
        tickwidth = 0,
        showticklabels = TRUE,
        tickfont = list(
          color = colours$`axis text & labels`,
          family = "Arial",
          size = axis_size),
        tickangle = 0,
        showline = FALSE,
        linecolor = NA,
        linewidth = 0,
        showgrid = TRUE,
        gridcolor = colours$`light grid`,
        gridwidth = 0.6224831,
        zeroline = FALSE,
        anchor = "x",
        title = list(
          font = list(
            color = colours$`axis text & labels`,
            family = "Arial",
            size = axis_size)),
        hoverformat = ".2f"),
      legend = list(
        bgcolor = colours$background,
        bordercolor = "transparent",
        borderwidth = 0,
        x = 0,
        y = 100,
        orientation = "h",
        xanchor = "left",
        yanchor = "bottom",
        font = list(
          color = colours$`body text`,
          family = "Arial",
          size = label_size)),
      showlegend = legend)
  
  if (has_title) {
    ggla_plotly <- ggla_plotly %>%
      layout(margin = list(t = 5 * title_size))
  }
  
  if (!x_axis_title) {
    ggla_plotly <- ggla_plotly %>%
      layout(xaxis = list(title = list(text = NULL)))
  }
  
  if (!y_axis_title) {
    ggla_plotly <- ggla_plotly %>%
      layout(yaxis = list(title = list(text = NULL)))
  }
  
  if (has_geom) {
    ggla_plotly <- ggla_plotly %>%
      layout(
        xaxis = list(
          showticklabels = FALSE,
          showgrid = FALSE),
        yaxis = list(
          showticklabels = FALSE,
          showgrid = FALSE)
      )
  }
  
  if (!is.null(annotations)) {
    default_annotations <- list(
      arrowhead = 0,
      bgcolor = colours$background,
      bordercolor = colours$background,
      borderpad = 0,
      borderwidth = 0,
      showarrow = TRUE,
      arrowcolor = colours$`axis text & labels`,
      startarrowhead = 0,
      arrowwidth = 1
      )
    default_font <- list(size = label_size,
                         family = "Arial",
                         color = colours$`axis text & labels`)
    annotations <- modifyList(default_annotations, annotations)
    if ("font" %in% names(annotations)) {
      annotations$font <- modifyList(default_font, annotations$font)
    } else {
      annotations$font <- default_font
    }
    ggla_plotly <- ggla_plotly %>%
      layout(annotations = annotations)
  }
  ggla_plotly <- ggla_plotly %>%
    layout(...)
  
  return(ggla_plotly)
}