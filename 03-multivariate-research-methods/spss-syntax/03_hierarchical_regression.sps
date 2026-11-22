* Encoding: UTF-8.
* ============================================================================.
* PHASE 7: HIERARCHICAL MULTIPLE REGRESSION (5 blocks)
* ============================================================================.
* DV: LifeSat_Total (30-item average, higher = greater life satisfaction)
*
* Block entry order:
*   Block 1: age (continuous, foundational demographic)
*   Block 2: GENDER_N (0 = Female [ref], 1 = Male)
*   Block 3: Education dummies (ref = High School or below)
*     - EDUC_CertDip (Certificate/Diploma vs High School)
*     - EDUC_Bachelor (Bachelor vs High School)
*     - EDUC_Postgrad (Postgraduate vs High School)
*   Block 4: Marital Status dummies (ref = Single/Not currently partnered)
*     - MAR_Relation (In a relationship/De facto vs Single)
*     - MAR_Married (Married vs Single)
*     Note: Separated/Divorced/Widowed (n=13) collapsed into Single
*     per Option B -- coding by current partnership status.
*   Block 5: REL_MONTHS (relationship length in months, continuous)
*     Note: Single participants assigned REL_MONTHS = 0 reflecting
*     their current unpartnered status. Zero is substituted for
*     missing relationship length.
*
* Rationale for order:
*   Causally/conceptually prior variables enter first.
*   Age -> Gender -> Education -> Marital Status -> Relationship Length.
*   Relationship length enters last because it is conceptually dependent
*   on marital status (you must be in a relationship to have a length).
*   This ordering was chosen a priori.
* ============================================================================.


* ============================================================================.
* STEP 1: ASSUMPTION CHECKS
* ============================================================================.

* 1a. Descriptives for all variables in the model.
DESCRIPTIVES VARIABLES=LifeSat_Total age GENDER_N EDUC_CertDip EDUC_Bachelor
  EDUC_Postgrad MAR_Relation MAR_Married REL_MONTHS
  /STATISTICS=MEAN STDDEV MIN MAX.

* 1b. Bivariate correlations.
CORRELATIONS
  /VARIABLES=LifeSat_Total age GENDER_N EDUC_CertDip EDUC_Bachelor
    EDUC_Postgrad MAR_Relation MAR_Married REL_MONTHS
  /PRINT=TWOTAIL NOSIG.


* ============================================================================.
* STEP 2: HIERARCHICAL REGRESSION - LifeSat_Total as DV
* ============================================================================.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE COLLIN
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT LifeSat_Total
  /METHOD=ENTER age
  /METHOD=ENTER GENDER_N
  /METHOD=ENTER EDUC_CertDip EDUC_Bachelor EDUC_Postgrad
  /METHOD=ENTER MAR_Relation MAR_Married
  /METHOD=ENTER REL_MONTHS
  /RESIDUALS NORMPROB
  /SCATTERPLOT=(*ZRESID ,*ZPRED).


* ============================================================================.
* STEP 3 (OPTIONAL): SUPPLEMENTARY REGRESSIONS WITH SUBSCALES
* ============================================================================.
* These are supplementary explorations -- the primary model is Step 2.
* Do NOT include total score and subscales in the same model.
* ============================================================================.

* Wellbeing as DV.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Wellbeing
  /METHOD=ENTER age
  /METHOD=ENTER GENDER_N
  /METHOD=ENTER EDUC_CertDip EDUC_Bachelor EDUC_Postgrad
  /METHOD=ENTER MAR_Relation MAR_Married
  /METHOD=ENTER REL_MONTHS.

* Health as DV.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Health
  /METHOD=ENTER age
  /METHOD=ENTER GENDER_N
  /METHOD=ENTER EDUC_CertDip EDUC_Bachelor EDUC_Postgrad
  /METHOD=ENTER MAR_Relation MAR_Married
  /METHOD=ENTER REL_MONTHS.

* Resilience as DV.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Resilience
  /METHOD=ENTER age
  /METHOD=ENTER GENDER_N
  /METHOD=ENTER EDUC_CertDip EDUC_Bachelor EDUC_Postgrad
  /METHOD=ENTER MAR_Relation MAR_Married
  /METHOD=ENTER REL_MONTHS.


* ============================================================================.
* OUTPUT INTERPRETATION GUIDE
* ============================================================================.
*
* MODEL SUMMARY TABLE:
*   - R-sq Change = unique variance added by each block
*   - Sig. F Change = whether that block significantly improves prediction
*   - Final R-squared = total variance explained by all 5 blocks
*
* COEFFICIENTS TABLE (final model, Model 5):
*   - B = unstandardised coefficient
*   - Beta = standardised (for comparing relative importance)
*   - For GENDER_N: positive B means males score higher than females
*   - For EDUC dummies: B = difference from High School reference group
*   - For MAR dummies: B = difference from Single reference group
*   - For REL_MONTHS: B = change in LifeSat per additional month
*   - VIF: all should be < 10 (watch REL_MONTHS and MAR dummies
*     for elevated VIF due to conceptual overlap)
*
* RESIDUAL PLOTS:
*   - Normal P-P plot: points should follow the diagonal line
*   - ZRESID vs ZPRED scatterplot: random scatter = homoscedasticity
*
* REPORTING:
*   Report each block's change in R squared with F change and p,
*   then the full model's F, p, R squared and the significant
*   predictors with their standardised betas.
*
* MULTICOLLINEARITY NOTE:
*   REL_MONTHS and marital status dummies may show elevated VIF
*   because relationship length is structurally related to being
*   in a relationship. VIF values between 2-5 are common and
*   acceptable for dummy-coded variables. If any VIF exceeds 10
*   or SPSS gives a singularity warning, report this and consider
*   dropping Block 5.
* ============================================================================.
