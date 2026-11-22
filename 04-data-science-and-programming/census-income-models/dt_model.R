# Decision Tree Model Script (dt_model.R)

# Load required libraries
library(rpart)
library(rpart.plot)

# Set working directory to your project folder
# Replace with your actual path
setwd("C:/PowerBI_Assignment")  # Use backslashes for Windows

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

# Convert Income to factor
train_data$Income <- as.factor(train_data$Income)
test_data$Income <- as.factor(test_data$Income)

# Train decision tree model
dt_model <- rpart(Income ~ Age + EducationNum + HoursPerWeek + MaritalStatus + 
                    Relationship + Sex + CapitalGain + CapitalLoss,
                  data = train_data, method = "class")

# Save model
saveRDS(dt_model, "dt_model.rds")

# Evaluate on test data
predictions <- predict(dt_model, test_data, type = "class")
conf_matrix <- table(Predicted = predictions, Actual = test_data$Income)

# Calculate metrics
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)

# For >50K class (assuming ">50K" is one of the levels)
true_pos <- conf_matrix[">50K", ">50K"]
false_pos <- sum(conf_matrix[">50K", ]) - true_pos
false_neg <- sum(conf_matrix[, ">50K"]) - true_pos

precision <- true_pos / (true_pos + false_pos)
recall <- true_pos / (true_pos + false_neg)

# Create metrics dataframe
metrics <- data.frame(
  Model = "Decision Tree",
  Accuracy = accuracy,
  Precision = precision,
  Recall = recall
)

# Save metrics and confusion matrix
write.csv(metrics, "dt_metrics.csv", row.names = FALSE)
write.csv(as.data.frame.matrix(conf_matrix), "dt_confmat.csv", row.names = TRUE)

# Plot and save the decision tree visualization
png("dt_plot.png", width = 800, height = 600)
rpart.plot(dt_model, 
           type = 4,
           extra = 101,
           fallen.leaves = TRUE,
           main = "Decision Tree for Income Prediction",
           box.palette = "Blues")
dev.off()

print("Decision Tree model trained and evaluated successfully")
print(paste("Accuracy:", round(accuracy, 4)))