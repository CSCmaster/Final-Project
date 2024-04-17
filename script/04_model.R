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

m_lib <- glm(vote_liberal ~ age+sex+province+education+religion+income_before_tax,
             data=cleaned_survey_data, family = "binomial")
summary(m_lib)


step_lib = stepAIC(m_lib, direction = "both", k = 2)



m_cons <- glm(vote_conservative ~ age+sex+province+education+religion+income_before_tax,
              data=cleaned_survey_data, family = "binomial")

step_cons = stepAIC(m_cons, direction = "both", k = 2)

saveRDS(m_lib, file = here("models", "liberal_model.rds"))


saveRDS(m_cons, file = here("models", "conservative_model.rds"))








