#' @title gla_pal
#' @description Generates palettes using the GLA colours
#' @param gla_theme One of "default" or "inverse". Default: 'default'
#' @param n Number of colours in the palette. If palette_type = "Diverging", this is the number of colours on each side of the diverging scale . If palette_type = "Highlight" gla_pal will return main_colours + (n - length(main_colours)) context colours. Default: 6
#' @param palette_type One of "categorical", "quantitative", "highlight" or "diverging", Default: 'categorical'
#' @param palette_name One of the strings "core", "light", "dark", "brand", Default: 'core'
#' @param main_colours One or more of "blue", "pink", "green", "red", "yellow", "orange", "purple" or "mayoral" as a string or list, Default: 'mayoral'
#' @param inc0 boolean, If TRUE an additional colour representing zero will be added to a quantiative or diverging palettes, Default: FALSE
#' @details DETAILS
#' @return Returns a character vector of length n giving colour hexs.
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname gla_pal
#' @export
#' @import dplyr
#' @import checkmate
#' @importFrom tibble deframe
#' @importFrom chroma interp_palette
#' @param remove_margin Remove the edges of the palette to get a more central palette. Either 'left', 'right', 'both' or NULL, Default: NULL
#' @seealso
#'  \code{\link[chroma]{interp_scale}}
#' @importFrom tidyr gather
gla_pal <- function(gla_theme = "default", palette_type = "categorical",
                    palette_name = "core",
                    main_colours = NULL, n = 6,
                    inc0 = FALSE, remove_margin = NULL) {
  # initial set up
  gla_theme <- tolower(gla_theme)
  palette_type <- tolower(palette_type)
  palette_name <- tolower(palette_name)
  remove_left <- checkmate::test_subset(remove_margin, c("left", "both"),
                                        empty.ok = FALSE)
  remove_right <- checkmate::test_subset(remove_margin, c("right", "both"),
                                         empty.ok = FALSE)
  palette_types <- c("categorical", "quantitative", "highlight", "diverging")
  palette_names <- c("core", "light", "dark", "brand")

  # simple checks
  check <- checkmate::test_choice(gla_theme, choices = c("light", "dark"))
  if (check) {
    warning("The gla_themes have been renamed to default (light) and inverse (dark).")
    gla_theme <- ifelse(gla_theme == "light", "default", "inverse")
  }
  checkmate::assert_choice(gla_theme, choices = c("default", "inverse"))
  checkmate::assert_choice(palette_type, choices = palette_types)
  checkmate::assert_choice(palette_name, choices = palette_names)
  possible_colours <- gla_palette_colours %>%
    dplyr::filter(palette == palette_name) %>%
    dplyr::pull(colour)
  num_possible_colours <- length(possible_colours)
  check <- checkmate::test_null(main_colours)
  if (!check) {
    main_colours <- tolower(main_colours)
    checkmate::assert_subset(main_colours, possible_colours, empty.ok = TRUE)
  }
  checkmate::assert_choice(remove_margin, choices = c("right", "left", "both"),
                           null.ok = TRUE)
  checkmate::assert_logical(inc0)

  # conditional checks
  if (palette_type == "highlight") {
    checkmate::assert_integerish(n, len = 2, lower = 1)
    check <- checkmate::test_int(n[1], upper = num_possible_colours)
    if (!check) {
      warning(paste("For", palette_name, "highlight palettes only up to",
                    num_possible_colours, "highted colours will be returned"))
      sum_n <- sum(n)
      n <- c(num_possible_colours, sum_n - num_possible_colours)
    }
    if (!is.null(main_colours)) {
      if (n[1] < length(main_colours)) {
        warning(paste("Too many colours provided, only the first",
                      n[1], "will be used.", sep = " "))
      }
    }
  } else {
    checkmate::assert_count(n, positive = TRUE)
    if (palette_type == "quantitative") {
      check <- checkmate::test_character(palette_name, fixed = "core")
      if (!check) {
        stop("Diverging palettes only availabe for core palette")
      }
      check <- checkmate::check_character(main_colours, len = 1, null.ok = TRUE)
      if (!check) {
        warning(paste("For quantitative palettes main_colours",
                      tolower(check), "\n", "Only one colour will be used",
                      sep = " "))
        main_colours <- main_colours[1]
      }
    } else if (palette_type == "categorical") {
      check <- checkmate::test_int(n, upper = num_possible_colours)
      if (!check) {
        warning(paste("For", palette_name, "categorical palettes only up to",
                      num_possible_colours, "colours will be returned"))
        n <- num_possible_colours
      }
    } else if (palette_type == "diverging") {
      mod2 <- inc0 + remove_left + remove_right
      mod2 <- mod2 %% 2
      if (n %% 2 != mod2) {
        warning(paste0(
          "For this combination of inc0 and remove_margin n must be ",
          ifelse(mod2 == 0, "even", "odd"), ". Returning ",
          n + 1, " colours instead of ", n, "."))
        n <- n + 1
      }
      check <- checkmate::test_character(palette_name, fixed = "core")
      if (!check) {
        stop("Diverging palettes only availabe for core palette")
      }
      check <- checkmate::test_character(main_colours, len = 2, null.ok = TRUE)
      if (!check) {
        warning("For diverging palettes 2 colours will be used")
      }
    }
  }

  # Set up
  if (gla_theme == "default") {
    theme_colours <- gla_default
  } else {
    theme_colours <- gla_inverse
  }
  num_col <- list("categorical" = n,
                  "diverging" = 2,
                  "quantitative" = 1,
                  "highlight" = n[1])

  colours <- gla_palette_colours %>%
    dplyr::filter(palette == palette_name) %>%
    dplyr::select(-palette)
  if (!is.null(main_colours)) {
    pos <- 1
    colours <- colours %>%
      dplyr::mutate(order = NA)
    for (col in main_colours) {
      colours <- colours %>%
        dplyr::mutate(order = ifelse(colour == col, pos, order))
      pos <- pos + 1
    }
    colours <- colours %>%
      dplyr::arrange(order) %>%
      dplyr::select(-order)
  }
  colours <- colours %>%
    dplyr::filter(dplyr::row_number() <= num_col[[palette_type]])

  # Make palettes
  if (palette_type == "categorical") {
    pal <- colours %>%
      dplyr::pull(hex)

  } else if (palette_type == "quantitative") {
    pal_ends <- colours %>%
      dplyr::select(dark_end, hex, light_end) %>%
      tidyr::gather() %>%
      dplyr::pull(value)
    make_pal <- chroma::interp_palette(
      colors = pal_ends, model = "lab", interp = "bezier",
      correct.lightness = TRUE)
    n_each <- n + remove_left + remove_right
    if (inc0) {
      pal <- make_pal(n_each)
    } else {
      pal <- make_pal(n_each + 1)[- (n_each + 1)]
    }
    if (remove_left) {
      pal <- pal[-1]
    }
    if (remove_right) {
      if (inc0) {
        pal <- pal[- (length(pal) - 1)]
      } else {
        pal <- pal[-length(pal)]
      }
    }

  } else if (palette_type == "diverging") {
    mid_point <- theme_colours[["mid point"]]
    colours <- colours %>%
      dplyr::mutate(light_end = mid_point)
    pal_ends1 <- colours %>%
      dplyr::filter(dplyr::row_number() == 1) %>%
      dplyr::select(dark_end, hex, light_end) %>%
      tidyr::gather() %>%
      dplyr::pull(value)
    pal_ends2 <- colours %>%
      dplyr::filter(dplyr::row_number() == 2) %>%
      dplyr::select(light_end, hex, dark_end) %>%
      tidyr::gather() %>%
      dplyr::pull(value)
    n_each <- floor(n / 2) + 1
    if ((remove_left & remove_right) | ((remove_left | remove_right) & !inc0)) {
      n_each <- n_each + 1
    }
    make_pal1 <- chroma::interp_palette(
      colors = pal_ends1, model = "lab", interp = "bezier",
      correct.lightness = TRUE)
    if (remove_left) {
      pal1 <- make_pal1(n_each)[-1]
    } else {
      pal1 <- make_pal1(n_each)
    }
    make_pal2 <- chroma::interp_palette(
      colors = pal_ends2, model = "lab", interp = "bezier",
      correct.lightness = TRUE)
    if (remove_right){
      pal2 <- make_pal2(n_each)[-n_each]
    } else {
      pal2 <- make_pal2(n_each)
    }
    if (inc0) {
      pal <- c(pal1, pal2[-1])
    } else {
      pal <- c(pal1[-length(pal1)], pal2[-1])
    }

  } else if (palette_type == "highlight") {
    context <- theme_colours[["context data"]]
    pal <- colours %>%
      dplyr::pull(hex) %>%
      c(., rep(context, n[2]))
  }

  # Green & pink warning
  check1 <- checkmate::test_subset(c("#5ea15d", "#ee266d"), pal)
  check2 <- checkmate::test_subset(c("green", "ldnpink"), main_colours)
  if (check1 | check2) {
    warning(
      "Green and LDN Pink are not always easily differentiable -
      only use together if strictly necessary")
  }

  return(pal)

}
