-- Aggregate all tables into master sheet 
CREATE TABLE master SELECT * FROM
    combined_sheets_nasdaq 
UNION SELECT 
    *
FROM
    combined_sheets_nyse 
UNION SELECT 
    *
FROM
    combined_sheets_sp500;

-- Drop duplicate or unnecessary columns
ALTER TABLE master
DROP COLUMN MyUnknownColumn, 
DROP COLUMN `% 5 Day Chg_y`,
DROP COLUMN `% 4 Week Chg_y`;

-- Rename columns to practice standard naming convention 
ALTER TABLE master 
CHANGE COLUMN `Symbol` `symbol` VARCHAR(255),
CHANGE COLUMN `Company Name` `company_name` VARCHAR(255),
CHANGE COLUMN `Industry` `industry` VARCHAR(255),
CHANGE COLUMN `Prior Close` `prior_close` VARCHAR(255),
CHANGE COLUMN `% 5 Day Chg_x` `5_day_pct_chg` VARCHAR(255),
CHANGE COLUMN `% 4 Week Chg_x` `4_week_pct_chg` VARCHAR(255),
CHANGE COLUMN `% 52 Week Chg` `52_week_pct_chg` VARCHAR(255),
CHANGE COLUMN `Mkt Cap` `mkt_cap` VARCHAR(255),
CHANGE COLUMN `Refinitiv` `refinitiv` VARCHAR(255),
CHANGE COLUMN `Argus Analyst` `argus_analyst` VARCHAR(255),
CHANGE COLUMN `Argus A6 Quantitative` `argus_a6_quant` VARCHAR(255),
CHANGE COLUMN `MarketEdge` `marketedge` VARCHAR(255),
CHANGE COLUMN `Morgan Stanley` `morgan_stanley` VARCHAR(255),
CHANGE COLUMN `SmartConsensus` `smartconsensus` VARCHAR(255),
CHANGE COLUMN `Thomson Reuters Consensus` `thomson_reuters_consensus` VARCHAR(255),
CHANGE COLUMN `TipRanks Analyst Consensus` `tipranks_analyst_consensus` VARCHAR(255),
CHANGE COLUMN `TipRanks Blogger Sentiment` `tipranks_blogger_sentiment` VARCHAR(255),
CHANGE COLUMN `% Vs. S&P 500 4 Weeks` `4_week_pct_chg_v_sp500` VARCHAR(255),
CHANGE COLUMN `% Vs. S&P 500 13 Weeks` `13_week_pct_chg_v_sp500` VARCHAR(255),
CHANGE COLUMN `% Vs. S&P 500 52 Weeks` `52_week_pct_chg_v_sp500` VARCHAR(255),
CHANGE COLUMN `Beta` `beta` VARCHAR(255),
CHANGE COLUMN `P/E Ratio (TTM)*` `pe_ratio` VARCHAR(255),
CHANGE COLUMN `PEG Ratio` `peg_ratio` VARCHAR(255),
CHANGE COLUMN `Price/Sales Ratio` `price_sales_ratio` VARCHAR(255),
CHANGE COLUMN `Price/Book Ratio` `price_book_ratio` VARCHAR(255),
CHANGE COLUMN `Price/Cash Flow Ratio` `price_cashflow_ratio` VARCHAR(255),
CHANGE COLUMN `Debt to Capital Ratio` `debt_capital_ratio` VARCHAR(255),
CHANGE COLUMN `% Return on Equity` `pct_return_equity` VARCHAR(255),
CHANGE COLUMN `% Return on Assets` `pct_return_assets` VARCHAR(255),
CHANGE COLUMN `% EPS Growth CFY*` `pct_eps_gwth_cfy` VARCHAR(255),
CHANGE COLUMN `% EPS Growth NFY*` `pct_eps_gwth_nfy` VARCHAR(255),
CHANGE COLUMN `% Revenue Growth CFY*` `pct_rev_gwth_cfy` VARCHAR(255),
CHANGE COLUMN `% Revenue Growth NFY*` `pct_rev_gwth_nfy` VARCHAR(255),
CHANGE COLUMN `% Dividend Yield` `pct_div_yield` VARCHAR(255),
CHANGE COLUMN `% Dividend Growth 5 Year` `pct_div_yield_5_year` VARCHAR(255);


SELECT 
    *
FROM
    master;

