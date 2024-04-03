
library(readr)
library(dplyr)
library(arrow)
library(tidyr)
library(ggplot2)
library(MASS)
library(knitr)
library(summarytools)
library(here)

knitr::opts_chunk$set(warning = FALSE, message = FALSE)

census_data <- read_csv(here("data", "raw_data","rawdata_census.csv"))
survey_data <- read_csv(here("data", "raw_data","survey_data.csv"))

prop_man <- sum(survey_data$cps21_genderid == "1") / nrow(survey_data)
prop_woman <- sum(survey_data$cps21_genderid == "2") / nrow(survey_data)


survey_data_new <- survey_data %>%
  mutate(
    age = cps21_age,
    sex = sample(c("Male", "Female"), size = nrow(survey_data), replace = TRUE, prob = c(prop_man, prop_woman)),
    province = case_when(
      cps21_province == 1 ~ "Alberta",
      cps21_province == 2 ~ "British Columbia",
      cps21_province == 3 ~ "Manitoba",
      cps21_province == 4 ~ "New Brunswick",
      cps21_province == 5 ~ "Newfoundland and Labrador",
      TRUE ~ NA_character_  
    ),
    education = case_when(
      cps21_education %in% c(1, 2, 3, 12) ~ "Limited Education",
      cps21_education %in% c(4, 5, 6, 7, 8) ~ "Some Education",
      cps21_education %in% c(9, 10, 11) ~ "Highly Educated"
    ),
    religion = ifelse(cps21_religion == 1, "NO", "YES"),
    income_before_tax = case_when(
      cps21_income_number >= 125000 ~ "Upper Middle Class to Wealthy",
      cps21_income_number >= 50000 ~ "Middle Class",
      TRUE ~ "Lower Middle Class to Poor"
    ),
    vote_liberal = as.integer(cps21_votechoice == 1),
    vote_conservative = as.integer(cps21_votechoice == 2)
  ) %>%
  filter(!is.na(province)) %>%
  dplyr::select(age, sex, province, education, religion, income_before_tax, vote_liberal, vote_conservative) 


write.csv(survey_data_new, here("data", "analysis_data", "cleaned_survey_data.csv"), row.names = FALSE)
write_parquet(survey_data_new, here("data", "analysis_data", "cleaned_survey_data.parquet"))


census_data_new <- census_data %>%
  mutate(
    age = round(age),
    education = dplyr::case_when(
      education %in% c("Less than high school diploma or its equivalent", NA) ~ "Limited Education",
      education %in% c("High school diploma or a high school equivalency certificate", "Trade certificate or diploma", 
                       "College, CEGEP or other non-university certificate or diploma", 
                       "University certificate or diploma below the bachelor's level") ~ "Some Education",
      education %in% c("Bachelor's degree (e.g. B.A., B.Sc., LL.B.)", 
                       "University certificate, diploma or degree above the bachelor's level") ~ "Highly Educated"
    ),
    religion = dplyr::case_when(
      religion_has_affiliation %in% c("Has religious affiliation", "Don't know", NA) ~ "YES",
      religion_has_affiliation == "No religious affiliation" ~ "NO"
    ),
    income_before_tax = dplyr::case_when(
      income_respondent %in% c("Less than $25,000", "$25,000 to $49,999") ~ "Lower Middle Class to Poor",
      income_respondent %in% c("$50,000 to $74,999", "$75,000 to $99,999", "$100,000 to $124,999") ~ "Middle Class",
      income_respondent == "$125,000 and more" ~ "Upper Middle Class to Wealthy"
    )
  ) %>%
  dplyr::select(age, sex, province, education, religion, income_before_tax)

write.csv(census_data_new, here("data", "analysis_data", "cleaned_census_data.csv"), row.names = FALSE)
write_parquet(census_data_new, here("data", "analysis_data", "cleaned_census_data.parquet"))


