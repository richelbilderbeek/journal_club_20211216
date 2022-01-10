classifications <- tibble::tibble(
  score = seq(from = 0.0, to = 1.0, length = 30),
  is_spam = c(rep(FALSE, 15), rep(c(TRUE, FALSE), 4), rep(TRUE, 7))
)
threshold <- 0.67
threshold <- 0.75

ggplot2::ggplot(
  classifications,
  ggplot2::aes(x = score, y = 0, color = as.factor(is_spam))
) + ggplot2::geom_point(size = 5) + 
  ggplot2::labs(colour = "is_spam") +
  ggplot2::xlab("Score (i.e. the estimated probability this is spam)") +
  ggplot2::geom_vline(xintercept = threshold, lty = "dashed") +
  ggplot2::theme(
    axis.title.y = ggplot2::element_blank(), 
    axis.text.y = ggplot2::element_blank(),
    axis.ticks.y = ggplot2::element_blank(),
    text = ggplot2::element_text(size = 24)
  )
  

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

f1_scores <- tibble::tibble(
  threshold = classifications$score - (0.5 / length(classifications$score)),
  f1_score = NA
)
f1_scores <- f1_scores[-1, ]
# library(functional)
# calc_f1_score_for_classifications <- functional::Curry(calc_f1_score, classifications = classifications)
# functional::
# calc_f1_scores_for_classifications <- Vectorize(calc_f1_score_for_classifications)
# calc_f1_scores_for_classifications(c(0.1, 0.2))
for (row_index in seq_along(f1_scores$threshold)) {
  f1_scores$f1_score[row_index] <- calc_f1_score(
    classifications = classifications, 
    threshold = f1_scores$threshold[row_index]
  )
}
f1_scores

ggplot2::ggplot(
) + ggplot2::geom_point(
  data = classifications, 
  ggplot2::aes(x = score, y = mean(f1_scores$f1_score), color = as.factor(is_spam)),
  size = 5
) + ggplot2::geom_point(data = f1_scores, ggplot2::aes(x = threshold, y = f1_score), size = 5) + 
  ggplot2::labs(colour = "is_spam") +
  ggplot2::ylab("F1 score") +
  ggplot2::xlab("Classification score (for data), threshold (for F1 score)")
  
