* ============================================================.
* DEMOGRAPHIC CROSS-TABULATION: Gender x Age Group
* File: 07. DATA_Clean_File2903_phase6_Regression_subscales.sav
* Purpose: Participants section — describe sample composition
*          and test whether gender is evenly distributed across
*          age groups.
* ============================================================.

* ---- STAGE 1: Get your actual tertile cutpoints ---- .
* Run this FIRST, then read the output before proceeding.

FREQUENCIES VARIABLES=AGE
  /FORMAT=NOTABLE
  /STATISTICS=MINIMUM MAXIMUM MEAN STDDEV MEDIAN
  /PERCENTILES=33.33 66.67.

* ---- READ YOUR OUTPUT ---- .
* Look at the 33.33 and 66.67 percentile values.
* Use those as your cutpoints in the RECODE below.
* For example, if 33rd = 23 and 67th = 34, use those.
* The goal is roughly equal group sizes (approx 1/3 each).

* ---- STAGE 2: Create age groups ---- .
* REPLACE the cutpoint values below with YOUR percentiles.
* Example: if 33rd percentile = 23 and 67th = 34:

RECODE AGE
  (LOWEST thru 23 = 1)
  (24 thru 34 = 2)
  (35 thru HIGHEST = 3)
  INTO AgeGroup.
VARIABLE LABELS AgeGroup 'Age Group (Tertiles)'.
VALUE LABELS AgeGroup
  1 'Youngest (17-23)'
  2 'Middle (24-34)'
  3 'Oldest (35-78)'.
EXECUTE.

* Check group sizes — should be roughly equal thirds.
FREQUENCIES VARIABLES=AgeGroup.

* ---- STAGE 3: Cross-tabulation with chi-square ---- .
* This produces the cross-tabulation with the chi-square test.

CROSSTABS
  /TABLES=newgen BY AgeGroup
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT COLUMN TOTAL
  /COUNT ROUND CELL.

* ---- INTERPRETATION GUIDE ---- .
* 1. Report the Pearson Chi-Square value, df, and p.
* 2. Report column percentages for each cell.
* 3. Non-significant chi-square = ideal (gender evenly spread).
* 4. Significant = describe the pattern (e.g., youngest third
*    is disproportionately female).
*
* For the report, write something like:
*   "To examine sample composition, age was temporarily
*    categorised into tertiles (youngest: 17-XX; middle:
*    XX-XX; oldest: XX-78). A chi-square test of independence
*    indicated that gender distribution [was / was not]
*    significantly associated with age group,
*    chi-square(2) = X.XX, p = .XXX. Column percentages
*    indicated that [describe pattern]."

* ---- CLEANUP ---- .
* After you have your output, delete AgeGroup.
* It was only for demographic description, NOT for regression.
* DELETE VARIABLES AgeGroup.
* (Uncomment the line above when ready to clean up.)
