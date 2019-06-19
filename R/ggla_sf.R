# These functions have been adapted from ggplot2/R/geom_sf to use gla themes
# and colours
#' @export
GeomGLASf <- ggplot2::ggproto("GeomGLASf", ggplot2::GeomSf,
                     required_aes = "geometry",
                     default_aes = ggplot2::aes(
                       shape = NULL,
                       colour = NULL,
                       fill = NULL,
                       size = NULL,
                       linetype = 1,
                       alpha = NA,
                       stroke = 0.5
                     ),

                     draw_panel = function(data, panel_params, coord,
                                           legend = NULL, lineend = "butt",
                                           linejoin = "round", linemitre = 10) {
                       if (!inherits(coord, "CoordSf")) {
                         stop("geom_sf() must be used with coord_sf()",
                              call. = FALSE)
                       }

                       coord <- coord$transform(data, panel_params)
                       sf_gla_grob(coord, lineend = lineend,
                                   linejoin = linejoin, linemitre = linemitre)
                     },

                     draw_key = function(data, params, size) {
                       data <- ggplot2:::modify_list(
                         default_gla_aesthetics(params$legend), data)
                       if (params$legend == "point") {
                         ggplot2::draw_key_point(data, params, size)
                       } else if (params$legend == "line") {
                         ggplot2::draw_key_path(data, params, size)
                       } else {
                         ggplot2::draw_key_polygon(data, params, size)
                       }
                     }
)


#' @import ggplot2
default_gla_aesthetics <- function(type) {
  if (ggplot2::theme_get()$panel.background$fill == gla_inverse$background) {
    gla_theme <- gla_inverse
  } else {
    gla_theme <- gla_default
  }
  if (type == "point") {
    ggplot2:::modify_list(GeomPoint$default_aes, list(
      colour = gla_colours$blue_core,
      size = 3 * mm_to_pt))
  } else if (type == "line") {
    ggplot2:::modify_list(GeomGLALine$default_aes, list(
      colour = gla_colours$blue_core,
      size = 3 * mm_to_pt))
  } else  {
    ggplot2:::modify_list(GeomPolygon$default_aes, list(
      fill = gla_theme$`mid point`,
      colour = gla_theme$background))
  }
}

# %||% is from rlang
#' @import ggplot2
#' @importFrom rlang %||%
#' @importFrom sf st_geometry_type st_as_grob
#' @importFrom stats setNames
#' @importFrom grid gpar
sf_gla_grob <- function(x, lineend = "butt", linejoin = "round",
                        linemitre = 10) {
  if (ggplot2::theme_get()$panel.background$fill == gla_inverse$background) {
    gla_theme <- gla_inverse
  } else {
    gla_theme <- gla_default
  }
  # Need to extract geometry out of corresponding list column
  geometry <- x$geometry
  type <- ggplot2:::sf_types[sf::st_geometry_type(geometry)]
  is_point <- type %in% "point"
  type_ind <- match(type, c("point", "line", "other"))
  defaults <- list(
    ggplot2:::modify_list(GeomPoint$default_aes, list(
      colour = gla_colours$blue_core,
      size = 3 * mm_to_pt)),
    ggplot2:::modify_list(GeomGLALine$default_aes, list(
      colour = gla_colours$blue_core,
      size = 3 * mm_to_pt)),
    ggplot2:::modify_list(GeomPolygon$default_aes, list(
      fill = gla_theme$`mid point`,
      colour = gla_theme$background))
  )
  default_names <- unique(unlist(lapply(defaults, names)))
  defaults <- lapply(stats::setNames(default_names, default_names), function(n) {
    unlist(lapply(defaults, function(def) def[[n]] %||% NA))
  })
  alpha <- x$alpha %||% defaults$alpha[type_ind]
  col <- x$colour %||% defaults$colour[type_ind]
  col[is_point] <- ggplot2::alpha(col[is_point], alpha[is_point])
  fill <- x$fill %||% defaults$fill[type_ind]
  fill <- ggplot2::alpha(fill, alpha)
  size <- x$size %||% defaults$size[type_ind]
  stroke <- (x$stroke %||% defaults$stroke[1]) * .stroke / 2
  fontsize <- size * .pt + stroke
  lwd <- ifelse(is_point, stroke, size * .pt)
  pch <- x$shape %||% defaults$shape[type_ind]
  lty <- x$linetype %||% defaults$linetype[type_ind]
  gp <- grid::gpar(
    col = col, fill = fill, fontsize = fontsize, lwd = lwd, lty = lty,
    lineend = lineend, linejoin = linejoin, linemitre = linemitre
  )
  sf::st_as_grob(geometry, pch = pch, gp = gp)
}

#' @title ggla_sf
#' @description Wrapper for ggplot2::geom_sf simplyfying coordinates and appearance
#' @inheritParams ggplot2::geom_point
#' @details To use gla_inverse theme this must be set using theme_set() prior to calling ggla_sf()
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname ggla_sf
#' @export 
#' @import ggplot2
ggla_sf <- function(mapping = ggplot2::aes(), data = NULL, stat = "sf",
                    position = "identity", na.rm = FALSE, show.legend = NA,
                    inherit.aes = TRUE, ...) {
  c(
    ggplot2::layer_sf(
      geom = GeomGLASf,
      data = data,
      mapping = mapping,
      stat = stat,
      position = position,
      show.legend = if (is.character(show.legend)) TRUE else show.legend,
      inherit.aes = inherit.aes,
      params = list(
        na.rm = na.rm,
        legend = if (is.character(show.legend)) show.legend else "polygon",
        ...
      )
    ),
    ggplot2::coord_sf(default = TRUE, datum = NA)
  )
}
