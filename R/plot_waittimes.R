#' A histogram plot comparing all wait times to a selected one
#'
#' @param selected_port a port id number
#' @param mod the modality of interest
#' @param ln_typ the lane type of interest
#' @import ggplot2
#' @import tidyr
#' @import dplyr
#' @importFrom rlang .data
#' @return a plot
#' @export
plot_waittimes <- function(selected_port = "535503", mod = "passenger", ln_typ = "ready"){
  load("data/current_port_status.rda")
  selected_wait <- port_status %>% filter(.data$port_number == selected_port &
                                          .data$modality == mod &
                                          .data$lane_type == ln_typ) %>%
    drop_na() %>% select(.data$delay_minutes) %>% unlist()

    p <- port_status %>%
    drop_na() %>% filter(.data$modality == mod) %>%
    ggplot(aes(x = .data$delay_minutes)) +
    geom_histogram(stat = "bin",  binwidth = 5, alpha = 0.6)+
    geom_vline(xintercept = selected_wait, color = "red")+
    xlab("current delay in minutes at all ports") +
    ylab("")+
    theme(axis.line = element_line(colour = "black"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          panel.background = element_blank(),
          axis.line.y = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks.y = element_blank()) +
    annotate("text",label = paste0("Port: ", selected_port), x = selected_wait+6, y = 10, color = "red")

  return(p)
}
