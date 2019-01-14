#' @title gla_pal
#' @description Generates palettes using the GLA colours
#' @param gla_theme One of "light" or "dark". If NULL will try to pick up current theme, or default to light, Default: NULL
#' @param palette_type One of "categorical", "quantitative", "highlight" or "diverging", Default: 'categorical'
#' @param main_colours One or more of "blue", "pink", "green", "red", "yellow", "orange", "purple" or "mayoral" as a string or list, Default: 'mayoral'
#' @param n Number of colours in the palette. If palette_type = "Diverging", this is the number of colours on each side of the diverging scale (so 2n (+1) colours in total will be returned). If palette_type = "Highlight" gla_pal will return main_colours + (n - length(main_colours)) context colours. Default: 6
#' @param muted boolean, If TRUE a muted version of the gla colours will be used, Default: FALSE
#' @param inc0 boolean, If TRUE an additional colour representing zero will be added to a diverging palette. This results in a palette of length 2n + 1, Default: FALSE
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  \code{\link[grDevices]{colorRamp}}
#' @rdname gla_pal
#' @export 
#' @import dplyr 
#' @import checkmate
#' @importFrom grDevices colorRampPalette
gla_pal <- function(gla_theme = NULL, palette_type = "categorical", 
                    main_colours = "mayoral", n = 6, muted = FALSE,
                    inc0 = FALSE) {
  
  main_colours <- tolower(main_colours)
  gla_theme <- tolower(gla_theme)
  palette_type <- tolower(palette_type)
  possible_colours <- gla_colours %>%
    dplyr::filter(endOfPaletteHex != '') %>%
    dplyr::pull(Colour) %>%
    unique()
  
  muted_colours = gla_colours %>%
    dplyr::filter(Muted==TRUE) %>%
    dplyr::pull(Colour) %>%
    unique() 
  
  possible_palettes = c('categorical','quantitative','highlight','diverging')
  
  # simple checks
  checkmate::assert_choice(gla_theme, choices = c('light','dark'), 
                           null.ok = TRUE)
  checkmate::assert_choice(palette_type, 
                           choices = possible_palettes)
  checkmate::assert_subset(main_colours, possible_colours, empty.ok = FALSE)
  checkmate::assert_count(n, positive = TRUE)
  checkmate::assert_logical(muted)
  checkmate::assert_logical(inc0)
  
  # conditional checks
  
  if (palette_type == 'quantitative') {
    check = checkmate::check_character(main_colours, len = 1)
    if (check != TRUE) {
      error_message = paste('For quantitative palettes main_colours', 
                            tolower(check), sep = ' ')
      stop(error_message)
    }
    if (muted == TRUE) {
      stop('quantitative palettes not available for muted colours')
    }
  } else if (palette_type == 'categorical') {
    if (muted == FALSE) {
      check = checkmate::check_int(n, upper = length(possible_colours))
      if (check != TRUE) {
        error_message = paste('For unmuted, categorical palettes',
                              gsub('All elements', 'n', check),
                              sep = ' ')
        stop(error_message)
      }
    } else if (muted == TRUE) {
      check = checkmate::check_int(n, upper = length(muted_colours))
      if (check != TRUE) {
        error_message = paste('For muted, categorical palettes',
                              gsub('All elements', 'n', check),
                              sep = ' ')
        stop(error_message)
      }
    }
  } else if (palette_type == 'diverging') {
    if (muted == TRUE) {
      stop('diverging palettes not available for muted colours')
    }
  }
  
  if (muted == TRUE) {
    if (checkmate::test_choice(main_colours, choices = 'mayoral') == FALSE) {
      check = checkmate::check_subset(main_colours, muted_colours, 
                                      empty.ok = FALSE)
      if (check != TRUE) {
        error_message <- paste('For muted palettes, main_colours',
                               tolower(check), sep = ' ')
        stop(error_message)
      }
    }
  }
  
  # Set up
  
  if (is.null(gla_theme)) {
    colours <-try(get_theme_colours(), silent = TRUE)
    if (!is.list(colours)) {
      colours <- gla_light
    }
    gla_theme=ifelse(colours$background=='#ffffff', 'light', 'dark')
  } else if (gla_theme=='light') {
    colours <- gla_light
  } else if (gla_theme=='dark') {
    colours <- gla_dark
  }
  
  mc = main_colours %>%
    unlist() %>%
    c()
  
  # Make palettes
  
  if (palette_type=='categorical') {
    if (length(main_colours)!=n) {
      mc = possible_colours
    }
    if (muted==FALSE) {
      if (length(main_colours)!=n) {
        mc = possible_colours
      }
      pal = colours[mc] %>%
        unname() %>%
        unlist()
    } else {
      if (length(main_colours)!=n) {
        mc = muted_colours
      }
      pal = colours[paste(mc, 'muted', sep = '_')] %>%
        unname() %>%
        unlist()
    }
    if (n<7) { 
      pal = pal[1:n]
    }
    
  } else if (palette_type == 'quantitative') {
    palends = c(colours[mc], colours[paste(mc, 'end', sep = '_')])
    makepal = grDevices::colorRampPalette(palends, space = 'rgb', 
                                          interpolate = 'linear')
    pal = makepal(n)
    
  } else if (palette_type=='diverging'){
    mid = colours$`mid point`
    col1 = colours[main_colours[1]]
    col2 = colours[main_colours[2]]
    makepal1 = grDevices::colorRampPalette(c(col1, mid), space = 'rgb', 
                                           interpolate = 'linear')
    pal1 = makepal1(n + 1)
    makepal2 = grDevices::colorRampPalette(c(mid, col2), space = 'rgb', 
                                           interpolate = 'linear')
    pal2 = makepal2(n + 1)
    if (inc0==TRUE) {
      pal = append(pal1, pal2[2:(n + 1)])
    } else {
      pal = append(pal1[1:n], pal2[2:(n+1)])
    }
    
  } else if (palette_type=='highlight') {
    context = colours$`context data`
    if (muted==FALSE) {
      pal = colours[mc] %>%
        unname() %>%
        unlist()
    } else {
      pal = colours[paste(mc, 'muted', sep = '_')] %>%
        unname() %>%
        unlist()
    }
    pal <- c(pal,rep(context, n-length(mc)))
  }
  
  return(pal)
}

