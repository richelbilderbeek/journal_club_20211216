calc_y <- function(x) {
  x <- x - 3
  y <- (x * x) + x + 2
  y
}

t <- tibble::tibble(
  x = seq(0, 5),
  y = NA,
)
t$y <- calc_y(t$x)
t$y <- t$y + rep(c(-1, 1), 3)

# Shared elements of all plots
p <- ggplot2::ggplot(t, ggplot2::aes(x = x, y = y)) +
  ggplot2::scale_y_continuous(limits = c(0, 10), breaks = seq(0, 10, by = 2)) +
  ggplot2::theme(
    text = ggplot2::element_text(size = 24),
    axis.title.y = ggplot2::element_blank(),
    axis.text.y = ggplot2::element_blank(),
    axis.ticks.y = ggplot2::element_blank(),
    axis.title.x = ggplot2::element_blank(),
    axis.text.x = ggplot2::element_blank(),
    axis.ticks.x = ggplot2::element_blank()
  )

# Show all
p + ggplot2::geom_smooth(method = "lm", color = "red", se = FALSE, size = 10) +
  ggplot2::geom_smooth(method = "lm", formula = y ~ x + I(x^2), color = "green", se = FALSE, size = 10) +
  ggplot2::geom_smooth(method = "loess", color = "blue", se = FALSE, size = 10) +
  ggplot2::geom_point()

# Underfit
p + ggplot2::geom_smooth(method = "lm", color = "red", se = FALSE, size = 10) +
  ggplot2::geom_point(size = 20)
ggplot2::ggsave("underfitting.png", width = 4, height = 4)

# Correct fit
p + ggplot2::geom_smooth(method = "lm", formula = y ~ x + I(x^2), color = "green", se = FALSE, size = 10) +
  ggplot2::geom_point(size = 20)
ggplot2::ggsave("correct_fit.png", width = 4, height = 4)

# Overfit
p + ggplot2::geom_smooth(method = "loess", color = "blue", se = FALSE, size = 10) +
  ggplot2::geom_point(size = 20)
ggplot2::ggsave("overfitting.png", width = 4, height = 4)
