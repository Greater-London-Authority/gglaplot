#' @title theme_gla
#' @description Controls the non-data display to be consistent with our style guide
#' @param gla_theme Either 'default' or 'inverse', Default: 'default'
#' @param x_axis_title boolean, If TRUE an x-axis label/title can be added, Default: FALSE
#' @param y_axis_title boolean, If TRUE a y-axis label/title can be added, Default: FALSE
#' @param xgridlines boolean, If TRUE, theme will include gridlines on the x-axis, Default: FALSE
#' @param legend boolean, If TRUE, theme will include a legend at the top left of the plot, Default: TRUE
#' @param base_size base font size, Default: 14
#' @param y_label_length length of lines under y-axis labels. For most plots this won't need changing.
#' It will need adjusting for faceted plots or if labels are particularly long.
#' As a rough guide this should be set approximately equal to 96 * strwidth(y_labels, unit = "inches") with default base_size.
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname theme_gla
#' @export 
#' @import checkmate
theme_gla <- function(gla_theme = "default",
                      x_axis_title = FALSE, y_axis_title = FALSE,
                      xgridlines = FALSE, legend = TRUE,
                      base_size = 14, y_label_length = 100) {

  # checks
  check <- checkmate::test_choice(gla_theme, choices = c("light", "dark"))
  if (check) {
    warning("The gla_themes have been renamed to default (light) and inverse (dark).")
    gla_theme <- ifelse(gla_theme == "light", "default", "inverse")
  }
  checkmate::assert_choice(gla_theme, choices = c("default", "inverse"))
  checkmate::assert_logical(x_axis_title)
  checkmate::assert_logical(y_axis_title)
  checkmate::assert_logical(xgridlines)
  checkmate::assert_logical(legend)
  checkmate::assert_number(base_size, lower = 0)
  
  colours <- get(paste0("gla_", gla_theme))

  # Text size
  title_size <- base_size * (18 / 14)
  label_size <- base_size * (12 / 14)
  axis_size <- base_size * (12 / 14)
  plot_margin <- base_size * (5 / 14)

  # Define theme
  theme_gla <- ggplot2::theme_bw(base_size = base_size) +

    # background
    ggplot2::theme(
      panel.background = ggplot2::element_rect(fill = colours$background),
      plot.margin = ggplot2::margin(t = 2 * plot_margin, r = plot_margin,
                                    b = plot_margin, l = plot_margin,
                                    unit =  "pt"),
      plot.background = ggplot2::element_rect(fill = colours$background),
      panel.border = ggplot2::element_blank(),

      # text and title
      text = ggplot2::element_text(colour = colours$`body text`,
                                   family = "sans", hjust = 0),
      plot.title.position = "plot",
      plot.title = ggplot2::element_text(colour = colours$headlines,
                                         family = "sans", hjust = 0,
                                         face = "bold", size = title_size,
                                         margin = margin(t = 0,
                                                         r = 0,
                                                         b = 0,
                                                         l = 0,
                                                         unit = "pt")),
      plot.subtitle = ggplot2::element_text(colour = colours$headlines,
                                            family = "sans", hjust = 0,
                                            size = base_size,
                                            margin = margin(t = 0,
                                                            r = 0,
                                                            b = 1.5 * plot_margin,
                                                            l = 0,
                                                            unit = "pt")),
      plot.caption = ggplot2::element_text(colour = colours$`body text`,
                                           family = "sans", hjust = 0,
                                           size = label_size),
      plot.caption.position = "plot",

      # axis and gridlines
      panel.grid.major.y = ggplot2::element_line(size = 1 * mm_to_pt,
                                                 colour = colours$`light grid`),
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      axis.ticks.x = ggplot2::element_blank(),
      axis.ticks.y = ggplot2::element_line(size = 1 * mm_to_pt,
                                           colour = colours$`light grid`),
      axis.ticks.length.y = ggplot2::unit(y_label_length, units = "pt"),
      axis.text = ggplot2::element_text(colour = colours$`body text`,
                                        family = "sans",
                                        hjust = 0.5, size = axis_size),
      axis.text.y = ggplot2::element_text(
        hjust = 0, vjust = -0.5,
        margin = ggplot2::margin(
          t = 0, r = -y_label_length, b = 0, l = 0,
          unit = "pt")),

      # legend
      legend.background = ggplot2::element_rect(fill = colours$background),
      legend.key =  ggplot2::element_rect(fill = colours$background),
      legend.position = "top",
      legend.justification = "left",
      legend.title = ggplot2::element_blank(),
      legend.text = ggplot2::element_text(
        vjust = 0.5, size = label_size,
        margin = ggplot2::margin(t = 0, r = plot_margin, b = plot_margin / 2,
                                 l = plot_margin / 2, unit = "pt")),
      legend.margin = margin(t = 0, r = 0,
                             l = 0, b = 0, unit = "pt"),

      # facets
      strip.background = ggplot2::element_blank(),
      strip.text = ggplot2::element_text(colour = colours$`body text`,
                                         vjust = -1, hjust = 0.05))

  # axis titles
  if (x_axis_title == FALSE) {
    theme_gla <- theme_gla +
      ggplot2::theme(axis.title.x = ggplot2::element_blank())
  } else {
    theme_gla <- theme_gla +
      ggplot2::theme(
        axis.title.x = ggplot2::element_text(
          colour = colours$`body text`, family = "sans", hjust = 0.5,
          size = label_size,
          margin = ggplot2::margin(2 * plot_margin, 0, plot_margin, 0, "pt"))
        )
  }
    if (y_axis_title == FALSE) {
      theme_gla <- theme_gla +
        ggplot2::theme(axis.title.y = ggplot2::element_blank())
    } else {
      theme_gla <- theme_gla +
        ggplot2::theme(
          axis.title.y = ggplot2::element_text(
            colour = colours$`body text`, family = "sans", hjust = 0.5,
            size = label_size,
            margin = ggplot2::margin(0, 2 * plot_margin, 0, plot_margin, "pt"))
          )
  }

  # x-axis gridlines
  if (xgridlines) {
    theme_gla <- theme_gla +
      ggplot2::theme(panel.grid.major.x = ggplot2::element_line(
        size = 1 * mm_to_pt, colour =  colours$`light grid`))
  }

  # legend
  if (legend == FALSE) {
    theme_gla <- theme_gla +
      ggplot2::theme(legend.position = "none")
  }

  return(theme_gla)

}
