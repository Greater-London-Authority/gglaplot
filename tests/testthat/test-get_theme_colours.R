context("Get current colours")

test_that("gla_pal returns a list of gla colours", {
  theme_set(theme_gla(gla_theme = 'light'))
  colours <- get_theme_colours()
  expect_identical(colours, gla_light)
  theme_set(theme_gla(gla_theme = 'dark'))
  colours <- get_theme_colours()
  expect_identical(colours, gla_dark)
})