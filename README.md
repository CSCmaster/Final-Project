# Predicting Probability of Participants' Vote of Conservative and Liberty in 2025 Canadian election
## Overview

This repo provides forecast the 2025 Candian election by regression model.

In our study, we use binary logistic regression to analyze voter preferences for Canada's Conservative and Liberal parties based on demographic and socioeconomic factors, adjusting the models with the AIC for optimal predictor selection. The Canadian electoral system elects parliamentarians through a multi-step process where, unless a candidate achieves an outright majority, votes are redistributed from the lowest-ranking candidates until one secures 50%. The Liberal Party plans to increase its refugee quota to 15% of all immigrants and admit 500,000 migrants annually by 2025. The Conservative Party emphasizes economic growth and attracting skilled immigrants. Our hypothesis predicts a likely Conservative victory in the 2025 elections, with the Liberals closely behind, based on trends and electoral mechanics. This analysis uses post-stratification to enhance the representativeness and accuracy of our predictions.

## Repository Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as Census data obtained from General Social Survey and Survey data obtained from Canada Election Study.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `models` contains fitted models of both Conservative and liberal model. 
-   `other` contains details about LLM chat interactions, and sketches.
-   `paper` provided include the materials used in creating the paper, such as the Quarto document and the reference bibliography file, along with the PDF version of the paper. 
-   `scripts` contains the R scripts used to simulate, download, test and clean data, the model is also located there.


## Statement on LLM usage
The data analysis, model, data summary measures were written with the help of ChatGPT 4.0 and the entire chat history is available in other/chat_with_GPT.txt.
