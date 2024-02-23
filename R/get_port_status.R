#' gets the current status for each port
#'
#' @return a dataframe with the current status for each port
#' @import dplyr
#' @import tidyr
#' @import tidyselect
#' @importFrom rlang .data
#' @export
get_port_status <- function(){
  scrape <- scrape_ports()
  (port_status <- scrape %>%
    select(.data$port_number, starts_with("commercial"),
           starts_with("passenger"),
           starts_with("pedestrian")) %>%
    pivot_longer(cols = c(starts_with("commercial"),
                          starts_with("passenger"),
                          starts_with("pedestrian")), names_to = "lane_type") %>%
    filter(!.data$value %in% c("", "N/A")) %>%
    separate(.data$lane_type, into = c("modality", "lane_type", "observation"), sep = "\\.") %>%
    pivot_wider(names_from = "observation", values_from = "value") %>% as.data.frame())
  return(port_status)
}
