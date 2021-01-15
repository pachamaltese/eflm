test_that("Same AIC for glm and fglm with gaussian link", {
  m1 <- glm(mpg ~ wt + am, family = gaussian(), data = mtcars)
  m2 <- fglm(mpg ~ wt + am, family = gaussian(), data = mtcars)
  expect_equal(AIC(m1), AIC(m2))

  aic_m1_m2 <- AIC(m1, m2)
  expect_is(aic_m1_m2, 'data.frame')
  expect_equal(aic_m1_m2$df[1], aic_m1_m2$df[2])
  expect_equal(aic_m1_m2$AIC[1], aic_m1_m2$AIC[2])
})

test_that("Same AIC for glm and fglm with Gamma link", {
  m1 <- glm(mpg ~ wt + am, family = Gamma(), data = mtcars)
  m2 <- fglm(mpg ~ wt + am, family = Gamma(), data = mtcars)
  expect_equal(AIC(m1), AIC(m2))
})