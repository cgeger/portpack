#' Lists all the ports and their basic information
#'
#' @return A data frame with the following columns: port_number, port_border, port_name, port_crossing_name, port_hours, port_commercial_automation_type, port_commercial_max_lanes, port_passenger_automation_type, port_passenger_max_lanes, port_pedestrian_automation_type, port_pedestrian_max_lanes
#'
#' @import dplyr
#' @export
get_port_data <- function(){
  scrape_df <- scrape_ports()
  port_data <- scrape_df %>% select(starts_with("port"), -"port_status")
  return(port_data)
}
