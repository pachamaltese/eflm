#' Fitting Generalized Linear Models
#'
#' eglm is used to fit generalized linear models in an equivalent way to
#' \code{glm} but in a reduced time depending on the design matrix (see the
#' DESCRIPTION).
#'
#' @param formula A formula for the model
#' @param data A tibble or data.frame
#' @param family See the function \link{glm}, but here it must be specified with brackets (e.g. \code{quasipoisson()})
#' @param intercept Logical value to determine wheareas to included an intercept in the null model (Defaults to \code{TRUE})
#' @param weights An optional vector of ‘prior weights’ to be used in the fitting process. Should be \code{NULL}
#' or a numeric vector (e.g. \code{data$weights}, defaults to \code{NULL})
#' @param na.action a function which indicates what should happen when the data
#' contain NAs. The default is set by the \code{na.action} setting of options,
#' and is \link{na.fail} if that is unset. The ‘factory-fresh’ default is
#' \code{na.omit}. Another possible value is NULL, no action. Value
#' \code{na.exclude} can be useful.
#' @param start Starting values for the parameters in the linear predictor
#' @param etastart Starting values for the linear predictor
#' @param mustart Starting values for the vector of means
#' @param offset This can be used to specify an a priori known component to be included in the
#' linear predictor during fitting. This should be \code{NULL} or a numeric vector of length
#' equal to the number of cases. One or more offset terms can be included in the formula instead
#' or as well, and if more than one is specified their sum is used. See \code{stats::model.offset()}
#' @param maxit See the function \link{glm}
#' @param k The penalty per parameter to be used, the default \code{k = 2}
#' is the classical AIC
#' @param model A logical value indicating whether model frame should be included as a
#' component of the returned value (Defaults to \code{TRUE})
#' @param singularity.method The chosen method to detect for singularity. Defaults to \code{"eigen"} but
#' it can also be \code{"Cholesky"} or \code{"qr"}
#' @param x Logical value indicating whether the model matrix used in the fitting process
#' should be returned as components of the returned value (Defaults to \code{FALSE}, see the function \link{glm.fit})
#' @param y Logical value indicating whether the response vector used in the fitting process
#' should be returned as components of the returned value (Defaults to \code{FALSE}, see the function \link{glm.fit})
#' @param tol.estimation Tolerance to be used for the estimation (Defaults to 1e-8)
#' @param tol.solve (Defaults to \code{.Machine$double.eps}, see the function \link{solve})
#' @param tol.values Tolerance to consider eigenvalues equal to zero (Defaults to 1e-7, see the function \link{control}),
#' @param tol.vectors Tolerance to consider eigenvectors equal to zero (Defaults to 1e-7, see the function \link{control})
#' @param \dots For eglm: arguments to be used to form the default control argument if it is not supplied directly. For weights: further arguments passed to or from other methods.
#' @return An object of class "eglm" that behaves the same way as the "glm" class, see the function \link{glm}.
#' @examples
#' # Generalized linear model with Gaussian link
#' eglm(mpg ~ wt, family = gaussian(), data = mtcars)
#' @importFrom stats gaussian na.pass
#' @export
eglm <- function(formula, data, family = gaussian(), intercept = TRUE, weights = NULL,
                 na.action = na.omit, start = NULL, etastart = NULL,
                 mustart = NULL, offset = NULL, maxit = 25, k = 2, model = TRUE,
                 singularity.method = c("eigen", "Cholesky", "qr"),
                 x = FALSE, y = TRUE,
                 tol.estimation = 1e-8, tol.solve = .Machine$double.eps,
                 tol.values = 1e-7, tol.vectors = 1e-7, ...) {
  call <- match.call()
  target <- y
  M <- match.call(expand.dots = FALSE)
  m <- match(c("formula", "data"), names(M), 0L)
  M <- M[c(1L, m)]
  M$drop.unused.levels <- TRUE
  M[[1L]] <- quote(stats::model.frame)
  M <- eval(M, parent.frame())
  y <- M[[1]]
  tf <- attr(M, "terms")
  X <- model.matrix(tf, M)
  offset <- model.offset(M)
  intercept <- attributes(tf)$intercept
  singularity.method <- match.arg(singularity.method)
  rval <- eglm.wfit(
    X = X,
    y = y,
    family = family,
    weights = weights,
    start = start,
    etastart = etastart,
    mustart = mustart,
    offset = offset,
    intercept = intercept,
    maxit = maxit,
    k = k,
    tol.estimation = tol.estimation,
    tol.solve = tol.solve,
    tol.values = tol.values,
    tol.vectors = tol.vectors,
    singularity.method = singularity.method
  )
  rval$terms <- tf
  rval$call <- call
  class(rval) <- "eglm"
  if (model) rval$model <- M
  rval$fitted.values <- predict(rval, newdata = M, type = "response", na.action = na.action)
  rval$linear.predictors <- predict(rval, newdata = M, type = "link", na.action = na.action)
  if (x) rval$x <- X
  if (target) {
    rval$y <- y
    names(rval$y) <- names(rval$fitted.values)
  }
  names(rval$prior.weights) <- names(rval$fitted.values)
  qr_tol <- 1e-11
  rval$qr <- qr(model.matrix(rval), tol = qr_tol)
  attr(rval$qr$qr, "assign") <- NULL
  rval$qr$tol <- qr_tol
  attr(rval$qr, "qr") <- "qr"

  if ((rval$iter == maxit) & (!rval$convergence)) {
    warning("Maximum number of iterations reached without convergence")
  }
  rval
}
