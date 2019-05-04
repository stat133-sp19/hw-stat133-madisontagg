# Title: Tests-Binomial
# Author: Madison Tagg
# Date: April 26, 2019
# Description: Tests for Main Binomial Functions

#Context of the test
context("Check Binomial Functions")

test_that("Check bin_choose", {
  expect_equal(45, bin_choose(10, 2))
  expect_equal(56, bin_choose(8, 3))
  expect_error(bin_choose(9, 11))
  expect_error(bin_choose(2, 5))
  expect_error(bin_choose(2, -3))
})

test_that("Check bin_probability", {
  expect_equal(0.01611328, bin_probability(10, 12, .5))
  expect_equal(0.3105375, bin_probability(2, 4, .35))
  expect_error(bin_probability(5, 1, .05))
  expect_error(bin_probability(4, 3.9, .77))
  expect_error(bin_probability(5,-2,0.5))
  expect_error(bin_probability(-5,2,0.5))
})

test_that("Check bin_distribution", {
  expect_type(bin_distribution(10, .3), "list")
  expect_length(bin_distribution(15, .23), 2)
  expect_error(bin_distribution(15, 3))
  expect_error(bin_distribution(-5, .43))
  expect_error(bin_distribution(15, 3, .2))
})

test_that("Check bin_cumulative", {
  expect_type(bin_cumulative(3, .45), "list")
  expect_length(bin_cumulative(12, .07), 3)
  expect_error(bin_cumulative(4, -.24))
  expect_error(bin_cumulative(4, 1, .24))
})
