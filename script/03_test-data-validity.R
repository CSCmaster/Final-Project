
library(readr)
library(here)

cleaned_survey_data <- read_parquet(here("data", "analysis_data", "cleaned_survey_data.parquet"))

missing_values <- sapply(cleaned_survey_data, function(x) sum(is.na(x)))
print(missing_values)

print(str(cleaned_survey_data))

numeric_summary <- summary(cleaned_survey_data[sapply(cleaned_survey_data, is.numeric)])
print(numeric_summary)

categorical_columns <- sapply(cleaned_survey_data, is.factor) | sapply(cleaned_survey_data, is.character)
unique_values <- sapply(cleaned_survey_data[categorical_columns], function(x) length(unique(x)))
print(unique_values)

library(readr)
library(testthat)
library(dplyr)
cleaned_survey_data <- read_parquet(here("data", "analysis_data", "cleaned_census_data.parquet"))
cleaned_census_data <- read_csv(data_path)

test_no_missing_values <- function(data) {
  test_that("No missing values in any column", {
    expect_true(all(!is.na(data)))
  })
}

test_data_types <- function(data) {
  test_that("Data types are as expected", {
    expect_true(is.numeric(data$age))
    expect_true(is.factor(data$gender))
  })
}


test_numeric_ranges <- function(data, column, min, max) {
  test_that(paste("Values in", column, "are within expected range"), {
    expect_true(all(data[[column]] >= min & data[[column]] <= max), 
                info = paste(column, "has values outside the expected range."))
  })
}

test_categorical_levels <- function(data, column, expected_levels) {
  test_that(paste("Categorical levels in", column, "are as expected"), {
    expect_setequal(levels(data[[column]]), expected_levels)
  })
}


test_no_missing_values(cleaned_census_data)
test_data_types(cleaned_census_data)
test_numeric_ranges(cleaned_census_data, "age", 0, 120) 
test_categorical_levels(cleaned_census_data, "gender", c("Male", "Female")) 


