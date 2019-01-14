context("Axis at 0")

test_that("ggla_axisat0 works", {
  p <- ggla_axisat0()
  expect_true('GeomHline' %in% class(p$geom))
  expect_equal(p$data$yintercept,0)
  expect_equal(p$aes_params$colour, gla_light$`strong grid`)
})
