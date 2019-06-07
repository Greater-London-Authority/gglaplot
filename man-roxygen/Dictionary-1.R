#' @param title String title to be used for plot. Will appear in the middle of the donut, Default: NULL
#' @param x_filt If filter_type = "xy" use this to select which x-values to highlight, Default: NULL
#' @param y_filt If filter_type= "xy" use this to select which y-values to highlight, Default: NULL
#' @param filter_type One of string "end", "start", "max", "min" or "xy", Default: "end"
#' @param inherit.aes If FALSE, overrides the default aesthetics, rather than combining with them. This is most useful for helper functions that define both data and aesthetics and shouldn't inherit behaviour from the default plot specification, e.g. borders(), Default: TRUE 
#' @param show.legend logical. Should this layer be included in the legends? NA, the default, includes if any aesthetics are mapped. FALSE never includes, and TRUE always includes. It can also be a named logical vector to finely select the aesthetics to display., Default: NA
#' @param na.rm If FALSE, the default, missing values are removed with a warning. If TRUE, missing values are silently removed, Default: FALSE
#' @param geom Override the default connection between geom_highlight() and GeomPointHighlight, Default: GeomPointHighlight
#' @param ymax higher y-extent of highlighted area, Default: Inf
#' @param ymin lower y-extent of highlighted area, Default: -Inf
#' @param xmax higher x-extent of highlighted area, Default: Inf
#' @param xmin lower x-extent of highlighted area, Default: -Inf
#' @param to100 boolean, If TRUE a context layer will be added below to bar chart up to 100, Default: FALSE
#' @param y2 final y-value, only needed lines which aren't perpedicular or parallel to axis, Default: NULL
#' @param x2 final x-value, only needed lines which aren't perpedicular or parallel to axis, Default: NULL
#' @param y1 starting y-value, not needed for lines perpendicular to y-axis, Default: NULL
#' @param x1 starting x-value, not needed for lines perpendicular to x-axis, Default: NULL
#' @param inc0 boolean, If TRUE an additional colour representing zero will be added to a quantitative or diverging palette. Default: FALSE
#' @param muted boolean, If TRUE a muted version of the gla colours will be used, Default: FALSE
#' @param n Number of colours in the palette. If palette_type = "highlight" n must have length 2, specifing the number of highlighted and contextual colours. Default: 6
#' @param main_colours One or more colours. If NULL default order will be used, Default: NULL
#' @param palette_type One of the strings "categorical", "quantitative", "highlight" or "diverging", Default: "categorical"
#' @param palette_name One of the strings "core", "ldn", "light" or "dark", Default: "core"
#' @param base_size base font size, Default: 14
#' @param xgridlines boolean, If TRUE, theme will include gridlines on the x-axis, Default: FALSE
#' @param legend boolean, If TRUE, theme will include a legend at the top left of the plot, Default: TRUE
#' @param inc_div boolean, If TRUE, output will include diverging colour palettes, Default: FALSE
#' @param data The data to be displayed in this layer. There are three options: If NULL, the default, the data is inherited from the plot data as specified in the call to ggplot(). A data.frame, or other object, will override the plot data. All objects will be fortified to produce a data frame. See fortify() for which variables will be created. A function will be called with a single argument, the plot data. The return value must be a data.frame, and will be used as the layer data, Default: NULL
#' @param mapping Set of aesthetic mappings created by aes() or aes_(). If specified and inherit.aes = TRUE (the default), it is combined with the default mapping at the top level of the plot. You must supply mapping if there is no plot mapping, Default: NULL
#' @param gla_theme Either "default" or "inverse", Default: "default"