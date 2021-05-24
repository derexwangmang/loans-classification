# Packages, Seed ----------------------------------------------------------

library(tidyverse)
library(tidymodels)
library(lubridate)
library(stringr)

set.seed(61234)

load("data/loans_train_processed.Rda")

# Data Recipe -------------------------------------------------------------

# Using k-fold cross validation and stratifying by the target outcome
loans_folds <- vfold_cv(loans_train, v = 5, repeats = 3, strata = hi_int_prncp_pd)

save(loans_folds, file = "data/loans_folds.Rda")