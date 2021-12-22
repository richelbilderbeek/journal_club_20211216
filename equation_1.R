plot(log)
log(0.1)

t <- tibble::tibble(
  inputs = c(0, 1, 0),
  outputs = c(0.1, 1.0, 0.01)
)
calc_error(t)


t <- tibble::tibble(
  inputs = c(0, 1, 0),
  outputs = c(0.1, 0.9, 0.1)
)
calc_error(t)

t <- tibble::tibble(
  inputs = c(0, 1, 0),
  outputs = c(0.1, 0.8, 0.1)
)
calc_error(t)

calc_error <- function(t) {
  t$inputs * log(t$outputs)
}
