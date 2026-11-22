# KNN Model Script (knn_model.R)

# Load required libraries
library(class)

# Set working directory to your project folder
# Replace with your actual path
setwd("C:/PowerBI_Assignment")

# Read data
train_data <- read.csv("Train_data.csv")
test_data <- read.csv("Test_data.csv")

# Select numeric features
numeric_features <- c("Age", "EducationNum", "HoursPerWeek", "CapitalGain", "CapitalLoss")

# Subset data
train_features <- train_data[, numeric_features]
test_features <- test_data[, numeric_features]

# Normalize the features
normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

# Apply normalization
train_features_norm <- as.data.frame(lapply(train_features, normalize))

# Save min and max values for later use in Power BI
feature_ranges <- data.frame(
  Feature = numeric_features,
  Min = sapply(train_features, min),
  Max = sapply(train_features, max)
)

write.csv(feature_ranges, "knn_ranges.csv", row.names = FALSE)

# Save normalized training data
write.csv(train_features_norm, "train_norm.csv", row.names = FALSE)

# Save training labels
train_labels <- train_data$Income
saveRDS(train_labels, "train_labels.rds")

# Normalize test data using the same transformation
test_features_norm <- data.frame(matrix(ncol = length(numeric_features), nrow = nrow(test_features)))
names(test_features_norm) <- numeric_features

for (i in 1:length(numeric_features)) {
  f_name <- numeric_features[i]
  min_val <- feature_ranges$Min[feature_ranges$Feature == f_name]
  max_val <- feature_ranges$Max[feature_ranges$Feature == f_name]
  test_features_norm[, f_name] <- (test_features[, f_name] - min_val) / (max_val - min_val)
}

# Make predictions using k=5
k <- 5
knn_predictions <- knn(train_features_norm, test_features_norm, train_labels, k = k)

# Create confusion matrix
conf_matrix <- table(Predicted = knn_predictions, Actual = test_data$Income)

# Calculate metrics
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)

# For >50K class
true_pos <- conf_matrix[">50K", ">50K"]
false_pos <- conf_matrix[">50K", "<=50K"]
false_neg <- conf_matrix["<=50K", ">50K"]

precision <- true_pos / (true_pos + false_pos)
recall <- true_pos / (true_pos + false_neg)

# Create metrics dataframe
metrics <- data.frame(
  Model = "KNN",
  Accuracy = accuracy,
  Precision = precision,
  Recall = recall
)

# Save metrics and confusion matrix
write.csv(metrics, "knn_metrics.csv", row.names = FALSE)
write.csv(as.data.frame.matrix(conf_matrix), "knn_confmat.csv", row.names = TRUE)

print("KNN model prepared and evaluated successfully")
print(paste("Accuracy:", round(accuracy, 4)))