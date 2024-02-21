#' Scrape current status of US-Canada border crossings
#'
#' @param xml_url A character vector with one element, the URL of the XML file (default as of 2/20/2024: "https://bwt.cbp.gov/xml/bwt.xml")
#'
#' @return A data frame with one row per port and one column per attribute from the raw xml dataset
#' @importFrom xml2 read_xml xml_find_all xml_text
#' @export scrape_ports
scrape_ports <- function(xml_url = "https://bwt.cbp.gov/xml/bwt.xml"){

  #download port xml data from CBP
  scraped_xml <- read_xml(xml_url)
  port_nodes <- xml_find_all(scraped_xml, xpath = "port")

  scrape_df <- data.frame(
    ####scrape data####
    scrape_datetime = Sys.time(),
    scrape_xml_date = xml_text(xml_find_all(port_nodes, xpath = "//date")),
    scrape_update_date = xml_text(xml_find_all(scraped_xml, xpath = "last_updated_date")),
    scrape_update_time = xml_text(xml_find_all(scraped_xml, xpath = "last_updated_time")),

    ####port data####
    port_number = xml_text(xml_find_all(port_nodes, xpath = "//port_number")),
    port_border =  xml_text(xml_find_all(port_nodes, xpath = "//border")),
    port_name = xml_text(xml_find_all(port_nodes, xpath = "//port_name")),
    port_crossing_name = xml_text(xml_find_all(port_nodes, xpath = "//crossing_name")),
    port_hours = xml_text(xml_find_all(port_nodes, xpath = "//hours")),
    port_status = xml_text(xml_find_all(port_nodes, xpath = "//port_status")),

    ####commercial lanes####
    port_commercial_automation_type = xml_text(xml_find_all(port_nodes, xpath = "//commercial_automation_type")),
    port_commercial_max_lanes = xml_text(xml_find_all(port_nodes, xpath = "//commercial_vehicle_lanes/maximum_lanes")),
    #standard
    commercial.standard.update_time = xml_text(xml_find_all(port_nodes, xpath = "//commercial_vehicle_lanes/standard_lanes/update_time")),
    commercial.standard.operational_status = xml_text(xml_find_all(port_nodes, xpath = "//commercial_vehicle_lanes/standard_lanes/operational_status")),
    commercial.standard.delay_minutes = xml_text(xml_find_all(port_nodes, xpath = "//commercial_vehicle_lanes/standard_lanes/delay_minutes")),
    commercial.standard.lanes_open = xml_text(xml_find_all(port_nodes, xpath = "//commercial_vehicle_lanes/standard_lanes/lanes_open")),
    #FAST
    commercial.FAST.update_time = xml_text(xml_find_all(port_nodes, xpath = "//commercial_vehicle_lanes/FAST_lanes/update_time")),
    commercial.FAST.operational_status = xml_text(xml_find_all(port_nodes, xpath = "//commercial_vehicle_lanes/FAST_lanes/operational_status")),
    commercial.FAST.delay_minutes = xml_text(xml_find_all(port_nodes, xpath = "//commercial_vehicle_lanes/FAST_lanes/delay_minutes")),
    commercial.FAST.lanes_open = xml_text(xml_find_all(port_nodes, xpath = "//commercial_vehicle_lanes/FAST_lanes/lanes_open")),

    ####passenger####
    port_passenger_automation_type = xml_text(xml_find_all(port_nodes, xpath = "//passenger_automation_type")),
    port_passenger_max_lanes = xml_text(xml_find_all(port_nodes, xpath = "//passenger_vehicle_lanes/maximum_lanes")),
    #standard lanes
    passenger.standard.update_time = xml_text(xml_find_all(port_nodes, xpath = "//passenger_vehicle_lanes/standard_lanes/update_time")),
    passenger.standard.operational_status = xml_text(xml_find_all(port_nodes, xpath = "//passenger_vehicle_lanes/standard_lanes/operational_status")),
    passenger.standard.delay_minutes = xml_text(xml_find_all(port_nodes, xpath = "//passenger_vehicle_lanes/standard_lanes/delay_minutes")),
    passenger.standard.lanes_open = xml_text(xml_find_all(port_nodes, xpath = "//passenger_vehicle_lanes/standard_lanes/lanes_open")),
    #NEXUS_SENTRI lanes
    passenger.NEXUS_SENTRI.update_time = xml_text(xml_find_all(port_nodes, xpath = "//passenger_vehicle_lanes/NEXUS_SENTRI_lanes/update_time")),
    passenger.NEXUS_SENTRI.operational_status = xml_text(xml_find_all(port_nodes, xpath = "//passenger_vehicle_lanes/NEXUS_SENTRI_lanes/operational_status")),
    passenger.NEXUS_SENTRI.delay_minutes = xml_text(xml_find_all(port_nodes, xpath = "//passenger_vehicle_lanes/NEXUS_SENTRI_lanes/delay_minutes")),
    passenger.NEXUS_SENTRI.lanes_open = xml_text(xml_find_all(port_nodes, xpath = "//passenger_vehicle_lanes/NEXUS_SENTRI_lanes/lanes_open")),
    #ready lanes
    passenger.ready.update_time = xml_text(xml_find_all(port_nodes, xpath = "//passenger_vehicle_lanes/ready_lanes/update_time")),
    passenger.ready.operational_status = xml_text(xml_find_all(port_nodes, xpath = "//passenger_vehicle_lanes/ready_lanes/operational_status")),
    passenger.ready.delay_minutes = xml_text(xml_find_all(port_nodes, xpath = "//passenger_vehicle_lanes/ready_lanes/delay_minutes")),
    passenger.ready.lanes_open = xml_text(xml_find_all(port_nodes, xpath = "//passenger_vehicle_lanes/ready_lanes/lanes_open")),

    ####pedestrian####
    port_pedestrian_automation_type = xml_text(xml_find_all(port_nodes, xpath = "//pedestrain_automation_type")),
    port_pedestrian_max_lanes = xml_text(xml_find_all(port_nodes, xpath = "//pedestrian_lanes/maximum_lanes")),
    #standard
    pedestrian.standard.update_time = xml_text(xml_find_all(port_nodes, xpath = "//pedestrian_lanes/standard_lanes/update_time")),
    pedestrian.standard.operational_status = xml_text(xml_find_all(port_nodes, xpath = "//pedestrian_lanes/standard_lanes/operational_status")),
    pedestrian.standard.delay_minutes = xml_text(xml_find_all(port_nodes, xpath = "//pedestrian_lanes/standard_lanes/delay_minutes")),
    pedestrian.standard.lanes_open = xml_text(xml_find_all(port_nodes, xpath = "//pedestrian_lanes/standard_lanes/lanes_open")),
    #ready
    pedestrian.ready.update_time = xml_text(xml_find_all(port_nodes, xpath = "//pedestrian_lanes/ready_lanes/update_time")),
    pedestrian.ready.operational_status = xml_text(xml_find_all(port_nodes, xpath = "//pedestrian_lanes/ready_lanes/operational_status")),
    pedestrian.ready.delay_minutes = xml_text(xml_find_all(port_nodes, xpath = "//pedestrian_lanes/ready_lanes/delay_minutes")),
    pedestrian.ready.lanes_open = xml_text(xml_find_all(port_nodes, xpath = "//pedestrian_lanes/ready_lanes/lanes_open"))
  )
  return(scrape_df)
}
