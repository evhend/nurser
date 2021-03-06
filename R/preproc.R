#' Preproc
#'
#' @param X (dpylyr dataframe) X_train dateframe - Required
#'
#'
#' @return (dataframe) Preprocessed df with scaling or encoding
#'
#' @export
#'
#' @examples
#' processed_X <- preproc(mtcars)
#' 
  preproc <- function(X) {
    if (!is.data.frame(X) & !tibble::is_tibble(X)) {
      stop("X_train must be of type dataframe")
    }
    indx <- sapply(X, is.factor)
    X[indx] <- lapply(X[indx], function(x) as.numeric(x))
    column_types <- sapply(X, class)
    i<-0
    for (class in column_types) {
      i<-i+1
      if (class == "numeric") {
        X[[i]] <- scale(X[[i]])
      }
    }
    if ("factor" %in% column_types | "character" %in% column_types) {
      X <- fastDummies::dummy_cols(X, remove_first_dummy=TRUE, remove_selected_columns = TRUE)
    }
    X
}

