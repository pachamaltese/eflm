test_that("gaussian summary is equivalent to glm", {
  m1 <- summary(glm(mpg ~ wt, family = gaussian(), data = mtcars))
  m2 <- summary(eglm(mpg ~ wt, family = gaussian(), data = mtcars))
  em1 <- round(as.data.frame(m1$coefficients), 4)
  em2 <- as.data.frame(m2$coefficients)
  em2$`Pr(>|t|)` <- as.numeric(em2$`Pr(>|t|)`)
  em2 <- round(em2, 4)
  expect_equal(m1$call$formula, m2$call$formula)
  expect_equal(m1$call$family, m2$call$family)
  expect_equal(m1$call$data, m2$call$data)
  expect_equal(m1$terms, m2$terms)
  expect_equal(m1$deviance, m2$deviance)
  expect_equal(m1$aic, m2$aic)
  expect_equal(m1$df.residual, m2$df.residual)
  expect_equal(m1$df.null, m2$df.null)
  expect_equal(m1$null.deviance, m2$null.deviance)
  expect_gte(m1$iter, m2$iter)
  expect_equal(m1$deviance.resid, m2$deviance.resid)
  expect_equal(m1$dispersion, m2$dispersion)
  expect_equal(m1$cov.unscaled, m2$cov.unscaled)
  expect_equal(m1$cov.scaled, m2$cov.scaled)
  expect_equal(em1$Estimate, em2$Estimate)
  expect_equal(em1$`Std. Error`, em2$`Std. Error`)
  expect_equal(em1$`t value`, em2$`t value`)
  expect_equal(em1$`Pr(>|t|)`, em2$`Pr(>|t|)`)
})

test_that("inverse.gaussian summary is equivalent to glm", {
  m1 <- summary(glm(mpg ~ wt, family = inverse.gaussian(), data = mtcars))
  m2 <- summary(eglm(mpg ~ wt, family = inverse.gaussian(), data = mtcars))
  em1 <- round(as.data.frame(m1$coefficients), 4)
  em2 <- as.data.frame(m2$coefficients)
  em2$`Pr(>|t|)` <- as.numeric(em2$`Pr(>|t|)`)
  em2 <- round(em2, 4)
  expect_equal(m1$call$formula, m2$call$formula)
  expect_equal(m1$call$family, m2$call$family)
  expect_equal(m1$call$data, m2$call$data)
  expect_equal(m1$terms, m2$terms)
  expect_equal(m1$deviance, m2$deviance)
  expect_equal(m1$aic, m2$aic)
  expect_equal(m1$df.residual, m2$df.residual)
  expect_equal(m1$df.null, m2$df.null)
  expect_equal(m1$null.deviance, m2$null.deviance)
  expect_gte(m1$iter, m2$iter)
  expect_equal(m1$deviance.resid, m2$deviance.resid)
  expect_equal(m1$dispersion, m2$dispersion)
  expect_equal(m1$cov.unscaled, m2$cov.unscaled)
  expect_equal(m1$cov.scaled, m2$cov.scaled)
  expect_equal(em1$Estimate, em2$Estimate)
  expect_equal(em1$`Std. Error`, em2$`Std. Error`)
  expect_equal(em1$`t value`, em2$`t value`)
  expect_equal(em1$`Pr(>|t|)`, em2$`Pr(>|t|)`)
})

test_that("binomial summary is equivalent to glm", {
  m1 <- summary(glm(am ~ mpg, family = binomial(), data = mtcars))
  m2 <- summary(eglm(am ~ mpg, family = binomial(), data = mtcars))
  em1 <- round(as.data.frame(m1$coefficients), 4)
  em2 <- round(as.data.frame(m2$coefficients), 4)
  expect_equal(m1$call$formula, m2$call$formula)
  expect_equal(m1$call$family, m2$call$family)
  expect_equal(m1$call$data, m2$call$data)
  expect_equal(m1$terms, m2$terms)
  expect_equal(m1$deviance, m2$deviance)
  expect_equal(m1$aic, m2$aic)
  expect_equal(m1$df.residual, m2$df.residual)
  expect_equal(m1$df.null, m2$df.null)
  expect_equal(m1$null.deviance, m2$null.deviance)
  expect_gte(m1$iter, m2$iter)
  expect_equal(m1$deviance.resid, m2$deviance.resid)
  expect_equal(m1$dispersion, m2$dispersion)
  expect_equal(m1$cov.unscaled, m2$cov.unscaled)
  expect_equal(m1$cov.scaled, m2$cov.scaled)
  expect_equal(em1$Estimate, em2$Estimate)
  expect_equal(em1$`Std. Error`, em2$`Std. Error`)
  expect_equal(em1$`z value`, em2$`z value`)
  expect_equal(em1$`Pr(>|z|)`, em2$`Pr(>|z|)`)
})

