import openpyxl
from openpyxl_image_loader import SheetImageLoader
import os

def main():
    file_path = "k-FAN TECHNICAL DETAILS UPDATED 08.02.2026.xlsx"
    wb = openpyxl.load_workbook(file_path, data_only=True)
    sheet = wb.active
    image_loader = SheetImageLoader(sheet)

    for row in range(2, 35):
        sno = sheet[f'A{row}'].value
        model = sheet[f'C{row}'].value
        price = sheet[f'E{row}'].value
        has_image = image_loader.image_in(f'B{row}')
        
        print(f"Row {row:02d}: SNO={sno} | Model={model} | Price={price} | Image={has_image}")

if __name__ == "__main__":
    main()
