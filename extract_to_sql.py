import openpyxl
# pyrefly: ignore [missing-import]
from openpyxl_image_loader import SheetImageLoader
import os
import json
import uuid

def parse_technical_details(text):
    if not text: return {}
    details = {}
    for line in text.split('\n'):
        if ':' in line:
            parts = line.split(':', 1)
            key = parts[0].strip().lower()
            val = parts[1].strip()
            
            if 'motor spec' in key: details['motor_spec'] = val
            elif 'blade type' in key: details['blade_type'] = val
            elif 'sweep' in key: details['sweep'] = val
            elif 'hight' in key or 'height' in key: details['height_of_fan'] = val
            elif 'cfm' in key: details['airflow'] = val
            elif 'body colour' in key or 'body color' in key: details['body_color'] = val
            elif 'light' in key: details['light_option'] = val
            elif 'fan type' in key: details['suitable_for'] = val
            else:
                formatted_key = key.replace(' ', '_').replace('&', 'and')
                details[formatted_key] = val
    return details

def clean_filename(name):
    # keep only alphanumeric
    return "".join([c if c.isalnum() else "_" for c in name]).strip("_")

def main():
    file_path = "k-FAN TECHNICAL DETAILS UPDATED 08.02.2026.xlsx"
    out_dir = "public/images/products"
    os.makedirs(out_dir, exist_ok=True)
    
    wb = openpyxl.load_workbook(file_path, data_only=True)
    sheet = wb.active
    image_loader = SheetImageLoader(sheet)
    
    sql_statements = [
        "DO $$",
        "DECLARE",
        "  fan_category_id uuid;",
        "BEGIN",
        "  SELECT \"categoryId\" INTO fan_category_id FROM product_categories WHERE code = 'FAN' OR name ILIKE '%fan%' LIMIT 1;",
        "  IF fan_category_id IS NULL THEN",
        "    fan_category_id := gen_random_uuid();",
        "    INSERT INTO product_categories (\"categoryId\", code, name) VALUES (fan_category_id, 'FAN', 'Fans');",
        "  END IF;",
        ""
    ]

    last_image_path = None
    last_model_name = None

    templates = {} # model_name -> template_uuid

    for row in range(2, sheet.max_row + 1):
        sno = sheet[f'A{row}'].value
        model = sheet[f'C{row}'].value
        if not model:
            continue
            
        model = str(model).strip()
        tech_text = sheet[f'D{row}'].value
        price = sheet[f'E{row}'].value
        
        if not price or not str(price).replace('.', '').isdigit():
            price = 0
            
        details = parse_technical_details(tech_text)
        
        # Image extraction
        cell_ref = f'B{row}'
        image_path = ""
        
        if image_loader.image_in(cell_ref):
            try:
                img = image_loader.get(cell_ref)
                if img.mode != 'RGB':
                    img = img.convert('RGB')
                filename = f"{clean_filename(model)}_{row}.jpg"
                img.save(os.path.join(out_dir, filename))
                image_path = f"/images/products/{filename}"
                last_image_path = image_path
            except Exception as e:
                print(f"Error saving image at {cell_ref}: {e}")
                image_path = last_image_path if (model == last_model_name) else ""
        else:
            # Check adjacent cell if no image found here, sometimes anchors are messed up
            # Or just inherit from last if same model
            if model == last_model_name and last_image_path:
                image_path = last_image_path
            else:
                # Let's try row-1 or row+1 just in case
                if image_loader.image_in(f'B{row-1}'):
                    try:
                        img = image_loader.get(f'B{row-1}')
                        filename = f"{clean_filename(model)}_{row}.jpg"
                        if img.mode != 'RGB': img = img.convert('RGB')
                        img.save(os.path.join(out_dir, filename))
                        image_path = f"/images/products/{filename}"
                    except: pass
                elif image_loader.image_in(f'B{row+1}'):
                    try:
                        img = image_loader.get(f'B{row+1}')
                        filename = f"{clean_filename(model)}_{row}.jpg"
                        if img.mode != 'RGB': img = img.convert('RGB')
                        img.save(os.path.join(out_dir, filename))
                        image_path = f"/images/products/{filename}"
                    except: pass
        
        last_model_name = model
        if image_path:
            details['media'] = { "primaryImage": image_path }
        
        sku_family = f"FAN-{clean_filename(model)}"
        # Insert template if not exists
        if sku_family not in templates:
            template_id = str(uuid.uuid4())
            templates[sku_family] = template_id
            name_escaped = model.replace("'", "''")
            
            sql_statements.append(f"""
  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('{template_id}', '{sku_family}', '{name_escaped}', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;
""")
        
        template_id = templates[sku_family]
        variant_id = str(uuid.uuid4())
        sku = f"FAN-{clean_filename(model)}-{row}"
        variant_name_escaped = model.replace("'", "''")
        attributes_json = json.dumps(details).replace("'", "''")
        
        sql_statements.append(f"""
  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('{variant_id}', '{template_id}', '{sku}', '{variant_name_escaped}', {price}, {price}, true, true, '{attributes_json}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;
""")
        
    sql_statements.append("END $$;")
    
    with open('insert_data.sql', 'w', encoding='utf-8') as f:
        f.write("\n".join(sql_statements))
        
    print("Done. Generated insert_data.sql")

if __name__ == "__main__":
    main()
