# Survey Analysis: Factors Influencing Voting Intentions

By Mary Babu

For this project, I analyzed a real public survey: the 1996 American National Election Study (ANES), which includes 944 respondents and is available through the Python statsmodels package. Respondents were asked whom they expected to vote for (Clinton or Dole) and also answered questions about their age, education, household income, party identification, and how often they watch TV news.

The goal was to practice the core skills of survey analysis: checking data quality, estimating a result with a margin of error, comparing respondent groups with significance tests, and testing whether an apparent pattern still holds once another factor is taken into account.

## What I Found

About 42% of respondents expected to vote for Dole and 58% for Clinton, with a margin of error of roughly 3 points.

Expected support for Dole rose with household income, from about 30% in the low income band to about 52% in the high band. A chi-square test on this difference gave a p-value far below 0.001, so on its own it looked like a strong result.

However, the pattern did not hold once I accounted for party identification. Higher-income respondents were more likely to lean Republican (33% in the low band and 56% in the high band). Within each party group, support for Dole was essentially flat across income bands: 4%, 6%, and 3% among Democratic-leaning respondents, and 85%, 87%, and 86% among Republican-leaning respondents. A logistic regression confirmed this. Income was significant on its own (p below 0.001) but not after party identification was added (p of about 0.14), while each step toward the Republican end of the party scale multiplied the odds of a Dole vote by about 3.4.

TV news frequency showed no meaningful difference. Age and education showed small differences in the raw comparisons (p of about 0.05 and 0.03). In the regression, education added nothing, and the small effect of age faded once party identification was included.

## Data Quality

There were no missing values and no values outside the expected ranges. Three rows repeat another row on the fields used in the analysis. Removing them moves the Dole share from 41.6% to 41.8%, so I kept them and noted this here.

## Limitations

This extract does not include survey weights, so the results describe these 944 respondents and not the full US electorate. The data is from 1996, and the outcome is an expected vote rather than an actual vote. The margins of error assume simple random sampling. Only 37 respondents identified as Independent, which is too few to interpret. The analysis shows associations within this sample and does not show that income or any other factor causes a particular voting choice.

## Files

- survey_analysis.ipynb: the full analysis in Python.
- survey_queries.sql: the main questions answered in SQL, covering data quality, the headline result, income bands, and the party check. It returns the same figures as the notebook.
- survey_load.sql: creates the survey table and loads the 944 rows so the queries can be run.
- survey_data.csv: the data used, six fields from the ANES extract.
- chart1.png and chart2.png: the charts from the analysis.

## Tools Used

Python (pandas, SciPy, statsmodels, matplotlib) and SQL (SQL Server and SQLite).

## How to Run

For the SQL, run survey_load.sql once to create and fill the survey table, then run the queries in survey_queries.sql one at a time. They work in both SQL Server and SQLite.

For the notebook, install the packages with "pip install pandas scipy statsmodels matplotlib" and open survey_analysis.ipynb in Jupyter.
