#' @name plotly_helpers
#' @title Plotly helpers
#' @description Helper functions to make it easier to automatically create plotly charts
#' @importFrom plotly to_basic
#' @export
to_basic.GeomGLALine <-
  utils::getFromNamespace("to_basic.GeomLine", asNamespace("plotly"))
