# Packages, Seed ----------------------------------------------------------

library(tidyverse)
library(zoo)
library(tidymodels)
library(stringr)

set.seed(61234)


# Train Data Processing ---------------------------------------------------

loans_train <- read_csv("data/train.csv") %>%
  mutate(emp_length = gsub(" year.*", "", emp_length)) %>%
  mutate(emp_length = case_when(
    emp_length == "< 1" ~ "0",
    emp_length == "10+" ~ "10",
    TRUE ~ emp_length)) %>%
  # Removing N/A value
  filter(emp_length != "n/a") %>%
  mutate(emp_length = as.numeric(emp_length)) %>%
  mutate_if(is.character, as.factor) %>%
  mutate(hi_int_prncp_pd = factor(hi_int_prncp_pd)) %>%
  # Levels appear in testing that do not appear in training
  select(-c(earliest_cr_line, last_credit_pull_d, purpose,
            emp_title, sub_grade))
# Converting to date
# mutate(earliest_cr_line = my(earliest_cr_line),
# last_credit_pull_d = my(last_credit_pull_d))

save(loans_train, file = "data/loans_train_processed.Rda")


# Test Data Processing ----------------------------------------------------

loans_test <- read_csv("data/test.csv") %>%
  mutate(emp_length = gsub(" year.*", "", emp_length)) %>%
  mutate(emp_length = case_when(
    emp_length == "< 1" ~ "0",
    emp_length == "10+" ~ "10",
    TRUE ~ emp_length)) %>%
  # Can't filter out test data
  # filter(emp_length != "n/a") %>%
  mutate(emp_length = as.numeric(emp_length)) %>%
  mutate_if(is.character, as.factor) %>%
  # mutate(hi_int_prncp_pd = factor(hi_int_prncp_pd)) %>%
  # Levels appear in testing that do not appear in training
  select(-c(earliest_cr_line, last_credit_pull_d, purpose,
            emp_title, sub_grade))
# Converting to date
# mutate(earliest_cr_line = my(earliest_cr_line),
# last_credit_pull_d = my(last_credit_pull_d))

save(loans_test, file = "data/loans_test_processed.Rda")
