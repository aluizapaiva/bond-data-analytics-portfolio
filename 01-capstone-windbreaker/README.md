# Windbreaker: Campaign Recommendation Engine

**Unit:** DTSC71-304 Applied Data Analytics Project (capstone, with a real agency partner)
**Tools:** Python, pandas, XGBoost, scikit-learn, seaborn, Google Colab

## The problem

An advertising agency runs Meta campaigns for several clients and optimises them by hand. The goal was a system that learns from historical campaign data and tells the team which campaigns need attention and what to change.

## What I built

The notebook runs the full pipeline in three phases.

1. **Data.** Consolidated daily and monthly campaign exports from five clients, standardised the columns, aligned features across clients and built goal-specific KPIs: cost per lead (CPL) for lead-generation clients and cost per purchase (CPT) for e-commerce clients.
2. **Model.** Trained XGBoost models on the engineered features, then evaluated them with stratified cross-validation and feature importance.
3. **Alerting.** Turned model output into recommendations using threshold rules and a confidence check (binary sigmoid framework), and produced a baseline metrics report for the agency team.

## Files

- `windbreaker_recommendation_engine.ipynb`: the full notebook, 16 sections.
- `windbreaker_recommendation_engine.py`: the same code as a script.

## Notes

- Client names are replaced with Client A to E. Names of the agency, client contacts and advisors are removed, and quotes from meetings are paraphrased.
- Notebook outputs are cleared because they contained client campaign results. The raw data is not included.
- The notebook mounts Google Drive and expects the project data in a `<project-folder>`, so it will not run without the original exports.
