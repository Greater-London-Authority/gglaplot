context("GLA theme")

test_that("theme_gla works", {
  expect_is(theme_gla(), "theme")
})

test_that("theme_gla can be light or dark",{
  light <- theme_gla(gla_theme = 'light')
  dark <- theme_gla(gla_theme = 'dark')
  expect_identical(light$panel.background$fill, gla_light$background)
  expect_identical(dark$panel.background$fill, gla_dark$background)
})

test_that("x-gridlines can be added", {
  withgrid <- theme_gla(xgridlines = TRUE)
  expect_identical(withgrid$panel.grid.major.x$colour, gla_light$`light grid`)
})

test_that("legend can be removed", {
  withoutlegend <- theme_gla(legend = FALSE)
  expect_identical(withoutlegend$legend.position, 'none')
})

test_that("font size can be adjusted", {
  bigtext <- theme_gla(base_size = 20)
  expect_equal(bigtext$plot.title$size, 20 * (30/26))
  expect_equal(bigtext$plot.subtitle$size, 20)
  expect_equal(bigtext$plot.caption$size, 20 * (20/26))
  expect_equal(bigtext$axis.text$size, 20 * (16/26))
})

