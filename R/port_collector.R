## code to prepare `port_collector` dataset goes here
#' collects current port status
#'
#' @param db_name name of the database (default: "portpack.db")
#' @export
port_collector <- function(db_name = "portpack.db") {

  #get the dataset
  port_status <- get_port_status()

  con <- DBI::dbConnect(RSQLite::SQLite(), paste0("inst/extdata/", db_name))
  DBI::dbWriteTable(con, "port_status", port_status, append = TRUE)
  DBI::dbDisconnect(con)

  filename <- c("data/current_port_status.rda")
  save(port_status, file = filename)

  now <- Sys.time()
  timestamp <- format(now, "%Y-%B-%d_%H-%M-%S")
  filename <- paste0("inst/extdata/","ports_statuses_at_", timestamp, ".rda")
  save(port_status, file = filename)
}
