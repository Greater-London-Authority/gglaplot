#' @title left_align_labs
#' @description Left aligns titles, subtitles and captions to the left of the whole plot (default is to left align to just the plot area)
#' @param plot ggplot2 object
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname left_align_labs
#' @export 
#' @import ggplot2
#' @importFrom ggplotify as.ggplot
#' @seealso 
#'  \code{\link[ggplot2]{is.ggplot}},\code{\link[ggplot2]{ggplotGrob}}
#'  \code{\link[ggplotify]{as.ggplot}}
left_align_labs <- function(plot) {
  #checks
  if (ggplot2::is.ggplot(plot) == FALSE) {
    stop(
      "plot must be a ggplot object. If using %>% after a summation of ggplot
      functions, remember to use an extra set of brackets around the whole
      ggplot object."
    )
  }

  grob <- ggplot2::ggplotGrob(plot)
  grob$layout$l[grob$layout$name == "title"] <- 1
  grob$layout$l[grob$layout$name == "subtitle"] <- 1
  grob$layout$l[grob$layout$name == "caption"] <- 1
  plot <- ggplotify::as.ggplot(grob)

  return(plot)

  }
