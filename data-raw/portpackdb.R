#' initialize port data database
#'
portpackdb <- function(name = "portpack.db") {
  con <- DBI::dbConnect(RSQLite::SQLite(), paste0("data/", name))

  port_data <- get_port_data()
  DBI::dbWriteTable(con, "port_data", port_data, overwrite = TRUE)
  DBI::dbDisconnect(con)
}

portpackdb()
