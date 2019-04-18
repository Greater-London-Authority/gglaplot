#' @title gla_pal
#' @description Generates palettes using the GLA colours
#' @param gla_theme One of "light" or "dark". If NULL will try to pick up current theme, or default to light, Default: NULL
#' @param palette_type One of "categorical", "quantitative", "highlight" or "diverging", Default: 'categorical'
#' @param main_colours One or more of "blue", "pink", "green", "red", "yellow", "orange", "purple" or "mayoral" as a string or list, Default: 'mayoral'
#' @param n Number of colours in the palette. If palette_type = "Diverging", this is the number of colours on each side of the diverging scale . If palette_type = "Highlight" gla_pal will return main_colours + (n - length(main_colours)) context colours. Default: 6
#' @param inc0 boolean, If TRUE an additional colour representing zero will be added to a quantiative or diverging palettes, Default: FALSE
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
                    palette_name = "core",
                    main_colours = NULL, n = 6,
                    inc0 = FALSE) {

  gla_theme <- ifelse(is.null(gla_theme), NULL, tolower(gla_theme))
  palette_type <- tolower(palette_type)
  palette_name <- tolower(palette_name)

  palette_types <- c("categorical", "quantitative", "highlight", "diverging")
  palette_names <- c("core", "ldn", "light", "dark")

  # simple checks
  checkmate::assert_choice(gla_theme, choices = c("light", "dark"),
                           null.ok = TRUE)
  checkmate::assert_choice(palette_type, choices = palette_types)
  checkmate::assert_choice(palette_name, choices = palette_names)
  if (palette_name == "ldn") {
    possible_colours <- gla_palette_colours %>%
      filter(palette == "core") %>%
      pull(colour)
  } else {
    possible_colours <- gla_palette_colours %>%
      filter(palette == palette_name) %>%
      pull(colour)
  }
  num_possible_colours <- length(possible_colours)
  check <- checkmate::test_null(main_colours)
  if (!check) {
    main_colours <- tolower(main_colours)
    checkmate::assert_subset(main_colours, possible_colours, empty.ok = TRUE)
    if (palette_type %in% c("categorical", "highlight")) {
      warning("Specifing main_colours will overwrite default colour order")
    }

  }
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
    if (!is.null(main_colours) & n[1] != length(main_colours)) {
      warning(paste("n[1] and length(main_colours) do not agree.",
                    "Using n =", n[1], "colours in default order from",
                    palette_name,
                    "palette", sep = " "))
      main_colours <- NULL
    }
  } else {
    checkmate::assert_count(n, positive = TRUE)
    if (palette_type == "quantitative") {
      check <- checkmate::test_character(palette_name, pattern = "core|ldn")
      if (!check) {
        stop("Diverging palettes only availabe for core or ldn palettes")
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
      if (inc0 & n %% 2 == 0) {
        stop("Divering palettes with inc0 = TRUE must have odd n")
      } else if (!inc0 & n %% 2 == 1) {
        stop("Diverging palettes with inc0 = FALSE must have even n")
      }
      check <- checkmate::test_subset(palette_name, choices = c("core", "ldn"))
      if (!check) {
        stop("Diverging palettes only availabe for core or ldn palettes")
      }
      check <- checkmate::test_character(main_colours, len = 2, null.ok = TRUE)
      if (!check) {
        warning("For diverging palettes 2 colours will be used")
        if (length(main_colours) == 1) {
          main_colours <- NULL
        } else {
          main_colours <- main_colours[1:2]
        }
      }
    }
  }



  # Set up

  if (is.null(gla_theme)) {
    theme_colours <- try(get_theme_colours(), silent = TRUE)
    if (!is.list(colours)) {
      theme_colours <- gla_light
    }
    gla_theme <- ifelse(theme_colours$background == "#ffffff", "light", "dark")
  } else if (gla_theme == "light") {
    theme_colours <- gla_light
  } else if (gla_theme == "dark") {
    theme_colours <- gla_dark
  }

  if (is.null(main_colours)) {
    num_col <- list("categorical" = n,
                    "diverging" = 2,
                    "quantitative" = 1,
                    "highlight" = n[1])

    main_colours <- get(
      paste(palette_name, "order", sep = "_")
    )[1:num_col[[palette_type]]]
  }
  if (palette_name == "ldn") {
    colours <- gla_palette_colours %>%
      filter(palette == "core") %>%
      select(colour, hex) %>%
      deframe() %>%
      as.list()
  } else {
    colours <- gla_palette_colours %>%
      filter(palette == palette_name) %>%
      select(colour, hex) %>%
      deframe() %>%
      as.list()
  }

  colours <- colours[main_colours] %>%
    unname() %>%
    unlist()

  pal_end <- theme_colours$background




  # Make palettes

  if (palette_type == "categorical") {
    pal <- colours

  } else if (palette_type == "quantitative") {

    pal_ends <- c(colours, pal_end)
    makepal <- grDevices::colorRampPalette(pal_ends, space = "rgb",
                                           interpolate = "linear")
    if (inc0) {
      pal <- makepal(n)
    } else {
      pal <- makepal(n + 1)[1:n]
    }

  } else if (palette_type == "diverging") {
    col1 <- colours[1]
    col2 <- colours[2]
    n_each <- floor(n / 2) + 1
    makepal1 <- grDevices::colorRampPalette(c(col1, pal_end), space = "rgb",
                                            interpolate = "linear")
    pal1 <- makepal1(n_each)
    makepal2 <- grDevices::colorRampPalette(c(pal_end, col2), space = "rgb",
                                            interpolate = "linear")
    pal2 <- makepal2(n_each)
    if (inc0) {
      pal <- c(pal1, pal2[2:n_each])
    } else {
      pal <- c(pal1[1:(n_each - 1)], pal2[2:n_each])
    }
  } else if (palette_type == "highlight") {
    context <- theme_colours[["context data"]]

    pal <- c(colours, rep(context, n[2]))

  }

  return(pal)

}
