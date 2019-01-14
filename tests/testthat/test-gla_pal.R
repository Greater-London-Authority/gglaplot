context("GLA palettes")

test_that("gla_pal returns a list of colours", {
  pal <- gla_pal(gla_theme = 'light')
  expect_match(pal, '^#[a-z0-9]{6}$')
  expect_is(pal, "character")
})

test_that("gla_pal takes colours from gla_light and gla_dark", {
  expect_true(all(gla_pal(gla_theme = "light", n = 7) %in% gla_light))
  expect_true(all(gla_pal(gla_theme = "dark", n = 7) %in% gla_dark))
})

test_that("gla_pal returns the correct number of colours", {
  expect_length(gla_pal(gla_theme = "light", palette_type = "categorical",
                        n = 5), 5)
  expect_length(gla_pal(gla_theme = "light", palette_type = "quantitative", 
                        n = 3), 3)
  expect_length(gla_pal(gla_theme = "light", palette_type = "highlight", 
                        main_colours = c("blue", "pink"), n = 6), 6)
  expect_length(gla_pal(gla_theme = "light", palette_type = "diverging", 
                        main_colours = c("red","green"), n = 3), 6)
  expect_length(gla_pal(gla_theme = "light", palette_type = "diverging", 
                        main_colours = c("red","green"), n = 3, inc0 = TRUE), 7)
})

test_that("gla_pal uses the right colours",{
  expect_equal(gla_pal(gla_theme = "light", palette_type = 'categorical', 
                       main_colours = 'blue', n = 1), gla_light$blue)
  expect_equal(gla_pal(gla_theme = "light", palette_type = 'categorical', 
                       main_colours = 'mayoral', n = 1), gla_light$mayoral)
  expect_equal(gla_pal(gla_theme = "dark", palette_type = 'categorical', 
                       main_colours = 'red', n = 1), gla_dark$red)
  expect_equal(gla_pal(gla_theme = "light", palette_type = 'categorical', 
                       main_colours = c('red','blue','green'), n = 3), 
               unlist(unname(gla_light[c('red','blue','green')])))
  
})

test_that("gla_pal can pick up muted colours", {
  expect_equal(gla_pal(gla_theme = "light", palette_type = "categorical", 
                       n = 4, muted = TRUE),
               unlist(unname(
                 gla_light[grep('muted', names(gla_light), value = TRUE)])))
})

test_that("gla_pal puts colours in the right places", {
  expect_equal(gla_pal(gla_theme = 'light', palette_type = "quantitative", 
                       main_colours = 'purple')[c(1,6)],
               toupper(unlist(unname(gla_light[c('purple', 'purple_end')]))))
  expect_equal(gla_pal(gla_theme = 'dark', palette_type = 'diverging', 
                       main_colours = c('blue','green'), n = 3)[c(1,6)],
               toupper(unlist(unname(gla_light[c('blue','green')]))))
  expect_equal(gla_pal(gla_theme = 'dark', palette_type = 'diverging', 
                       main_colours = c('blue','green'), 
                       n = 3, inc0 = TRUE)[c(1,4,7)],
               toupper(unlist(unname(gla_dark[c('blue','mid point','green')]))))
  expect_equal(gla_pal(gla_theme = "dark", palette_type = "highlight", 
                       main_colours = c("red","yellow", "green"), n = 6),
               unlist(unname(gla_dark[c("red", "yellow", "green", 
                                        "context data", "context data", 
                                        "context data")])))
  expect_equal(gla_pal(gla_theme = "light", palette_type = "categorical", 
                       main_colours = c("red", "blue", "green"), n = 3),
               unlist(unname(gla_light[c("red", "blue", "green")])))
  expect_equal(gla_pal(gla_theme = "light", palette_type = "categorical", 
                       main_colours = c("red", "blue", "green"), n = 4),
               unlist(unname(gla_light[c("red", "blue", "green")])))
})