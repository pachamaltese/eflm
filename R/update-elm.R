#' @importFrom stats update.default
#' @export
#' @keywords internal
update.elm <- function(object, formula, data, add = TRUE, evaluate = TRUE, ...) {
  if (!inherits(object, "elm")) {
    stop("object must be of class elm")
  }
  if ((!missing(formula)) & (!missing(data)) & (add)) {
    stop("cannot specify a formula while adding new data")
  }
  if ((!missing(data)) & (add)) {
    mod <- update_with_more_data(object, data, formula = formula.elm(object), ...)
  }
  else {
    mod <- if (missing(data)) {
      update.default(object, formula, evaluate = evaluate, ...)
    } else {
      update.default(object, formula, data = data, evaluate = evaluate, ...)
    }
  }
  mod
}
