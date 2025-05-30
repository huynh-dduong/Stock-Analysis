--  Business Problem: Industry Performance Comparison
SELECT 
    industry,
    ROUND(AVG(COALESCE(`beta`, 0)
    ), 2) AS month_industry_beta,
	ROUND(AVG(
        COALESCE(`4_week_pct_chg_v_sp500`, 0)
    ), 2) AS month_industry_performance_avg_v_sp500,
	ROUND(AVG(
        COALESCE(`13_week_pct_chg_v_sp500`, 0)
    ), 2) AS three_month_industry_performance_avg_v_sp500,
	ROUND(AVG(
        COALESCE(`52_week_pct_chg_v_sp500`, 0)
    ), 2) AS year_industry_performance_avg_v_sp500,
    ROUND(AVG(
        COALESCE(`4_week_pct_chg_v_sp500`, 0) + 
        COALESCE(`13_week_pct_chg_v_sp500`, 0) + 
        COALESCE(`52_week_pct_chg_v_sp500`, 0)
    ), 2) AS overall_industry_performance_avg_v_sp500
FROM master
GROUP BY industry
ORDER BY overall_industry_performance_avg_v_sp500 DESC
LIMIT 10;

-- Risk and Return Analysis of Stocks 
SELECT 
    industry,
	ROUND(AVG(COALESCE(`beta`, 0)
    ), 2) AS month_industry_beta,
	ROUND(AVG(
        COALESCE(`5_day_pct_chg`, 0)
    ), 2) AS five_day_industry_priceperformance_avg,
	ROUND(AVG(
        COALESCE(`4_week_pct_chg`, 0)
    ), 2) AS month_industry_priceperformance_avg,
	ROUND(AVG(
        COALESCE(`52_week_pct_chg`, 0)
    ), 2) AS year_industry_priceperformance_avg,
    ROUND(AVG(
        COALESCE(`5_day_pct_chg`, 0) + 
        COALESCE(`4_week_pct_chg`, 0) + 
        COALESCE(`52_week_pct_chg`, 0)
    ), 2) AS overall_industry_priceperformance_avg
FROM master
GROUP BY industry
ORDER BY overall_industry_priceperformance_avg DESC
LIMIT 10;

SELECT * FROM master;
