import pandas as pd
import sys

def main():
    file_path = "k-FAN TECHNICAL DETAILS UPDATED 08.02.2026.xlsx"
    print(f"Reading {file_path}...")
    
    # Read excel file and list sheets
    excel_file = pd.ExcelFile(file_path)
    print("Sheets found:", excel_file.sheet_names)
    
    for sheet_name in excel_file.sheet_names:
        print(f"\n--- Sheet: {sheet_name} ---")
        df = pd.read_excel(file_path, sheet_name=sheet_name, nrows=5)
        print("Columns:")
        print(df.columns.tolist())
        print("First few rows:")
        print(df.head(2).to_dict(orient="records"))

if __name__ == "__main__":
    main()
