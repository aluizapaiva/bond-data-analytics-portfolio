# K-means Clustering Script (kmeans_model.R)

# Load required libraries
library(stats)
library(ggplot2)

# Set working directory to your project folder
# Replace with your actual path
setwd("C:/PowerBI_Assignment")

# Read data
train_data <- read.csv("Train_data.csv")

# Select numeric features for clustering
numeric_features <- c("Age", "EducationNum", "HoursPerWeek", "CapitalGain", "CapitalLoss")

# Subset data
train_features <- train_data[, numeric_features]

# Normalize the features
normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

train_features_norm <- as.data.frame(lapply(train_features, normalize))

# Save min and max values for later normalization in Power BI
feature_ranges <- data.frame(
  Feature = numeric_features,
  Min = sapply(train_features, min),
  Max = sapply(train_features, max)
)

write.csv(feature_ranges, "kmeans_ranges.csv", row.names = FALSE)

# Use k=2 for simplicity (matching income classes)
k <- 2

# Train K-means model
set.seed(123) # For reproducibility
kmeans_model <- kmeans(train_features_norm, centers = k)

# Save model centers
centers <- as.data.frame(kmeans_model$centers)
write.csv(centers, "kmeans_centers.csv", row.names = TRUE)

# Add cluster assignment to training data
train_data$Cluster <- kmeans_model$cluster

# Check distribution of income classes in each cluster
cluster_income_dist <- table(Cluster = train_data$Cluster, Income = train_data$Income)
write.csv(as.data.frame.matrix(cluster_income_dist), "cluster_income_dist.csv", row.names = TRUE)

# Create a 2D projection using PCA for visualization
pca_result <- prcomp(train_features_norm, scale. = FALSE)

# Extract the first two principal components
pca_data <- as.data.frame(pca_result$x[, 1:2])
pca_data$Cluster <- as.factor(kmeans_model$cluster)
pca_data$Income <- train_data$Income

# Save PCA coordinates for a sample to display in Power BI
set.seed(456)
sample_indices <- sample(1:nrow(pca_data), 1000)
sample_pca <- pca_data[sample_indices, ]
write.csv(sample_pca, "sample_pca.csv", row.names = FALSE)

# Save PCA transformation matrix for use in Power BI
write.csv(pca_result$rotation[, 1:2], "pca_rotation.csv", row.names = TRUE)

# Create and save visualization
png("kmeans_plot.png", width = 800, height = 600)
ggplot(sample_pca, aes(x = PC1, y = PC2, color = Cluster, shape = Income)) +
  geom_point(alpha = 0.6) +
  labs(title = "K-means Clustering (2D PCA Projection)") +
  theme_minimal()
dev.off()

print("K-means clustering completed successfully")
print("Income distribution by cluster:")
print(cluster_income_dist)