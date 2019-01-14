context("ggla_donut plot")
p <- ggla_donut()
test_that("ggla_donut works", {
  expect_true("CoordPolar" %in% class(p[[1]][[2]]))
  expect_true("GeomRect" %in% class(p[[1]][[1]]$geom))
  expect_true("element_blank" %in% class(p[[1]][[3]]$panel.grid.major.y))
  expect_true("GeomText" %in% class(p[[2]]$geom))
})

