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
show_gla_pals <- function(gla_theme = "light", inc_div = FALSE) {

  # checks
  checkmate::assert_choice(gla_theme, choices = c("light", "dark"))
  checkmate::assert_logical(inc_div)

  theme_colours <- get(paste("gla", gla_theme, sep = "_"))
  background <- theme_colours$background
  textcol <- theme_colours$`body text`

  pal_list <- list()

  for (pal in c("core", "light", "dark", "brand")) {
    pal_list[[pal]] <- gla_pal(
      gla_theme = gla_theme,
      palette_type = "categorical",
      palette_name = pal,
      n = length(get(paste(pal, "order", sep = "_")))
    )
  }
  core_order <- gla_palette_colours %>%
    dplyr::filter(palette == "core") %>%
    dplyr::pull(colour)

  for (col in core_order) {
    pal_list[[col]] <- gla_pal(gla_theme = gla_theme,
                               palette_type = "quantitative",
                               palette_name = "core",
                               main_colours = col, n = length(core_order))
  }
  if (inc_div) {
    for (i in 1:floor(length(core_order) / 2)) {
      ii <- 2 * i - 1
      jj <- i * 2
      pair <- c(core_order[ii], core_order[jj])
      name <- paste(pair[1], "to", pair[2], sep = " ")
      pal_list[[name]] <- gla_pal(gla_theme = gla_theme,
                                  palette_type = "diverging",
                                  palette_name = "core",
                                  main_colours = pair, n = length(core_order))
    }
  }

  nr <- length(pal_list)
  nc <- pal_list %>%
    lapply(., length) %>%
    unlist() %>%
    max()
  ylim <- c(0, 1.4 * (nr + 1))
  graphics::par(bg = background)
  graphics::plot(1, 1, xlim = c(0, nc + 0.5), ylim = ylim, type = "n",
                 axes = FALSE, bty = "n", xlab = "", ylab = "")
  for (i in 1:nr) {
    j <- nr - i + 1

    pal <- unlist(pal_list[[j]])
    nj <- length(pal)
    name <- names(pal_list[j])

    graphics::rect(xleft = 0:(nj - 1), ybottom = 1.5 * i, xright = 1:(nj),
                   ytop = 1.5 * i - 0.7, col = pal, border = background)
    graphics::text(x = 0, y = 1.5 * i + 0.2, labels = name, col = textcol,
                   adj = c(0, -0.2))

  }

}
