#' initialize port data database
#'
#' @param db_name
#' @export
portpackdb <- function(db_name = "portpack.db") {
  con <- DBI::dbConnect(RSQLite::SQLite(), paste0("inst/extdata/", db_name))

  port_data <- get_port_data()
  DBI::dbWriteTable(con, "port_data", port_data, overwrite = TRUE)
  DBI::dbDisconnect(con)
}
