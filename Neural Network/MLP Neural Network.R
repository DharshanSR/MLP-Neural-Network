#load the library
library(readxl)
library(neuralnet)
library(dplyr)
library(MLmetrics)
library(Metrics)
library(knitr)

#Read the data from the excel file
exchange_data <- read_excel("C:/Users/Dharshan/OneDrive/Desktop/Machine Learning Coursework/Sub Task 2/ExchangeUSD.xlsx")
exchange_data  #display the data

#extract exchange rate colum
usd_to_eur_exchange_rate <- exchange_data$`USD/EUR`
str(usd_to_eur_exchange_rate)

#create the lagged version of example rate series 
lagged_rates_data <- bind_cols(
  t4 = lag(usd_to_eur_exchange_rate, 4),
  t3 = lag(usd_to_eur_exchange_rate, 3),
  t2 = lag(usd_to_eur_exchange_rate, 2),
  t1 = lag(usd_to_eur_exchange_rate, 1),
  t = usd_to_eur_exchange_rate
)

# Display the first few rows of the lagged rates data
head(as.data.frame(lagged_rates_data))

#remove the null values
lagged_rates_data <- na.omit(lagged_rates_data)

#display the null values after the removal
head(lagged_rates_data)

#function to normalize data
normalizer_exchange_data <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

unnormalizer_exchange_data <- function(x, min, max) {
  return((max - min)*x + min)
}

processed_data <- normalizer_exchange_data(lagged_rates_data)

# Define the training dataset using the first 400 rows
trainning_dataset <- processed_data[1:400,]
trainning_dataset

# Define the testing data
testing_dataset <- processed_data[401:nrow(processed_data),]
testing_dataset

#Calculate the performance metrics
calculate_performance_metrics <- function(actual_output, predicted_output){
  
  rmse <- RMSE(actual_output, predicted_output)
  mae <- MAE(actual_output, predicted_output)
  mape <- MAPE(actual_output, predicted_output)
  smape <- smape(actual_output, predicted_output)
  
  # Create a data frame for metrics
  metrics_df <- data.frame(
    Metric = c("RMSE", "MAE", "MAPE", "sMAPE"),
    Value = c(rmse, mae, mape, smape)
  )
  
  # Print the metrics table
  kable(metrics_df, format = "markdown")
}

# MLP - model 1
mlp_model_1 <- neuralnet(t ~ t1, data = trainning_dataset, hidden = c(2,3), act.fct = "logistic", linear.output = FALSE)
plot(mlp_model_1)

prediction_model_1 <- predict(mlp_model_1, testing_dataset)

calculate_performance_metrics(testing_dataset$t, prediction_model_1)

unnorm_prediction_model_1 <- unnormalizer_exchange_data(prediction_model_1, min(lagged_rates_data), max(lagged_rates_data) )
unnorm_prediction_model_1


# MLP - model 2
mlp_model_2 <- neuralnet(t ~ t1 + t2 + t3, data = trainning_dataset, hidden = c(3,1), act.fct = "tanh", linear.output = TRUE)
plot(mlp_model_2)

prediction_model_2 <- predict(mlp_model_2, testing_dataset)

calculate_performance_metrics(testing_dataset$t, prediction_model_2)

unnorm_prediction_model_2 <- unnormalizer_exchange_data(prediction_model_2, min(lagged_rates_data), max(lagged_rates_data) )
unnorm_prediction_model_2


# MLP - model 3
mlp_model_3 <- neuralnet(t ~ t1 + t2 + t3 + t4, data = trainning_dataset, hidden = c(5,4), act.fct = "logistic", linear.output = FALSE)
plot(mlp_model_3)

prediction_model_3 <- predict(mlp_model_3, testing_dataset)

calculate_performance_metrics(testing_dataset$t, prediction_model_3)

unnorm_prediction_model_3 <- unnormalizer_exchange_data(prediction_model_3, min(lagged_rates_data), max(lagged_rates_data) )
unnorm_prediction_model_3


# MLP - model 4
mlp_model_4 <- neuralnet(t ~ t1 + t4 + t2, data = trainning_dataset, hidden = c(3,5), act.fct = "tanh", linear.output = TRUE)
plot(mlp_model_4)

prediction_model_4 <- predict(mlp_model_4, testing_dataset)

calculate_performance_metrics(testing_dataset$t, prediction_model_4)

unnorm_prediction_model_4 <- unnormalizer_exchange_data(prediction_model_4, min(lagged_rates_data), max(lagged_rates_data) )
unnorm_prediction_model_4


# MLP - model 5
mlp_model_5 <- neuralnet(t ~ t1 + t2 + t4, data = trainning_dataset, hidden = c(8), act.fct = "logistic", linear.output = FALSE)
plot(mlp_model_5)

prediction_model_5 <- predict(mlp_model_5, testing_dataset)

calculate_performance_metrics(testing_dataset$t, prediction_model_5)

unnorm_prediction_model_5 <- unnormalizer_exchange_data(prediction_model_5, min(lagged_rates_data), max(lagged_rates_data) )
unnorm_prediction_model_5


# MLP - model 6
mlp_model_6 <- neuralnet(t ~ t1 + t2 + t3 + t4, data = trainning_dataset, hidden = c(7,4), act.fct = "logistic", linear.output = FALSE)
plot(mlp_model_6)

prediction_model_6 <- predict(mlp_model_6, testing_dataset)

calculate_performance_metrics(testing_dataset$t, prediction_model_6)

