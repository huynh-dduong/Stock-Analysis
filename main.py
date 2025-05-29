from functools import reduce
import os
import pandas as pd

xls_sheets = [None] * 5

# Scan though each file in the stock_data folder and aggreate all the raw data into one dataframe to output for analysis
for xls in os.scandir('stock_data'):
    for i in range(5):
        xls_sheets[i] = (pd.read_excel(xls, sheet_name=i))
        
    df = reduce(lambda left, right: pd.merge(left, right, on=['Symbol', 'Company Name'], how='inner'), xls_sheets)
    
    columns = df.columns[4:]
    mapped_keywords = {
        'Neutral': 0,
        'Negative': -1,
        'Positive': 1,
        '--': 0,
        'Buy': 1,
        'Hold': 0,
        'Sell': -1,
        'BUY': 1,
        'HOLD': 0,
        'SELL': -1,
        'Avoid': -1,
        'Long': 1,
        'NC': 0,
        'Neutral From Avoid': 0.5,
        'Neutral From Long': -0.5,
        'Equalweight': 0,
        'Overweight': 1,
        'Underweight': -1,
        'Moderate Buy': 0.5,
        'Moderate Sell': -0.5,
        'Strong Buy': 1,
        'Strong Sell': -1,
        'Bearish': 1,
        'Bullish': -1,
        '%': '',
        'x': '',
        ',':'',
        'Drop': -0.5,
        'nan': 0
    }
    
    # Iterate through each column to find if column contains a % or x in string. Then, perform approriate conversions and 
    # rename column accordingly to intuitive viewing
    for col in columns:
        df[col] = df[col].astype(str)
        
        if df[col].str.contains('%').any():           
            df[col] = df[col].replace(mapped_keywords.keys(), mapped_keywords.values(), regex=True).astype(float) / 100
            
            new_col_name = '% ' + col
            df = df.rename(columns={col: new_col_name})
        elif df[col].str.contains('x').any():
            df[col] = df[col].replace(mapped_keywords.keys(), mapped_keywords.values(), regex=True).astype(float)
                        
            if 'Ratio' not in col:
                new_col_name = col + " Ratio"
                df = df.rename(columns={col: new_col_name})
        else:
            df[col] = df[col].replace(mapped_keywords.keys(), mapped_keywords.values(), regex=True)
    
    # Either convert file into a xlsx or csv depending on use of MySQL and Tableau 
    combined_sheets_file = 'aggregated_data/combined_sheets_' + str(xls.name).replace(".xls", "") + '.csv'
    df.to_csv(combined_sheets_file, encoding='utf-8')
    
    
    # combined_sheets_file = 'aggregated_data/combined_sheets_' + str(xls.name).replace(".xls", "") + '.xlsx'
    # df.to_excel(excel_writer=combined_sheets_file, sheet_name='Master')