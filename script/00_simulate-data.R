set.seed(123) 

num_var1 <- rnorm(100, mean = 50, sd = 10) 
num_var2 <- runif(100, min = 0, max = 100000) 

cat_var1 <- sample(c("Male", "Female"), 100, replace = TRUE, prob = c(0.5, 0.5)) 
cat_var2 <- sample(c("High School", "Bachelor's", "Master's", "PhD"), 100, replace = TRUE, prob = c(0.3, 0.4, 0.2, 0.1)) 

start_date <- as.Date("2023-01-01")
end_date <- as.Date("2023-12-31")
date_var <- sample(seq(start_date, end_date, by="day"), 100, replace = TRUE)


simulated_data <- data.frame(num_var1, num_var2, cat_var1, cat_var2, date_var)

head(simulated_data)

set.seed(123) 


num_rows = 1000 


income <- rnorm(num_rows, mean = 50000, sd = 15000)

education_levels <- c("High School", "Bachelor", "Master", "PhD")
education_level <- sample(education_levels, num_rows, replace = TRUE, prob = c(0.3, 0.4, 0.2, 0.1))

employment_status <- rbinom(num_rows, 1, 0.75)

simulated_census_data <- data.frame(income, education_level, employment_status)

head(simulated_census_data)

