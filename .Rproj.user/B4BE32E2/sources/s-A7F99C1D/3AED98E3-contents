# Model Tuning

# Packages, Data ----------------------------------------------------------

library(tidyverse)
library(tidymodels)

set.seed(61234)

load("data/loans_train_processed.Rda")
load("data/loans_folds.Rda")


# Data Recipe -------------------------------------------------------------

loans_recipe <- recipe(hi_int_prncp_pd ~ ., loans_train) %>%
  # Removing id (label for the row) and state (throws errors due to "missing data")
  step_rm(id, addr_state) %>%
  # Imputing missing data
  step_impute_knn(all_predictors()) %>%
  step_dummy(all_nominal(), -all_outcomes(), one_hot = T) %>%
  step_normalize(all_predictors())

# Data Model --------------------------------------------------------------

svm_model <- svm_rbf(mode = "classification",
                     cost = tune(),
                     rbf_sigma = tune()) %>%
  set_engine("kernlab")


# Parameters --------------------------------------------------------------

svm_params <- parameters(svm_model)
svm_grid <- grid_regular(svm_params, levels = 10)


# Workflow ----------------------------------------------------------------

svm_workflow <- workflow() %>%
  add_model(svm_model) %>%
  add_recipe(loans_recipe)

svm_tuned <- svm_workflow %>%
  tune_grid(resamples = loans_folds,
            grid = svm_grid)

# Write out results & workflow
save(svm_tuned, file = "models/svm/svm_tuned.rds")
