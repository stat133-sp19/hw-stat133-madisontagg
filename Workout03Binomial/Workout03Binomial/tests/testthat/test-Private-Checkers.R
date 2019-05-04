# Title: Tests-Private-Checkers
# Author: Madison Tagg
# Date: April 26, 2019
# Description: Tests for Checker Functions

#Context of the test
context("Check Private Checker Functions")

test_that("Check check_prob", {
  expect_true(check_prob(.33))
  expect_type(check_prob(.44), "logical")
  expect_error(check_prob(1.3))
  expect_error(check_prob(-.2))
  expect_error(check_prob(c(.1,.2)))
})


test_that("Check check_trials", {
  expect_true(check_trials(2))
  expect_type(check_trials(6), "logical")
  expect_error(check_trials(.42))
  expect_error(check_trials(-5))
  expect_error(check_trials(0))
})


test_that("Check check_success", {
  expect_true(check_success(1, 2))
  expect_true(check_success(0, 2))
  expect_type(check_success(2, 2), "logical")
  expect_error(check_success(4, 2))
  expect_error(check_success(-2, 2))
  expect_error(check_success(2, -3))
})
