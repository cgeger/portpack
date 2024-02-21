test_that("port scrape is stable", {
  expect_equal(dim(scrape_ports()), c(81, 44), info = "scrape_ports() should return a dataframe with 81 rows and 44 columns to reflect port configurations as of Feb 20, 2024")
})
