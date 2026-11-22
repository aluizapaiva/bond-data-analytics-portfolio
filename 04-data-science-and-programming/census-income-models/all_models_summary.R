# All Models Summary Script (all_models_summary.R)

# Set working directory to your project folder
# Replace with your actual path
setwd("C:/PowerBI_Assignment")

# Read metrics files
dt_metrics <- read.csv("dt_metrics.csv")
lr_metrics <- read.csv("lr_metrics.csv")
knn_metrics <- read.csv("knn_metrics.csv")

# Combine all metrics
all_metrics <- rbind(dt_metrics, lr_metrics, knn_metrics)

# Add K-means information
# Since K-means is unsupervised, we'll use cluster-income correspondence
cluster_income <- read.csv("cluster_income_dist.csv")
names(cluster_income) <- c("Cluster", "LessThan50K", "MoreThan50K")

# Calculate accuracy-like metric for K-means
total_samples <- sum(cluster_income$LessThan50K) + sum(cluster_income$MoreThan50K)
correct_assignments <- 0

# Assuming Cluster 1 corresponds to <=50K and Cluster 2 to >50K
# We can check which cluster has majority of which income class
for (i in 1:nrow(cluster_income)) {
  if (cluster_income$LessThan50K[i] > cluster_income$MoreThan50K[i]) {
    # This cluster mostly contains <=50K
    correct_assignments <- correct_assignments + cluster_income$LessThan50K[i]
  } else {
    # This cluster mostly contains >50K
    correct_assignments <- correct_assignments + cluster_income$MoreThan50K[i]
  }
}

kmeans_accuracy <- correct_assignments / total_samples

# Add K-means metrics (approximation)
kmeans_metrics <- data.frame(
  Model = "K-means Clustering",
  Accuracy = kmeans_accuracy,
  Precision = NA,  # Not applicable in the same way
  Recall = NA      # Not applicable in the same way
)

# Add to the combined metrics
all_metrics <- rbind(all_metrics, kmeans_metrics)

# Save combined metrics
write.csv(all_metrics, "all_models_metrics.csv", row.names = FALSE)

print("All models summary created successfully")
print(all_metrics)