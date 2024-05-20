<h1>Exchange Rate Prediction using MLP Models</h1>

  <p>This repository contains R code for predicting exchange rates using Multilayer Perceptron (MLP) models. The code implements various MLP architectures and evaluates their performance on exchange rate prediction.</p>

  <h2>Description</h2>
  <p>The code reads exchange rate data from an Excel file and preprocesses it to create lagged versions of the exchange rate series. Then, it normalizes the data and splits it into training and testing datasets. It trains multiple MLP models with different architectures using the training dataset and evaluates their performance using various performance metrics such as Root Mean Squared Error (RMSE), Mean Absolute Error (MAE), Mean Absolute Percentage Error (MAPE), and Symmetric Mean Absolute Percentage Error (sMAPE).</p>

  <h2>Libraries Used</h2>
  <ul>
    <li>readxl</li>
    <li>neuralnet</li>
    <li>dplyr</li>
    <li>MLmetrics</li>
    <li>Metrics</li>
    <li>knitr</li>
  </ul>

  <h2>Usage</h2>
  <ol>
    <li>Clone this repository to your local machine.</li>
    <li>Install the required R packages listed above if you haven't already.</li>
    <li>Run the R script in your preferred environment (e.g., RStudio).</li>
    <li>Modify the file path in the script to point to your exchange rate dataset if necessary.</li>
  </ol>

  <h2>Models Implemented</h2>
  <p>The following MLP models are implemented and evaluated:</p>
 <ol>
  <li>Model 1: Single lagged feature (t1)</li>
  <li>Model 2: Multiple lagged features (t1, t2, t3)</li>
  <li>Model 3: Multiple lagged features (t1, t2, t3, t4)</li>
  <li>Model 4: Combined features (t1, t4, t2)</li>
  <li>Model 5: Combined features (t1, t2, t4)</li>
  <li>Model 6: Combined features (t1, t2, t3, t4)</li>
  <li>Model 7: Selected features (t2, t3)</li>
  <li>Model 8: Selected features (t1, t2)</li>
  <li>Model 9: Selected features (t1, t4)</li>
  <li>Model 10: Combined features (t1, t2, t3, t4)</li>
  <li>Model 11: Selected features (t2, t1)</li>
  <li>Model 12: Combined features (t1, t3, t4)</li>
  <li>Model 13: Combined features (t1, t2, t3)</li>
  <li>Model 14: Selected features (t1, t2)</li>
  <!-- Add more model descriptions here -->
</ol>


  <h2>Conclusion</h2>
  <p>This code provides a systematic approach to exchange rate prediction using MLP models with different architectures. It enables users to experiment with various model configurations and evaluate their performance on exchange rate prediction tasks.</p>
