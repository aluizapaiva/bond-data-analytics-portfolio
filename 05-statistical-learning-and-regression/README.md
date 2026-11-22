# Statistical Learning and Regression Models

**Unit:** DTSC71-302 Statistical Learning and Regression Models
**Tools:** R (lme4, nlme, mgcv, emmeans, MuMIn, ggeffects, tidyverse)

## After the Flames: how Australian ecosystems recover from bushfire

Project analysing bird survey data collected after the 2019-20 Black Summer bushfires, to answer which sites should be prioritised for monitoring, what recovery benchmarks are realistic and how long recovery takes.

The analysis compares linear mixed-effects models, generalised additive models and regularised regression, and checks model quality with the `performance` package.

## Files

- `bushfire-bird-recovery/Report.docx`: the written report, aimed at land managers.
- `bushfire-bird-recovery/analysis.Rmd`: full analysis code.
- `bushfire-bird-recovery/analysis.html`: rendered analysis with tables and figures.

## Notes

The survey data is not included. To rerun the analysis, place the data files in a `data/` folder next to the `.Rmd`.
