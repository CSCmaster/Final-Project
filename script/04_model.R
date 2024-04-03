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
library(here)
library(readr)

survey_data <- read_csv(here("data", "analysis_data", "cleaned_survey_data.csv"))

survey_data <- survey_data %>%
  mutate(province = as.factor(province),
         sex = as.factor(sex),
         education = as.factor(education),
         religion = as.factor(religion),
         income_before_tax = as.factor(income_before_tax))


liberal_model <- stan_glm(vote_liberal ~ age + sex + province + education + religion + income_before_tax,
                          data = survey_data, family = binomial(link = "logit"))


conservative_model <- stan_glm(vote_conservative ~ age + sex + province + education + religion + income_before_tax,
                               data = survey_data, family = binomial(link = "logit"))

saveRDS(
  liberal_model,
  file = here("models", "liberal_model.rds")
)
saveRDS(
  conservative_model,
  file = here("models", "conservative_model.rds")
)