test_that("quasi-binomial summary is equivalent to glm", {
  m1 <- summary(glm(am ~ mpg, family = quasibinomial(), data = mtcars))
  m2 <- summary(eglm(am ~ mpg, family = quasibinomial(), data = mtcars))
  em1 <- round(as.data.frame(m1$coefficients), 4)
  em2 <- round(as.data.frame(m2$coefficients), 4)
  expect_equal(m1$call$formula, m2$call$formula)
  expect_equal(m1$call$family, m2$call$family)
  expect_equal(m1$call$data, m2$call$data)
  expect_equal(m1$terms, m2$terms)
  expect_equal(m1$deviance, m2$deviance)
  expect_equal(m1$aic, m2$aic)
  expect_equal(m1$df.residual, m2$df.residual)
  expect_equal(m1$df.null, m2$df.null)
  expect_equal(m1$null.deviance, m2$null.deviance)
  expect_gte(m1$iter, m2$iter)
  expect_equal(m1$deviance.resid, m2$deviance.resid)
  expect_equal(m1$dispersion, m2$dispersion)
  expect_equal(m1$cov.unscaled, m2$cov.unscaled)
  expect_equal(m1$cov.scaled, m2$cov.scaled)
  expect_equal(em1$Estimate, em2$Estimate)
  expect_equal(em1$`Std. Error`, em2$`Std. Error`)
  expect_equal(em1$`z value`, em2$`z value`)
  expect_equal(em1$`Pr(>|z|)`, em2$`Pr(>|z|)`)
})

test_that("poisson summary is equivalent to glm", {
  m1 <- summary(glm(am ~ mpg, family = poisson(), data = mtcars))
  m2 <- summary(eglm(am ~ mpg, family = poisson(), data = mtcars))
  em1 <- round(as.data.frame(m1$coefficients), 4)
  em2 <- round(as.data.frame(m2$coefficients), 4)
  expect_equal(m1$call$formula, m2$call$formula)
  expect_equal(m1$call$family, m2$call$family)
  expect_equal(m1$call$data, m2$call$data)
  expect_equal(m1$terms, m2$terms)
  expect_equal(m1$deviance, m2$deviance)
  expect_equal(m1$aic, m2$aic)
  expect_equal(m1$df.residual, m2$df.residual)
  expect_equal(m1$df.null, m2$df.null)
  expect_equal(m1$null.deviance, m2$null.deviance)
  expect_gte(m1$iter, m2$iter)
  expect_equal(m1$deviance.resid, m2$deviance.resid)
  expect_equal(m1$dispersion, m2$dispersion)
  expect_equal(m1$cov.unscaled, m2$cov.unscaled)
  expect_equal(m1$cov.scaled, m2$cov.scaled)
  expect_equal(em1$Estimate, em2$Estimate)
  expect_equal(em1$`Std. Error`, em2$`Std. Error`)
  expect_equal(em1$`z value`, em2$`z value`)
  expect_equal(em1$`Pr(>|z|)`, em2$`Pr(>|z|)`)
})

test_that("quasi-poisson summary is equivalent to glm", {
  m1 <- summary(glm(am ~ mpg, family = quasipoisson(), data = mtcars))
  m2 <- summary(eglm(am ~ mpg, family = quasipoisson(), data = mtcars))
  em1 <- round(as.data.frame(m1$coefficients), 4)
  em2 <- round(as.data.frame(m2$coefficients), 4)
  expect_equal(m1$call$formula, m2$call$formula)
  expect_equal(m1$call$family, m2$call$family)
  expect_equal(m1$call$data, m2$call$data)
  expect_equal(m1$terms, m2$terms)
  expect_equal(m1$deviance, m2$deviance)
  expect_equal(m1$aic, m2$aic)
  expect_equal(m1$df.residual, m2$df.residual)
  expect_equal(m1$df.null, m2$df.null)
  expect_equal(m1$null.deviance, m2$null.deviance)
  expect_gte(m1$iter, m2$iter)
  expect_equal(m1$deviance.resid, m2$deviance.resid)
  expect_equal(m1$dispersion, m2$dispersion)
  expect_equal(m1$cov.unscaled, m2$cov.unscaled)
  expect_equal(m1$cov.scaled, m2$cov.scaled)
  expect_equal(em1$Estimate, em2$Estimate)
  expect_equal(em1$`Std. Error`, em2$`Std. Error`)
  expect_equal(em1$`z value`, em2$`z value`)
  expect_equal(em1$`Pr(>|z|)`, em2$`Pr(>|z|)`)
})

test_that("quasi summary is equivalent to glm", {
  m1 <- summary(glm(am ~ mpg, family = quasi(), data = mtcars))
  m2 <- summary(eglm(am ~ mpg, family = quasi(), data = mtcars))
  em1 <- round(as.data.frame(m1$coefficients), 4)
  em2 <- round(as.data.frame(m2$coefficients), 4)
  expect_equal(m1$call$formula, m2$call$formula)
  expect_equal(m1$call$family, m2$call$family)
  expect_equal(m1$call$data, m2$call$data)
  expect_equal(m1$terms, m2$terms)
  expect_equal(m1$deviance, m2$deviance)
  expect_equal(m1$aic, m2$aic)
  expect_equal(m1$df.residual, m2$df.residual)
  expect_equal(m1$df.null, m2$df.null)
  expect_equal(m1$null.deviance, m2$null.deviance)
  expect_gte(m1$iter, m2$iter)
  expect_equal(m1$deviance.resid, m2$deviance.resid)
  expect_equal(m1$dispersion, m2$dispersion)
  expect_equal(m1$cov.unscaled, m2$cov.unscaled)
  expect_equal(m1$cov.scaled, m2$cov.scaled)
  expect_equal(em1$Estimate, em2$Estimate)
  expect_equal(em1$`Std. Error`, em2$`Std. Error`)
  expect_equal(em1$`z value`, em2$`z value`)
  expect_equal(em1$`Pr(>|z|)`, em2$`Pr(>|z|)`)
})
