## code to prepare `port_list` dataset goes here
#' collect list of all ports
#'
#' @param db_name name of the database (default: "portpack.db")
#' @export
port_list_collector <- function(db_name = "portpack.db") {

  #get the dataset
  port_list <- get_port_data()

  con <- DBI::dbConnect(RSQLite::SQLite(), paste0("inst/extdata/", db_name))
  DBI::dbWriteTable(con, "port_list", port_list, overwrite = TRUE)
  DBI::dbDisconnect(con)

  filename <- c("data/current_port_list.rda")
  save(port_list, file = filename)
  }
