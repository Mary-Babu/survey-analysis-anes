USE survey_db;
GO


SELECT COUNT(*) FROM survey;

-- Query 1
SELECT COUNT(*) AS respondents,
       SUM(CASE WHEN TVnews IS NULL OR PID IS NULL OR age IS NULL
                  OR educ IS NULL OR income IS NULL OR vote IS NULL THEN 1 ELSE 0 END) AS rows_with_missing
FROM survey;

-- Query 2
SELECT SUM(copies - 1) AS repeated_rows
FROM (SELECT COUNT(*) AS copies
      FROM survey
      GROUP BY TVnews, PID, age, educ, income, vote
      HAVING COUNT(*) > 1) AS repeats;

-- Query 3
SELECT ROUND(100.0 * AVG(vote * 1.0), 1)       AS dole_pct,
       ROUND(100.0 * (1 - AVG(vote * 1.0)), 1) AS clinton_pct
FROM survey;

-- Query 4
SELECT income_band,
       COUNT(*) AS n,
       ROUND(100.0 * AVG(vote * 1.0), 1) AS dole_pct
FROM (SELECT vote,
             CASE WHEN income <= 15 THEN '1 Low'
                  WHEN income <= 20 THEN '2 Mid'
                  ELSE '3 High' END AS income_band
      FROM survey) AS banded
GROUP BY income_band
ORDER BY income_band;

-- Query 5
SELECT income_band,
       ROUND(100.0 * AVG(rep_flag * 1.0), 1) AS rep_leaning_pct
FROM (SELECT CASE WHEN PID >= 4 THEN 1 ELSE 0 END AS rep_flag,
             CASE WHEN income <= 15 THEN '1 Low'
                  WHEN income <= 20 THEN '2 Mid'
                  ELSE '3 High' END AS income_band
      FROM survey) AS banded
GROUP BY income_band
ORDER BY income_band;

-- Query 6
SELECT party_group,
       income_band,
       COUNT(*) AS n,
       ROUND(100.0 * AVG(vote * 1.0), 1) AS dole_pct
FROM (SELECT vote,
             CASE WHEN PID <= 2 THEN 'Dem-leaning' ELSE 'Rep-leaning' END AS party_group,
             CASE WHEN income <= 15 THEN '1 Low'
                  WHEN income <= 20 THEN '2 Mid'
                  ELSE '3 High' END AS income_band
      FROM survey
      WHERE PID <> 3) AS banded
GROUP BY party_group, income_band
ORDER BY party_group, income_band;