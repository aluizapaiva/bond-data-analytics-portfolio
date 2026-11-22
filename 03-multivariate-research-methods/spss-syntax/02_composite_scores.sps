* Encoding: UTF-8.
* ============================================================================.
* PHASE 6: COMPOSITE SCORES AND REGRESSION PREPARATION
* ============================================================================.
* After EFA and reliability analysis, create composite scores (subscale means)
* for use as dependent variables or predictors in regression.
*
* Item retention decisions:
*   REMOVED: LS10 (I am comfortable in my sexuality)
*     - Lowest communality in solution (.121)
*     - Borderline pattern coefficient (.306)
*     - Lowest item-total correlation on Factor 1 (.302)
*     - Three converging points of evidence for exclusion
*
*   REMOVED: LS23 (When I am sick I recover quickly)
*     - No loading >= .30 on any factor
*     - Communality = .156 (orphaned item)
*
*   RETAINED WITH FLAG: LS26r (I feel like crying sometimes)
*     - Weakest item on Factor 3 (item-total r = .341)
*     - Deletion would improve alpha (.715 to .729) but leave only 4 items
*     - Flagged for future scale refinement
*
*   RETAINED WITH FLAG: LS31 (I can't think of anything more I want in life)
*     - Borderline loading (.310), alpha increases on deletion (.880)
*     - Emerged as separate factor in 4-factor solution
*     - Retained for theoretical coverage; flagged for refinement
*
* Scoring direction:
*   All composites scored so that HIGHER = MORE of the construct.
*   Wellbeing: higher = greater wellbeing (original scoring)
*   Health: higher = BETTER health (reverse the illness items)
*   Resilience: higher = MORE resilient (reverse vulnerability items)
* ============================================================================.


* --- Step 1: Reverse-code items for composites --- .
* Already created in Phase 5: LS15r, LS18r, LS21r, LS24r, LS26r.
* For Health composite scored as "better health = higher":
*   Use ORIGINAL LS15, LS18, LS21 (health-direction, already high=good)
*   Reverse the ILLNESS items so high = good health.

COMPUTE LS22r = 6 - LS22.
COMPUTE LS19r = 6 - LS19.
COMPUTE LS16r = 6 - LS16.
COMPUTE LS20r = 6 - LS20.
EXECUTE.

VARIABLE LABELS
  LS22r 'I am often sick (reversed: higher = healthier)'
  LS19r 'I feel physically weak (reversed: higher = healthier)'
  LS16r 'I am not physically well (reversed: higher = healthier)'
  LS20r 'I wish I was more healthy (reversed: higher = healthier)'.


* --- Step 2: Create composite scores (subscale means) --- .

* Factor 1 - Wellbeing (18 items after removing LS10).
* All items scored so higher = greater wellbeing.
COMPUTE Wellbeing = MEAN(LS8, LS6, LS28, LS9, LS4, LS7, LS12, LS1,
  LS14, LS5, LS27, LS3, LS11, LS2, LS13, LS17, LS32, LS31).
EXECUTE.

* Factor 2 - Health (7 items, all scored so higher = better health).
* Use original health-direction items (LS15, LS18, LS21) plus
* reversed illness items (LS22r, LS19r, LS16r, LS20r).
COMPUTE Health = MEAN(LS15, LS18, LS21, LS22r, LS19r, LS16r, LS20r).
EXECUTE.

* Factor 3 - Resilience (5 items, all scored so higher = more resilient).
* Use original adaptive items (LS29, LS25, LS30) plus
* reversed vulnerability items (LS24r, LS26r).
COMPUTE Resilience = MEAN(LS29, LS25, LS30, LS24r, LS26r).
EXECUTE.

VARIABLE LABELS
  Wellbeing 'Wellbeing subscale (18 items, higher = greater wellbeing)'
  Health 'Health subscale (7 items, higher = better health)'
  Resilience 'Resilience subscale (5 items, higher = more resilient)'.


* --- Step 3: Check composite descriptives --- .
DESCRIPTIVES VARIABLES=Wellbeing Health Resilience
  /STATISTICS=MEAN STDDEV MIN MAX.


* ============================================================================.
* NOTES FOR REGRESSION
* ============================================================================.
* The three composite scores (Wellbeing, Health, Resilience) can now be used
* as dependent variables or predictors in regression analysis.
*
* If the assignment requires predicting overall life satisfaction from
* demographic/categorical variables:
*   - Dummy-code categorical predictors (see Week 7 notes)
*   - Use hierarchical regression entering blocks as specified
*   - The composites are continuous DVs suitable for linear regression
*
* If using all three as DVs, run separate regressions for each
* (or MANOVA if comparing group differences across all three).
* ============================================================================.
