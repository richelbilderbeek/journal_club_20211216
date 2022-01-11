classifications <- tibble::tibble(
  score = seq(from = 0.0, to = 1.0, length = 30),
  is_spam = c(rep(FALSE, 15), rep(c(TRUE, FALSE), 4), rep(TRUE, 7))
)
threshold <- 0.75
threshold <- 0.67

ggplot2::ggplot(
  classifications,
  ggplot2::aes(x = score, y = 0, color = as.factor(is_spam))
) + ggplot2::geom_point(size = 5) +
  ggplot2::labs(colour = "is_spam") +
  ggplot2::scale_color_manual(values = c("TRUE" = "black", "FALSE" = "grey")) +
  ggplot2::xlab("Classification score") +
  ggplot2::geom_vline(xintercept = threshold, lty = "dashed") +
  ggplot2::theme(
    axis.title.y = ggplot2::element_blank(),
    axis.text.y = ggplot2::element_blank(),
    axis.ticks.y = ggplot2::element_blank(),
    text = ggplot2::element_text(size = 24)
  )
ggplot2::ggsave(filename = "~/classification.png", width = 9, height = 2)


count_fp <- function(classifications, threshold) {
  sum(classifications$is_spam[classifications$score >= threshold] == FALSE)
}
count_tp <- function(classifications, threshold) {
  sum(classifications$is_spam[classifications$score >= threshold] == TRUE)
}
count_fn <- function(classifications, threshold) {
  sum(classifications$is_spam[classifications$score < threshold] == TRUE)
}
count_tn <- function(classifications, threshold) {
  sum(classifications$is_spam[classifications$score < threshold] == FALSE)
}
calc_precision <- function(classifications, threshold) {
  n_tp <- count_tp(classifications, threshold)
  n_fp <- count_fp(classifications, threshold)
  n_tp / (n_tp + n_fp)
}
calc_recall <- function(classifications, threshold) {
  n_tp <- count_tp(classifications, threshold)
  n_fn <- count_fn(classifications, threshold)
  n_tp / (n_tp + n_fn)
}
calc_f1_score <- function(classifications, threshold) {
  precision <- calc_precision(classifications, threshold)
  recall <- calc_recall(classifications, threshold)
  2.0 / ((1.0 / precision) + (1.0 / recall))
}
calc_precision(classifications, threshold)
calc_recall(classifications, threshold)
calc_f1_score(classifications, threshold)

scores <- tibble::tibble(
  threshold = classifications$score - (0.5 / length(classifications$score)),
  precision = NA,
  recall = NA,
  f1_score = NA
)
scores <- scores[-1, ]

# library(functional)
# calc_f1_score_for_classifications <- functional::Curry(calc_f1_score, classifications = classifications)
# functional::
# calc_scores_for_classifications <- Vectorize(calc_f1_score_for_classifications)
# calc_scores_for_classifications(c(0.1, 0.2))
for (row_index in seq_along(scores$threshold)) {
  scores$precision[row_index] <- calc_precision(
    classifications = classifications,
    threshold = scores$threshold[row_index]
  )
  scores$recall[row_index] <- calc_recall(
    classifications = classifications,
    threshold = scores$threshold[row_index]
  )
  scores$f1_score[row_index] <- calc_f1_score(
    classifications = classifications,
    threshold = scores$threshold[row_index]
  )
}
scores

ggplot2::ggplot(
) + ggplot2::geom_point(
  data = classifications,
  ggplot2::aes(x = score, y = 0.0, color = as.factor(is_spam)),
  size = 5
) +
  ggplot2::geom_point(data = scores, ggplot2::aes(x = threshold, y = precision), size = 5, color = "red") +
  ggplot2::geom_smooth(data = scores, ggplot2::aes(x = threshold, y = precision), color = "red") +
  ggplot2::labs(colour = "is_spam") +
  ggplot2::scale_color_manual(values = c("TRUE" = "black", "FALSE" = "grey")) +
  ggplot2::ylab("Precision") +
  ggplot2::xlab("Classification score") +
  ggplot2::theme(text = ggplot2::element_text(size = 24))
ggplot2::ggsave(filename = "~/precision.png", width = 9, height = 9)

ggplot2::ggplot(
) + ggplot2::geom_point(
  data = classifications,
  ggplot2::aes(x = score, y = 0.0, color = as.factor(is_spam)),
  size = 5
) +
  ggplot2::geom_point(data = scores, ggplot2::aes(x = threshold, y = recall), size = 5, col = "green") +
  ggplot2::geom_smooth(data = scores, ggplot2::aes(x = threshold, y = recall), col = "green") +
  ggplot2::labs(colour = "is_spam") +
  ggplot2::scale_color_manual(values = c("TRUE" = "black", "FALSE" = "grey")) +
  ggplot2::ylab("Recall") +
  ggplot2::xlab("Classification score") +
  ggplot2::theme(text = ggplot2::element_text(size = 24))
ggplot2::ggsave(filename = "~/recall.png", width = 9, height = 9)

ggplot2::ggplot(
) + ggplot2::geom_point(
  data = classifications,
  ggplot2::aes(x = score, y = 0.0, color = as.factor(is_spam)),
  size = 5
) +
  ggplot2::geom_point(data = scores, ggplot2::aes(x = threshold, y = f1_score), size = 5, color = "blue") +
  ggplot2::geom_smooth(data = scores, ggplot2::aes(x = threshold, y = f1_score), color = "blue") +
  ggplot2::labs(colour = "is_spam") +
  ggplot2::scale_color_manual(values = c("TRUE" = "black", "FALSE" = "grey")) +
  ggplot2::ylab("F1 score") +
  ggplot2::xlab("Classification score") +
  ggplot2::theme(text = ggplot2::element_text(size = 24))
ggplot2::ggsave(filename = "~/f1_score.png", width = 9, height = 9)


ggplot2::ggplot(
) + ggplot2::geom_point(
  data = classifications,
  ggplot2::aes(x = score, y = 0.0, color = as.factor(is_spam)),
  size = 5
) +
  ggplot2::geom_point(data = scores, ggplot2::aes(x = threshold, y = precision), size = 5, color = "red") +
  ggplot2::geom_smooth(data = scores, ggplot2::aes(x = threshold, y = precision), color = "red") +
  ggplot2::geom_point(data = scores, ggplot2::aes(x = threshold, y = recall), size = 5, color = "green") +
  ggplot2::geom_smooth(data = scores, ggplot2::aes(x = threshold, y = recall), color = "green") +
  ggplot2::geom_point(data = scores, ggplot2::aes(x = threshold, y = f1_score), size = 5, color = "blue") +
  ggplot2::geom_smooth(data = scores, ggplot2::aes(x = threshold, y = f1_score), color = "blue") +
  ggplot2::labs(colour = "is_spam") +
  ggplot2::scale_color_manual(values = c("TRUE" = "black", "FALSE" = "grey")) +
  ggplot2::ylab("F1 score") +
  ggplot2::xlab("Classification score") +
  ggplot2::theme(text = ggplot2::element_text(size = 24))
ggplot2::ggsave(filename = "~/f1_score.png", width = 9, height = 9)





