* Encoding: UTF-8.
* ============================================================================.
* PHASE 4: FINAL SOLUTION - 3-Factor PAF/Oblimin
* ============================================================================.
* Selected solution: 3-factor Principal Axis Factoring with Direct Oblimin.
* Justification documented in Methods write-up.
*
* Settings for final reporting:
*   - No suppression of small loadings (/FORMAT SORT only, no BLANK)
*   - Full output: communalities, eigenvalues, variance, correlations
*   - All loadings shown so bolding/highlighting can be applied in Word
* ============================================================================.

FACTOR
  /VARIABLES LS1 TO LS32
  /MISSING LISTWISE
  /PRINT UNIVARIATE INITIAL KMO EXTRACTION ROTATION CORRELATION
  /PLOT EIGEN
  /CRITERIA FACTORS(3) ITERATE(25)
  /EXTRACTION PAF
  /ROTATION OBLIMIN
  /FORMAT SORT.

* NOTE: No /FORMAT BLANK(.30) - all loadings are displayed for the final report.
* Turn off the suppress small values option to display
*   all factor loadings for the final report.
* In Word, bold loadings >= .40 (primary) and italicise .30-.39 (secondary).


* ============================================================================.
* PHASE 5: RELIABILITY ANALYSIS
* ============================================================================.
* Cronbach's alpha for each factor from the 3-factor PAF/Oblimin solution.
*
* Item-to-factor mapping (from pattern matrix):
*
*   Factor 1 - Wellbeing (17 items, all positive loadings):
*     LS8  (.724) I feel a sense of purpose in my life
*     LS6  (.706) I am comfortable with who I am
*     LS28 (.688) I am generally quite happy
*     LS9  (.621) I feel I am capable of achieving my goals
*     LS4  (.581) I feel satisfied in the community
*     LS7  (.580) I believe I am a likeable person
*     LS12 (.573) I feel in control of my life
*     LS1  (.550) I am satisfied in my career
*     LS14 (.547) I am respected by others
*     LS5  (.538) I feel that I am a member of a worthwhile group
*     LS27 (.524) I laugh a lot
*     LS3  (.511) I feel my work is worth while
*     LS11 (.458) I am comfortable with my physical appearance
*     LS2  (.453) I feel respected at home
*     LS13 (.387) I am respected by my family
*     LS17 (.319) I sleep well
*     LS10 (.306) I am comfortable in my sexuality
*
*   Borderline items on F1 (loaded < .40 but included for reliability check):
*     LS32 (.449) I am content with things just as they are
*     LS31 (.310) I can't think of anything more I want in life
*     -- NOTE: LS32 and LS31 loaded .449 and .310 on F1 in the 3-factor
*        solution but emerged as a separate 2-item factor in the 4-factor 
*        solution. Including them here; alpha-if-deleted will indicate 
*        whether they belong.
*
*   Factor 2 - Health (7 items, mixed loadings - reverse coding required):
*     Positive loadings (illness direction):
*       LS22 (.652) I am often sick
*       LS19 (.617) I feel physically weak
*       LS16 (.571) I am not physically well
*       LS20 (.434) I wish I was more healthy
*     Negative loadings (health direction) - REVERSE CODE these:
*       LS15 (-.554) I consider myself to be healthy
*       LS18 (-.487) I feel physically strong
*       LS21 (-.456) I don't suffer from ailments often
*
*   Factor 3 - Resilience (5 items, mixed loadings - reverse coding required):
*     Negative loadings (adaptive direction):
*       LS29 (-.655) I cope well with change
*       LS25 (-.601) Things don't usually bother me
*       LS30 (-.587) I feel comfortable in new situations
*     Positive loadings (vulnerability direction) - REVERSE CODE these:
*       LS24 (.547) I am easy to upset
*       LS26 (.368) I feel like crying sometimes
*
*   Orphaned item (no loading >= .30 on any factor):
*     LS23 When I am sick I recover quickly - EXCLUDED from reliability
*
* Reliability analysis needs items scored in the same direction:
*   reverse-code negatively correlated items first.
* ============================================================================.


* --- Step 1: Reverse-code items with opposite-direction loadings --- .
* Scale is 1-5, so reverse = 6 - original.

* Factor 2: Reverse the health-direction items to match illness direction.
COMPUTE LS15r = 6 - LS15.
COMPUTE LS18r = 6 - LS18.
COMPUTE LS21r = 6 - LS21.
EXECUTE.

* Factor 3: Reverse the vulnerability items to match adaptive direction.
COMPUTE LS24r = 6 - LS24.
COMPUTE LS26r = 6 - LS26.
EXECUTE.

* VARIABLE LABELS
  LS15r 'I consider myself to be healthy (reversed)'
  LS18r 'I feel physically strong (reversed)'
  LS21r 'I don't suffer from ailments often (reversed)'
  LS24r 'I am easy to upset (reversed)'
  LS26r 'I feel like crying sometimes (reversed)'.


* --- Step 2: Reliability for Factor 1 - Wellbeing (19 items) --- .
* All items load positively on F1; no reverse coding needed.
* Includes borderline items LS32 and LS31 - check alpha-if-deleted.

RELIABILITY
  /VARIABLES=LS8 LS6 LS28 LS9 LS4 LS7 LS12 LS1 LS14 LS5
    LS27 LS3 LS11 LS2 LS13 LS17 LS10 LS32 LS31
  /SCALE('Factor 1 - Wellbeing') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.


* --- Step 3: Reliability for Factor 2 - Health (7 items) --- .
* Using reversed versions of LS15, LS18, LS21.
* All items now scored in illness direction (higher = worse health).

RELIABILITY
  /VARIABLES=LS22 LS19 LS16 LS20 LS15r LS18r LS21r
  /SCALE('Factor 2 - Health') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.


* --- Step 4: Reliability for Factor 3 - Resilience (5 items) --- .
* Using reversed versions of LS24, LS26.
* All items now scored in adaptive direction (higher = more resilient).

RELIABILITY
  /VARIABLES=LS29 LS25 LS30 LS24r LS26r
  /SCALE('Factor 3 - Resilience') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL.


* ============================================================================.
* AFTER RELIABILITY: DECISION POINTS
* ============================================================================.
* 1. Check overall alpha for each factor:
*      >= .70 acceptable, >= .80 good, >= .90 excellent.
*
* 2. Check "Cronbach's Alpha if Item Deleted" column:
*      If removing an item INCREASES alpha notably, consider dropping it.
*      This is especially relevant for borderline items (LS32, LS31, LS17, LS10).
*
* 3. Check "Corrected Item-Total Correlation" column:
*      Items below .30 are weak contributors and candidates for removal.
*
* 4. After finalising item retention, create composite scores:
*      COMPUTE Wellbeing = MEAN(LS8, LS6, LS28, ...).
*      COMPUTE Health = MEAN(LS22, LS19, LS16, LS20, LS15r, LS18r, LS21r).
*      COMPUTE Resilience = MEAN(LS29, LS25, LS30, LS24r, LS26r).
*      EXECUTE.
*
* 5. Proceed to dummy coding and regression.
* ============================================================================.
