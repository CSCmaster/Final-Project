#### Preamble ####
# Purpose: 
# Author: Jingyi Shen
# Date: 14 March 2024
# Contact: jingyi.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The 'rstanarm' package for Bayesian modeling, 'readr' for data manipulation, and 'here' for path management
# The 'cleaned_data' dataset must be pre-processed before using it in the model.

library(rstanarm)
library(dplyr)
library(readr)
library(here)

set.seed(302)

# Read in the cleaned survey data
survey_data <- read_csv(here("data", "analysis_data", "cleaned_survey_data.csv"))

# Convert the necessary columns to factors
survey_data <- survey_data %>%
  mutate(
    province = as.factor(province),
    sex = as.factor(sex),
    education = as.factor(education),
    religion = as.factor(religion),
    income_before_tax = as.factor(income_before_tax)
  )

# Set up the priors
prior_intercept <- normal(0, 2.5)
prior_covariates <- normal(0, scale = 1)  # The scale can be treated as 1/sqrt(lambda) for Exponential(lambda)

# Define the model using stan_glm
liberal_model <- stan_glm(
  vote_liberal ~ age + sex + province + education + religion + income_before_tax,
  data = survey_data, 
  family = binomial(link = "logit"),
  prior_intercept = prior_intercept,
  prior = prior_covariates,
  prior_aux = exponential(1),
  chains = 4,
  iter = 2000
)

conservative_model <- stan_glm(
  vote_conservative ~ age + sex + province + education + religion + income_before_tax,
  data = survey_data, 
  family = binomial(link = "logit"),
  prior_intercept = prior_intercept,
  prior = prior_covariates,
  prior_aux = exponential(1),
  chains = 4,
  iter = 2000
)

# Save the models
saveRDS(liberal_model, file = here("models", "liberal_model.rds"))
saveRDS(conservative_model, file = here("models", "conservative_model.rds"))
