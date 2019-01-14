#' @title show_gla_pals
#' @description Display the available GLA palettes
#' @param gla_theme One of 'light' or 'dark', Default: 'light'
#' @param inc_div boolean, If TRUE, output will include diverging colour palettes, Default: FALSE
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname show_gla_pals
#' @export 
#' @import checkmate 
#' @import dplyr
#' @import graphics
show_gla_pals <- function(gla_theme = 'light', inc_div = FALSE) {
  
  # checks
  checkmate::assert_choice(gla_theme, choices = c('light', 'dark'))
  checkmate::assert_logical(inc_div)
  
  colours = gla_colours %>%
    dplyr::filter(Theme==gla_theme)
  background = colours %>%
    dplyr::filter(Colour=='background') %>%
    dplyr::pull(Hex)
  textcol = colours %>%
    dplyr::filter(Colour == 'body text') %>%
    dplyr::pull(Hex)
  pal_list = list()
  
  pal_list[['categorical']] = gla_pal(gla_theme = gla_theme, 
                                      palette_type = 'categorical', n = 7)
  
  pal_list[['muted']] = gla_pal(gla_theme = gla_theme, 
                                palette_type = 'categorical', n = 4,
                                muted = TRUE)
  
  chartcols =  colours %>%
    dplyr::filter(endOfPaletteHex != '') %>%
    dplyr::pull(Colour) %>%
    unique()
  
  for (col in chartcols) {
    pal_list[[col]] = gla_pal(gla_theme = gla_theme, 
                              palette_type = 'quantitative', main_colours = col)
  }
  if (inc_div==TRUE) {
    for (pair in list(c('blue','green'), c('red','green'), c('red','blue'),
                      c('red','yellow'))) {
      name = paste(pair[1], 'to', pair[2], sep=' ')
      pal_list[[name]] = gla_pal(gla_theme = gla_theme, 
                                 palette_type = 'diverging', 
                                 main_colours = pair, n = 5)
    } 
  }
  
  nr = length(pal_list)
  nc = pal_list %>%
    lapply(., length) %>%
    unlist() %>%
    max()
  ylim = c(0, 1.4 * (nr + 1))
  graphics::par(bg = background)
  graphics::plot(1, 1, xlim = c(0, nc + 0.5), ylim = ylim, type = "n", 
                 axes = FALSE, bty = "n", xlab = "", ylab = "")
  for (i in 1:nr) {
    j = nr - i + 1
    
    pal = unlist(pal_list[[j]])
    nj = length(pal)
    name = names(pal_list[j])
    
    graphics::rect(xleft = 0:(nj - 1), ybottom = 1.5 * i, xright = 1:(nj), 
                   ytop = 1.5 * i - 0.7, col = pal, border=background)
    graphics::text(x = 0, y = 1.5 * i + 0.2, labels = name, col = textcol,
                   adj = c(0, -0.2))
    
  }
  
}