unnorm_prediction_model_6 <- unnormalizer_exchange_data(prediction_model_6, min(lagged_rates_data), max(lagged_rates_data) )
unnorm_prediction_model_6


# MLP - model 7
mlp_model_7 <- neuralnet(t ~ t2 + t3, data = trainning_dataset, hidden = c(5,10), act.fct = "tanh", linear.output = FALSE)
plot(mlp_model_7)

prediction_model_7 <- predict(mlp_model_7, testing_dataset)

calculate_performance_metrics(testing_dataset$t, prediction_model_7)

unnorm_prediction_model_7 <- unnormalizer_exchange_data(prediction_model_7, min(lagged_rates_data), max(lagged_rates_data) )
unnorm_prediction_model_7


# MLP - model 8
mlp_model_8 <- neuralnet(t ~ t1 + t2 , data = trainning_dataset, hidden = c(4), act.fct = "logistic", linear.output = FALSE)
plot(mlp_model_8)

prediction_model_8 <- predict(mlp_model_8, testing_dataset)

calculate_performance_metrics(testing_dataset$t, prediction_model_8)

unnorm_prediction_model_8 <- unnormalizer_exchange_data(prediction_model_8, min(lagged_rates_data), max(lagged_rates_data) )
unnorm_prediction_model_8


# MLP - model 9
mlp_model_9 <- neuralnet(t ~ t1 + t4, data = trainning_dataset, hidden = c(6,9), act.fct = "tanh", linear.output = TRUE)
plot(mlp_model_9)

prediction_model_9 <- predict(mlp_model_9, testing_dataset)

calculate_performance_metrics(testing_dataset$t, prediction_model_9)

unnorm_prediction_model_9 <- unnormalizer_exchange_data(prediction_model_9, min(lagged_rates_data), max(lagged_rates_data) )
unnorm_prediction_model_9


# MLP - model 10 
mlp_model_10 <- neuralnet(t ~ t1 + t2 + t3 + t4, data = trainning_dataset, hidden = c(6), act.fct = "logistic", linear.output = FALSE)
plot(mlp_model_10)

prediction_model_10 <- predict(mlp_model_10, testing_dataset)

calculate_performance_metrics(testing_dataset$t, prediction_model_10)

unnorm_prediction_model_10 <- unnormalizer_exchange_data(prediction_model_10, min(lagged_rates_data), max(lagged_rates_data) )
unnorm_prediction_model_10


# MLP - model 11
mlp_model_11 <- neuralnet(t ~ t2 + t1, data = trainning_dataset, hidden = c(9), act.fct = "logistic", linear.output = FALSE)
plot(mlp_model_11)

prediction_model_11 <- predict(mlp_model_11, testing_dataset)

calculate_performance_metrics(testing_dataset$t, prediction_model_11)

unnorm_prediction_model_11 <- unnormalizer_exchange_data(prediction_model_11, min(lagged_rates_data), max(lagged_rates_data) )
unnorm_prediction_model_11


# MLP - model 12
mlp_model_12 <- neuralnet(t ~ t1 + t3 + t4, data = trainning_dataset, hidden = c(2,5,3), act.fct = "tanh", linear.output = TRUE)
plot(mlp_model_12)

prediction_model_12 <- predict(mlp_model_12, testing_dataset)

calculate_performance_metrics(testing_dataset$t, prediction_model_12)

unnorm_prediction_model_12 <- unnormalizer_exchange_data(prediction_model_12, min(lagged_rates_data), max(lagged_rates_data) )
unnorm_prediction_model_12


# MLP - model 13
mlp_model_13 <- neuralnet(t ~ t1 + t2 + t3, data = trainning_dataset, hidden = c(5), act.fct = "logistic", linear.output = FALSE)
plot(mlp_model_13)

prediction_model_13 <- predict(mlp_model_13, testing_dataset)

calculate_performance_metrics(testing_dataset$t, prediction_model_13)

unnorm_prediction_model_13 <- unnormalizer_exchange_data(prediction_model_13, min(lagged_rates_data), max(lagged_rates_data) )
unnorm_prediction_model_13


# MLP - model 14
mlp_model_14 <- neuralnet(t ~ t1 + t2, data = trainning_dataset, hidden = c(7), act.fct = "logistic", linear.output = FALSE)
plot(mlp_model_14)

prediction_model_14 <- predict(mlp_model_14, testing_dataset)

calculate_performance_metrics(testing_dataset$t, prediction_model_14)

unnorm_prediction_model_14 <- unnormalizer_exchange_data(prediction_model_14, min(lagged_rates_data), max(lagged_rates_data) )
unnorm_prediction_model_14


unnorm_testing_dataset_actual <- unnormalizer_exchange_data(testing_dataset$t, min(lagged_rates_data), max(lagged_rates_data) )

# Combine predicted and actual values into a data frame
prediction_model__table <- data.frame(predicted = unnorm_prediction_model_2, actual = unnorm_testing_dataset_actual)

# Print the table
kable(prediction_model__table, format = "markdown")


plot(testing_dataset$t, ylab = "Predicted vs Real", type = "l", col = "green")
par(new = TRUE)
plot(prediction_model_2, ylab = "", yaxt = "n", type = "l", col = "red")
legend('topleft', c('Predicted', 'Real'), fill = c("red", "green"))

plot(testing_dataset$t, ylab = "Predicted vs Real", type = "l", col = "green")
par(new = TRUE)
plot(prediction_model_11, ylab = "", yaxt = "n", type = "l", col = "red")
legend('topleft', c('Predicted', 'Real'), fill = c("red", "green"))