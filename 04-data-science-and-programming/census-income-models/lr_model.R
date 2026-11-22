# Logistic Regression Model Script (lr_model.R)

# Load required libraries
library(stats)

# Set working directory to your project folder
# Replace with your actual path
setwd("C:/PowerBI_Assignment")

# Read data
train_data <- read.csv("Train_data.csv")
test_data <- read.csv("Test_data.csv")

# Handle categorical variables
categorical_cols <- c("Workclass", "MaritalStatus", "Occupation", 
                      "Relationship", "Race", "Sex", "NativeCountry")

for (col in categorical_cols) {
  train_data[[col]] <- as.factor(train_data[[col]])
  test_data[[col]] <- as.factor(test_data[[col]])
}

# Convert Income to binary (1 for >50K, 0 for <=50K)
train_data$Income_Binary <- ifelse(train_data$Income == ">50K", 1, 0)
test_data$Income_Binary <- ifelse(test_data$Income == ">50K", 1, 0)

# Train logistic regression model
lr_model <- glm(Income_Binary ~ Age + EducationNum + HoursPerWeek + MaritalStatus + 
                  Relationship + Sex + CapitalGain + CapitalLoss,
                data = train_data, family = binomial())

# Save model
saveRDS(lr_model, "lr_model.rds")

# Make predictions
prob_predictions <- predict(lr_model, test_data, type = "response")
predictions <- ifelse(prob_predictions > 0.5, 1, 0)

# Create confusion matrix
conf_matrix <- table(Predicted = predictions, Actual = test_data$Income_Binary)

# Calculate metrics
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)

# For positive class (1 = >50K)
true_pos <- conf_matrix["1", "1"]
false_pos <- conf_matrix["1", "0"]
false_neg <- conf_matrix["0", "1"]

precision <- true_pos / (true_pos + false_pos)
recall <- true_pos / (true_pos + false_neg)

# Create metrics dataframe
metrics <- data.frame(
  Model = "Logistic Regression",
  Accuracy = accuracy,
  Precision = precision,
  Recall = recall
)

# Save metrics and confusion matrix
write.csv(metrics, "lr_metrics.csv", row.names = FALSE)
write.csv(as.data.frame.matrix(conf_matrix), "lr_confmat.csv", row.names = TRUE)

# Get coefficients for visualization
coef_summary <- summary(lr_model)$coefficients
significant_coef <- coef_summary[abs(coef_summary[,4]) < 0.05, ]
write.csv(significant_coef, "lr_coefficients.csv")

print("Logistic Regression model trained and evaluated successfully")
print(paste("Accuracy:", round(accuracy, 4)))