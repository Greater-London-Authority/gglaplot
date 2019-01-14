#' @title theme_gla
#' @description Controls the non-data display to be consistent with our style guide
#' @param gla_theme Either 'light' or 'dark', Default: 'light'
#' @param xgridlines boolean, If TRUE, theme will include gridlines on the x-axis, Default: FALSE
#' @param legend boolean, If TRUE, theme will include a legend at the top left of the plot, Default: TRUE
#' @param base_size base font size, Default: 14
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
#' @import ggplot2
theme_gla <- function(gla_theme = 'light', xgridlines = FALSE, legend = TRUE,
                      base_size = 14) {
  
  # checks
  checkmate::assert_choice(gla_theme, choices = c('light', 'dark'))
  checkmate::assert_logical(xgridlines)
  checkmate::assert_logical(legend)
  checkmate::assert_number(base_size, lower = 0)
  
  if (gla_theme=='light') {
    colours <- gla_light
  } else if (gla_theme=='dark') {
    colours <- gla_dark
  } else {
    stop("Invalid gla_theme. Theme must be 'light' or 'dark'")
  }
  
  title_size = base_size * (30/26)
  label_size = base_size * (20/26)
  axis_size = base_size * (16/26)
  plot_margin = base_size * (5/14)

  theme_gla <- ggplot2::theme_bw(base_size = base_size) +
    
    #background
    ggplot2::theme(
      panel.background = ggplot2::element_rect(fill = colours$background),
      plot.margin = ggplot2::margin(plot_margin, plot_margin, 
                                    plot_margin, plot_margin, "pt"),
      plot.background = ggplot2::element_rect(fill = colours$background),
      panel.border = ggplot2::element_blank(),
      
      
      #text and title
      text = ggplot2::element_text(colour = colours$`body text`, 
                                   family = 'sans', hjust = 0),
      plot.title = ggplot2::element_text(colour = colours$headlines, 
                                         family = 'sans', hjust = 0, 
                                         face = 'bold', size = title_size),
      plot.subtitle = ggplot2::element_text(colour = colours$headlines, 
                                            family = 'sans', hjust = 0),
      plot.caption = ggplot2::element_text(colour = colours$`body text`, 
                                           family = 'sans', hjust = 0, 
                                           size = label_size),
    
      
      #axis and gridlines
      panel.grid = ggplot2::element_blank(),
      panel.grid.major.y = ggplot2::element_line(size = 1 * mm_to_pt, 
                                                 colour = colours$`light grid`),
      axis.title = ggplot2::element_blank(),
      axis.ticks.x = ggplot2::element_blank(),
      axis.ticks.y = ggplot2::element_blank(),
      axis.text = ggplot2::element_text(colour = colours$`body text`, 
                                        family = 'sans',
                                        hjust = 0.5, size = axis_size),
      axis.text.y = ggplot2::element_text(
        hjust = 0, vjust = -1,
        margin = margin(t = 0, r = - 5 * plot_margin, b = 0 , l = plot_margin/2, 
                        unit = 'pt')),
      
      #legend
      legend.background = ggplot2::element_rect(fill = colours$background),
      legend.key =  ggplot2::element_rect(fill = colours$background),
      legend.position = 'top', legend.justification = c(0, 0),
      legend.title = ggplot2::element_blank(),
      legend.text = ggplot2::element_text(
        vjust = 0.5, size = label_size,
        margin = ggplot2::margin(t = 0, r = plot_margin, b = plot_margin / 2,
                                 l = plot_margin / 2, unit = 'pt')),
      
      #facets
      strip.background = ggplot2::element_blank(),
      strip.text = ggplot2::element_text(colour = colours$`body text`,
                                         vjust=-1, hjust=0.05))
  
  if (xgridlines) {

    theme_gla <- theme_gla +
      ggplot2::theme(panel.grid.major.x = ggplot2::element_line(
        size = 1, colour =  colours$`light grid`))
  }
  
  if (legend == FALSE) {

    theme_gla <- theme_gla +
      ggplot2::theme(legend.position = 'none')
  }
  return(theme_gla)
}

