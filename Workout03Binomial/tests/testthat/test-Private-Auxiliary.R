# Title: Tests-Private-Auxiliary
# Author: Madison Tagg
# Date: April 26, 2019
# Description: Tests for Private Auxiliary Functions

#Context of the test
context("Check Private Auxiliary Functions")

test_that("Check aux_mean", {
  expect_equal(aux_mean(11, .55), 6.05)
  expect_equal(aux_mean(9, .210), 1.89)
  expect_false(aux_mean(4, .99) == 4)
  expect_error(aux_mean(-4, 1))
})


test_that("Check aux_variance", {
  expect_equal(aux_variance(3, 0.5), 0.75)
  expect_equal(aux_variance(3, 0), 0)
  expect_equal(aux_variance(0, .35), 0)
  expect_error(aux_variance(-10, .15))
  expect_error(aux_variance(10, -.55))
})


test_that("Check aux_mode", {
  expect_equal(aux_mode(3, 0.5), c(2, 1))
  expect_match(typeof(aux_mode(10,.2)), "integer")
  expect_equal(aux_mode(0, .3), 0)
  expect_error(aux_mode(-1, .15))
  expect_error(aux_mode(10, -.9))
  expect_error(aux_mode(11, 2))
})


test_that("Check aux_skewness", {
  expect_equal(aux_skewness(5, 0.5), 0)
  expect_match(typeof(aux_skewness(4, .15)), "double")
  expect_equal(aux_skewness(0, .3), Inf)
  expect_error(aux_skewness(-23, .3))
  expect_error(aux_skewness(3, -.9))
  expect_error(aux_skewness(3, 1.9))
})


test_that("Check aux_kurtosis", {
  expect_equal(aux_kurtosis(8, .19), 0.06221572)
  expect_match(typeof(aux_kurtosis(4, .2)), "double")
  expect_equal(aux_kurtosis(13, 1), Inf)
  expect_error(aux_kurtosis(5, -.6))
  expect_equal(aux_kurtosis(8.2, 1), Inf)
  expect_error(aux_kurtosis(8.2, -.5))
})

