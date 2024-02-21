test_that("port counts and config stable", {
  expect_s3_class(get_port_data(), "data.frame")
  expect_equal(dim(get_port_data()), c(81, 11), info = "get_port_data() should return a data frame with 81 rows and 11 columns")
})
