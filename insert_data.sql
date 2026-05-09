DO $$
DECLARE
  fan_category_id uuid;
BEGIN
  SELECT "categoryId" INTO fan_category_id FROM product_categories WHERE code = 'FAN' OR name ILIKE '%fan%' LIMIT 1;
  IF fan_category_id IS NULL THEN
    fan_category_id := gen_random_uuid();
    INSERT INTO product_categories ("categoryId", code, name) VALUES (fan_category_id, 'FAN', 'Fans');
  END IF;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('9b31b418-a7c9-48a9-82f2-d1c3529dff4b', 'FAN-DUAL', 'DUAL', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('057af664-6924-4348-929b-186644da266e', '9b31b418-a7c9-48a9-82f2-d1c3529dff4b', 'FAN-DUAL-2', 'DUAL', 81770, 81770, true, true, '{"blade_type": "Real Dark wooden blades/ 8 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52X2in", "height_of_fan": "1900mm / 74in", "motor_spec": "188 x 18 / copper winding A/C motor", "airflow": "9180 x 2", "body_color": "Black Hand Painted", "media": {"primaryImage": "/images/products/DUAL_2.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('9eb7c6c6-1e86-4470-bf01-537c61c82a04', 'FAN-INNOVATION', 'INNOVATION', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('64930fcc-f201-4869-9c46-8e95072e9dea', '9eb7c6c6-1e86-4470-bf01-537c61c82a04', 'FAN-INNOVATION-3', 'INNOVATION', 72770, 72770, true, true, '{"blade_type": "No Blade / Pine Wood / ABS blades", "suitable_for": "Ceiling", "sweep": "738mm / D29in                                                                                                                                                                                                                                                                                                                                                                                           Hight:1900mm / 19in", "light_option": "LED 3000, 4000 & 6000k 36watts", "motor_spec": "153 x 40 / copper winding D/C motor", "airflow": "6150", "colour": "Pine Wood"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('75d13c4b-b8ba-4928-ab5b-78a262fe9e7f', '9eb7c6c6-1e86-4470-bf01-537c61c82a04', 'FAN-INNOVATION-4', 'INNOVATION', 58770, 58770, true, true, '{"blade_type": "No Blade / ABS", "suitable_for": "Ceiling", "sweep": "738mm / D29in                                                                                                                                                                                                                                                                                                                                                                                           Hight:1900mm / 19in", "light_option": "LED 3000, 4000 & 6000k 36watts", "motor_spec": "153 x 40 / copper winding D/C motor", "airflow": "6150", "colour": "White", "media": {"primaryImage": "/images/products/INNOVATION_4.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('94c660e5-3ce1-4e5c-8bf4-f0f86f5fdca3', '9eb7c6c6-1e86-4470-bf01-537c61c82a04', 'FAN-INNOVATION-5', 'INNOVATION', 60770, 60770, true, true, '{"blade_type": "No Blade / ABS", "suitable_for": "Ceiling", "sweep": "738mm / D29in                                                                                                                                                                                                                                                                                                                                                                                          Hight:1900mm / 19in", "light_option": "LED 3000, 4000 & 6000k 36watts", "motor_spec": "153 x 40 / copper winding D/C motor", "airflow": "6150", "colour": "Dark Coffee", "media": {"primaryImage": "/images/products/INNOVATION_5.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('6651ab5b-bdbb-4569-b992-d5d5960f77ff', 'FAN-CINDRELLA', 'CINDRELLA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('0a1f7e5f-3417-40b0-bbba-a4f34c1ef12b', '6651ab5b-bdbb-4569-b992-d5d5960f77ff', 'FAN-CINDRELLA-6', 'CINDRELLA', 46770, 46770, true, true, '{"blade_type": "French Gold / 3 blades", "suitable_for": "Ceiling", "sweep": "508mm / D20in", "height_of_fan": "508mm / 20in", "light_option": "LED 4000k x 3 / 35watts", "motor_spec": "155x 12 / copper winding D/C motor", "airflow": "8010 Summer /Winter option", "colour": "French Gold", "media": {"primaryImage": "/images/products/CINDRELLA_6.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('a3770c00-fa39-4b61-86aa-be87711feed5', 'FAN-TRIO', 'TRIO', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('24007d9e-9a3b-404e-9ea0-7f8ba8fa6869', 'a3770c00-fa39-4b61-86aa-be87711feed5', 'FAN-TRIO-7', 'TRIO', 50770, 50770, true, true, '{"blade_type": "Special wooden / 9 blades", "suitable_for": "Ceiling", "sweep": "965 mm / D 38in", "height_of_fan": "482mm / 18in", "light_option": "LED 3000, 4000 & 6000k 12watts", "motor_spec": "78 x 20 x 3 / copper winding A/C motor", "airflow": "9400", "oscillation": "360\u00ba wide-angle", "colour": "Gun Metal"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('d434c09c-a3da-4b69-855e-03dc33dea55c', 'a3770c00-fa39-4b61-86aa-be87711feed5', 'FAN-TRIO-8', 'TRIO', 50770, 50770, true, true, '{"blade_type": "Special wooden / 9 blades", "suitable_for": "Ceiling", "sweep": "965 mm / D38in", "height_of_fan": "482mm / 18in", "light_option": "LED 3000, 4000 & 6000k 12watts", "motor_spec": "78 x 20 x 3 / copper winding A/C motor", "airflow": "9400", "oscillation": "360\u00ba wide-angle", "colour": "Chrome", "media": {"primaryImage": "/images/products/TRIO_8.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('79d3d334-dc35-4e47-b78c-ac1614865bff', 'FAN-MATRIX', 'MATRIX', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('11d84d34-8e26-4d18-8a24-6790e4d5b53e', '79d3d334-dc35-4e47-b78c-ac1614865bff', 'FAN-MATRIX-9', 'MATRIX', 35770, 35770, true, true, '{"blade_type": "No Blade / ABS", "suitable_for": "Air purifier / Tower Fan", "height_of_fan": "1066mm / D 42in", "wind_speed": "1-10  / Sleeper Timer: 1-12h", "noise_level": "40DB (5%) / D/C motor", "oscillation": "55\u00ba wide-angle", "colour": "Grey Silver", "media": {"primaryImage": "/images/products/MATRIX_9.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('cc01fd20-4605-46c1-9776-3b38552ff031', '79d3d334-dc35-4e47-b78c-ac1614865bff', 'FAN-MATRIX-10', 'MATRIX', 35770, 35770, true, true, '{"blade_type": "No Blade / ABS", "suitable_for": "Air purifier / Tower Fan", "height_of_fan": "1066mm / D 42in", "wind_speed": "1-10  / Sleeper Timer: 1-12h", "noise_level": "40DB (5%) / D/C motor", "oscillation": "55\u00ba wide-angle", "colour": "Grey+Gun Grey", "media": {"primaryImage": "/images/products/MATRIX_10.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('f709133c-982c-4482-8582-985f768d9b80', 'FAN-DESKY', 'DESKY', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('97f438ee-d019-404e-919a-0b5b5d34ca57', 'f709133c-982c-4482-8582-985f768d9b80', 'FAN-DESKY-11', 'DESKY', 17770, 17770, true, true, '{"blade_type": "No Blade / ABS", "suitable_for": "Table Fan", "height_of_fan": "622mm / 24", "wind_speed": "1-10 /  Sleeper Timer: 1-9h", "noise_level": "34-53DB / D/C Motor", "oscillation": "120\u00ba wide-angle", "colours": "White", "media": {"primaryImage": "/images/products/DESKY_11.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('d23ce73a-9747-4c31-ae09-ec16d5564315', 'FAN-OPUS', 'OPUS', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('c1ae8153-2c1e-4b33-b0a4-d668b63028c3', 'd23ce73a-9747-4c31-ae09-ec16d5564315', 'FAN-OPUS-12', 'OPUS', 30770, 30770, true, true, '{"blade_type": "Real Dark Wooden / 4 blades", "suitable_for": "Ceiling", "sweep": "863mm / D 34in", "height_of_fan": "9100mm / 74in", "motor_spec": "188 x 18 / copper winding A/C motor", "airflow": "7350 Summer /Winter option", "colour": "Black Hand Painted", "media": {"primaryImage": "/images/products/OPUS_12.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b6c7da14-ff2a-44e9-8397-67764d872707', 'd23ce73a-9747-4c31-ae09-ec16d5564315', 'FAN-OPUS-13', 'OPUS', 30770, 30770, true, true, '{"blade_type": "Real Pine Wooden / 4 blades", "suitable_for": "Ceiling", "sweep": "863mm / D 34in", "height_of_fan": "9100mm / 74in", "motor_spec": "188 x 18 / copper winding A/C motor", "airflow": "7350 Summer /Winter option", "colour": "Black Hand Painted", "media": {"primaryImage": "/images/products/OPUS_13.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('04986932-d6b5-4f3b-ad96-ce8a8f8facf8', 'FAN-OPUS_WALL', 'OPUS WALL', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('c7b7c36c-7a7d-432c-929c-03402b771088', '04986932-d6b5-4f3b-ad96-ce8a8f8facf8', 'FAN-OPUS_WALL-14', 'OPUS WALL', 33770, 33770, true, true, '{"blade_type": "Real Dark Wooden / 4 blades", "suitable_for": "Wall", "sweep": "863mm / D 34in", "height_of_fan": "9100mm / 74in", "motor_spec": "188 x 18 / copper winding A/C motor", "airflow": "7350 Summer /Winter option", "colour": "Black Hand Painted", "media": {"primaryImage": "/images/products/OPUS_WALL_14.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('44902a84-9e58-4547-909b-f8f0909943b4', '04986932-d6b5-4f3b-ad96-ce8a8f8facf8', 'FAN-OPUS_WALL-15', 'OPUS WALL', 33770, 33770, true, true, '{"blade_type": "Real Pine Wooden / 4 blades", "suitable_for": "Wall", "sweep": "863mm / D 34in", "height_of_fan": "9100mm / 74in", "motor_spec": "188 x 18 / copper winding A/C motor", "airflow": "7350 Summer /Winter option", "colour": "Black Hand Painted", "media": {"primaryImage": "/images/products/OPUS_WALL_15.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('937f0e35-462e-447b-a6f0-8099b4eb1d4d', 'FAN-ARTIC_WALL', 'ARTIC WALL', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('a6f7852c-0ed2-42a6-bccc-2c91d2a99b9b', '937f0e35-462e-447b-a6f0-8099b4eb1d4d', 'FAN-ARTIC_WALL-16', 'ARTIC WALL', 41770, 41770, true, true, '{"blade_type": "Real Oak Dark Wooden / 4 blades", "suitable_for": "Wall", "sweep": "1320mm / D 52in", "motor_spec": "188 x 18 / copper winding A/C motor", "airflow": "7950 Summer / Winter option", "colour": "Black Hand Painted", "media": {"primaryImage": "/images/products/ARTIC_WALL_16.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('7d365925-9926-4f5d-a93e-ff2bbe76e5c1', '937f0e35-462e-447b-a6f0-8099b4eb1d4d', 'FAN-ARTIC_WALL-17', 'ARTIC WALL', 41770, 41770, true, true, '{"blade_type": "Real Pine Wooden / 4 blades", "suitable_for": "Wall", "sweep": "1320mm / D 52in", "motor_spec": "188 x 18 / copper winding A/C motor", "airflow": "7950 Summer / Winter option", "colour": "Black Hand Painted", "media": {"primaryImage": "/images/products/ARTIC_WALL_17.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('2a5059c6-63de-4eb4-9960-50ffd9822547', 'FAN-FREESIA', 'FREESIA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('1eb1804f-bcda-4722-a40c-b5ef4a8ed63a', '2a5059c6-63de-4eb4-9960-50ffd9822547', 'FAN-FREESIA-18', 'FREESIA', 63770, 63770, true, true, '{"blade_type": "Transparent Retractable / 4 blades", "suitable_for": "Ceiling", "sweep": "914mm/D36in", "height_of_fan": "880mm / 34in", "light_option": "LED 3000, 4000 & 6000k 55 +26 watts", "motor_spec": "155 x 12 / copper winding D/C motor", "airflow": "6012  Summer / Winter option", "colour": "Sand Gold", "media": {"primaryImage": "/images/products/FREESIA_18.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('30be7a8d-8e6b-4f34-916e-7c34f930453f', 'FAN-VOLLEY_PLUS_BRASS', 'VOLLEY PLUS BRASS', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('de0bfa3a-60a2-47ed-9227-ae2821dfe5dd', '30be7a8d-8e6b-4f34-916e-7c34f930453f', 'FAN-VOLLEY_PLUS_BRASS-19', 'VOLLEY PLUS BRASS', 26770, 26770, true, true, '{"blade_type": "Reversible Special Wooden Blades / 3 blades", "suitable_for": "Ceiling / Wall", "sweep": "406mm / D16in", "height_of_fan": "610mm/24in", "motor_spec": "80  x 8 / copper winding D/C motor", "airflow": "9421  / Summer / Winter option", "oscillation": "90\u00ba wide-angle", "body_color": "Antique Brass", "media": {"primaryImage": "/images/products/VOLLEY_PLUS_BRASS_19.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('e8f4042d-daa9-428d-b594-1d52358f3149', 'FAN-VOLLEY', 'VOLLEY', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('c89a051f-2d00-4075-8fee-7857520602a5', 'e8f4042d-daa9-428d-b594-1d52358f3149', 'FAN-VOLLEY-20', 'VOLLEY', 20770, 20770, true, true, '{"blade_type": "Matte Black ABS blades / 3 blades", "suitable_for": "Ceiling / Wall", "sweep": "406mm / D16in", "height_of_fan": "610mm/24in", "motor_spec": "80  x 8 / copper winding D/C motor", "airflow": "9421 / Summer /Winter option", "oscillation": "90\u00ba wide-angle", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/VOLLEY_20.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('3ac01dbb-6e09-4326-b6ec-99d5f73557f9', 'e8f4042d-daa9-428d-b594-1d52358f3149', 'FAN-VOLLEY-21', 'VOLLEY', 20770, 20770, true, true, '{"blade_type": "Matte White ABS blades / 3 blades", "suitable_for": "Ceiling / Wall", "sweep": "406mm / D16in", "height_of_fan": "610mm/24in", "motor_spec": "80  x 8 / copper winding D/C motor", "airflow": "9421  / Summer /Winter option", "oscillation": "90\u00ba wide-angle", "body_color": "Matte White", "media": {"primaryImage": "/images/products/VOLLEY_21.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('d87027ba-86cc-4a1f-a4d0-502f82fcc35e', 'FAN-VOLLEY_PLUS_BLACK', 'VOLLEY PLUS BLACK', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('701b7c18-081b-4e6c-9442-a4e74da62d45', 'd87027ba-86cc-4a1f-a4d0-502f82fcc35e', 'FAN-VOLLEY_PLUS_BLACK-22', 'VOLLEY PLUS BLACK', 24770, 24770, true, true, '{"blade_type": "Reversible Special Wooden Blades / 3 blades", "suitable_for": "Ceiling / Wall", "sweep": "406mm / D16in", "height_of_fan": "610mm/24in", "motor_spec": "80  x 8 / copper winding D/C motor", "airflow": "9421  / Summer / Winter option", "oscillation": "90\u00ba wide-angle", "body_color": "Black Hand Painted", "media": {"primaryImage": "/images/products/VOLLEY_PLUS_BLACK_22.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('c77ba256-446d-43d1-ae1b-5efd8599cc2d', 'FAN-WENDY', 'WENDY', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('2ccbea1e-353a-4922-9939-a37ac9b75b4e', 'c77ba256-446d-43d1-ae1b-5efd8599cc2d', 'FAN-WENDY-23', 'WENDY', 27770, 27770, true, true, '{"blade_type": "SS ABS blades/ 3 blades", "suitable_for": "Ceiling / Wall", "sweep": "406mm / D16in", "height_of_fan": "635mm / 25in", "motor_spec": "155x12  / copper winding D/C motor", "airflow": "9421", "oscillation": "360\u00ba wide-angle", "body_color": "Stainless Steel", "media": {"primaryImage": "/images/products/WENDY_23.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('767b417c-f288-45a1-9fb3-ebe11775337e', 'c77ba256-446d-43d1-ae1b-5efd8599cc2d', 'FAN-WENDY-24', 'WENDY', 27770, 27770, true, true, '{"blade_type": "Sand Gold ABS blades/ 3 blades", "suitable_for": "Ceiling / Wall", "sweep": "406mm / D16in", "height_of_fan": "635mm / 25in", "motor_spec": "155x12  / copper winding D/C motor", "airflow": "9421", "oscillation": "360\u00ba wide-angle", "body_color": "Sand Gold", "media": {"primaryImage": "/images/products/WENDY_24.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('da0958c6-68ab-495b-90f1-4dff43134615', 'c77ba256-446d-43d1-ae1b-5efd8599cc2d', 'FAN-WENDY-25', 'WENDY', 27770, 27770, true, true, '{"blade_type": "Dark coffee ABS blades / 3 blades", "suitable_for": "Ceiling / Wall", "sweep": "406mm / D16in", "height_of_fan": "635mm / 25in", "motor_spec": "155x12  / copper winding D/C motor", "airflow": "9421", "oscillation": "360\u00ba wide-angle", "body_color": "Coffee", "media": {"primaryImage": "/images/products/WENDY_25.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('0a84bbea-3da9-4423-a3f9-1398ccc5d139', 'FAN-BOLT', 'BOLT', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('ee6defa9-16ca-407c-8093-481a91081f08', '0a84bbea-3da9-4423-a3f9-1398ccc5d139', 'FAN-BOLT-26', 'BOLT', 28770, 28770, true, true, '{"blade_type": "Black ABS blades / 3 blades", "suitable_for": "Ceiling", "sweep": "406mm / D16in", "height_of_fan": "533mm / 21in", "motor_spec": "155x12  / copper winding D/C motor", "airflow": "9421  / Summer / Winter option", "oscillation": "90 & 145\u00ba", "body_color": "Black", "media": {"primaryImage": "/images/products/BOLT_26.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('83a23502-e18d-4540-833a-d9f37f7ef531', '0a84bbea-3da9-4423-a3f9-1398ccc5d139', 'FAN-BOLT-27', 'BOLT', 28770, 28770, true, true, '{"blade_type": "Sand Gold ABS blades / 3 blades", "suitable_for": "Ceiling", "sweep": "406mm / D16in", "height_of_fan": "533mm / 21in", "motor_spec": "155x12  / copper winding D/C motor", "airflow": "9421  / Summer / Winter option", "oscillation": "90 & 145\u00ba", "body_color": "Sand Gold", "media": {"primaryImage": "/images/products/BOLT_27.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('46775447-65b8-4371-99a9-1ce72e94db72', 'FAN-VINTAGE_WALL', 'VINTAGE WALL', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('d98ff210-9a51-4163-a879-24421a256ac4', '46775447-65b8-4371-99a9-1ce72e94db72', 'FAN-VINTAGE_WALL-28', 'VINTAGE WALL', 0, 0, true, true, '{"blade_type": "Copper Finish Aluminium / 3 blades", "suitable_for": "Wall", "sweep": "304mm / D 12in", "airflow": "9535", "oscillation": "90\u00ba wide-angle", "colour": "Antique Copper"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('5aebbed1-6650-47ff-ac6b-2b89cf895c99', 'FAN-HAZZEL', 'HAZZEL', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('fadb3356-ef37-4d3d-8b80-06927c34607a', '5aebbed1-6650-47ff-ac6b-2b89cf895c99', 'FAN-HAZZEL-29', 'HAZZEL', 39770, 39770, true, true, '{"blade_type": "Transparent  Gold ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "506mm / D 20in", "height_of_fan": "540mm / 21in", "light_option": "LED 3000, 4000 & 6000k 36watts", "motor_spec": "153x12  / copper winding D/C motor", "airflow": "8025 / Summer /Winter option", "colour": "French Gold", "media": {"primaryImage": "/images/products/HAZZEL_29.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('756a20aa-c5c7-465a-b3cb-e8151147cd5e', 'FAN-FLORA', 'FLORA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('5f4a064e-26c1-489a-af8a-be77e4963e1b', '756a20aa-c5c7-465a-b3cb-e8151147cd5e', 'FAN-FLORA-30', 'FLORA', 41770, 41770, true, true, '{"blade_type": "Transparent  Coffee ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "559mm / D 22in", "height_of_fan": "540mm / 21in", "light_option": "LED 3000, 4000 & 6000k 36watts", "motor_spec": "155x12  / copper winding D/C motor", "airflow": "8025 / Summer /Winter option", "colour": "Dark Brown", "media": {"primaryImage": "/images/products/FLORA_30.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('914f714c-1471-441b-8eab-3754f186a9a3', '756a20aa-c5c7-465a-b3cb-e8151147cd5e', 'FAN-FLORA-31', 'FLORA', 46770, 46770, true, true, '{"blade_type": "French Gold ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "559mm / D 22in", "height_of_fan": "540mm / 21in", "light_option": "LED 3000, 4000 & 6000k 36watts", "motor_spec": "155x12  / copper winding D/C motor", "airflow": "8025 / Summer /Winter option", "colour": "Franch Gold", "media": {"primaryImage": "/images/products/FLORA_31.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('64001300-fda5-4fbe-8e1b-ea1d3978061b', '756a20aa-c5c7-465a-b3cb-e8151147cd5e', 'FAN-FLORA-32', 'FLORA', 48770, 48770, true, true, '{"blade_type": "Rose Gold ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "559mm / D 22in", "height_of_fan": "540mm / 21in", "light_option": "LED 3000, 4000 & 6000k 36watts", "motor_spec": "155x12  / copper winding D/C motor", "airflow": "8025 / Summer /Winter option", "colour": "Rose Gold", "media": {"primaryImage": "/images/products/FLORA_32.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('c19c5727-fef4-4981-986b-eb52fa9f2b1d', 'FAN-TORNADO', 'TORNADO', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('9a6e5d32-f088-4b45-a387-20c449d2b0a1', 'c19c5727-fef4-4981-986b-eb52fa9f2b1d', 'FAN-TORNADO-33', 'TORNADO', 55770, 55770, true, true, '{"blade_type": "Real Wood / 1 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "485mm / 19in", "motor_spec": "155x20  / copper winding D/C motor", "airflow": "8025 / Summer /Winter option", "colour": "Gold Oak Wood", "media": {"primaryImage": "/images/products/TORNADO_33.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('5569ebbd-1602-4258-91af-2c1315029031', 'FAN-STALLION', 'STALLION', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('11fc9ac5-3b6c-4848-b29d-b473260c332f', '5569ebbd-1602-4258-91af-2c1315029031', 'FAN-STALLION-34', 'STALLION', 34770, 34770, true, true, '{"blade_type": "Real Dark Wood / 5 blades", "suitable_for": "Ceiling", "sweep": "1371mm / D 52in", "height_of_fan": "350mm / 14in", "motor_spec": "153x15  / copper winding D/C motor", "airflow": "8450 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/STALLION_34.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('124f3201-f2de-4a8d-93f6-730fab28533d', 'FAN-AMC_BEECHWOOD', 'AMC BEECHWOOD', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('99452d5e-9180-4e13-8518-2a15384ed833', '124f3201-f2de-4a8d-93f6-730fab28533d', 'FAN-AMC_BEECHWOOD-35', 'AMC BEECHWOOD', 37770, 37770, true, true, '{"blade_type": "Real Pine Wood / 3 blades", "suitable_for": "Ceiling", "sweep": "1371mm / D 54in", "height_of_fan": "420mm / 16in", "motor_spec": "153x18  / copper winding D/C motor", "airflow": "7740 / Summer /Winter option", "colour": "Chrome", "media": {"primaryImage": "/images/products/AMC_BEECHWOOD_35.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('ffd6900b-2876-4414-bdb3-62ed0a8bf733', 'FAN-AMC_OAKWOOD', 'AMC OAKWOOD', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('1af378be-5471-441a-a815-65171101b6be', 'ffd6900b-2876-4414-bdb3-62ed0a8bf733', 'FAN-AMC_OAKWOOD-36', 'AMC OAKWOOD', 38770, 38770, true, true, '{"blade_type": "Real Dark Wood / 3 blades", "suitable_for": "Ceiling", "sweep": "1371mm / D 54in", "height_of_fan": "420mm / 16in", "motor_spec": "153x18  / copper winding D/C motor", "airflow": "7740 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/AMC_OAKWOOD_36.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('623f89c8-3b22-471c-8609-8f800ac4d68a', 'ffd6900b-2876-4414-bdb3-62ed0a8bf733', 'FAN-AMC_OAKWOOD-37', 'AMC OAKWOOD +', 41770, 41770, true, true, '{"blade_type": "Real Dark Wood / 3 blades", "suitable_for": "Ceiling", "sweep": "1371mm / D 54in", "height_of_fan": "420mm / 16in", "light_option": "LED 3000K 18 Watts", "motor_spec": "153x18  / copper winding D/C motor", "airflow": "7740 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/AMC_OAKWOOD_37.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('0dea860d-059e-4f34-a812-8035176ac861', 'FAN-AMAZE', 'AMAZE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('627fc4f9-9726-409c-8caf-6636353b4df7', '0dea860d-059e-4f34-a812-8035176ac861', 'FAN-AMAZE-38', 'AMAZE', 35770, 35770, true, true, '{"blade_type": "Real Golden Oak Wood / 4 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "486mm / 19in", "motor_spec": "153 x 18  / copper winding D/C motor", "airflow": "7750 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/AMAZE_38.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('dc354eb9-c6bd-470e-8962-6a1580140494', 'FAN-CARAMEL', 'CARAMEL', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('75f99904-ac89-402f-9c19-14637f70aa76', 'dc354eb9-c6bd-470e-8962-6a1580140494', 'FAN-CARAMEL-39', 'CARAMEL', 31770, 31770, true, true, '{"blade_type": "Real Elephant Grey Wood / 3 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "434mm / 12in", "motor_spec": "153x16  / copper winding D/C motor", "airflow": "8250 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/CARAMEL_39.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('24051415-887f-400e-b9eb-07abdb7ee9f4', 'dc354eb9-c6bd-470e-8962-6a1580140494', 'FAN-CARAMEL-40', 'CARAMEL', 31770, 31770, true, true, '{"blade_type": "Real Golden Oak Wood / 3 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "434mm / 12in", "motor_spec": "153x16  / copper winding D/C motor", "airflow": "8250 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/CARAMEL_40.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('255c34a8-745d-4d88-8add-f8b58305554d', 'FAN-WOODY', 'WOODY', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('484f5457-52e6-4cae-a17b-993732101c3a', '255c34a8-745d-4d88-8add-f8b58305554d', 'FAN-WOODY-41', 'WOODY', 31770, 31770, true, true, '{"blade_type": "Real Light Pine Wood / 3 blades", "suitable_for": "Ceiling", "sweep": "1651mm / D 65in", "height_of_fan": "491mm / 19in", "motor_spec": "155x20  / copper winding D/C motor", "airflow": "10573 / Summer /Winter option", "colour": "Chrome"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('ace246d5-0438-40a3-8df3-1f122afe489c', 'FAN-LIBERTY', 'LIBERTY', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('a4f45243-e503-4b14-9157-dde1fad0ba28', 'ace246d5-0438-40a3-8df3-1f122afe489c', 'FAN-LIBERTY-42', 'LIBERTY', 32770, 32770, true, true, '{"blade_type": "Spical wood / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "400mm / 17 in", "motor_spec": "153x18  / copper winding D/C motor", "airflow": "6220 / Summer /Winter option", "colour": "Chrome", "media": {"primaryImage": "/images/products/LIBERTY_42.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('14f34ef5-11e1-4be9-a81f-1526dd082122', 'FAN-DELTA', 'DELTA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('e873b21b-5324-47b0-8bfb-a4a1547ec5c8', '14f34ef5-11e1-4be9-a81f-1526dd082122', 'FAN-DELTA-43', 'DELTA', 29770, 29770, true, true, '{"blade_type": "Real wood / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "380mm / 14 in", "motor_spec": "153x20  / copper winding D/C motor", "airflow": "9550 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/DELTA_43.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('09805710-3838-4c33-b167-8fb4194222eb', 'FAN-OAK', 'OAK', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('0872251d-17a8-4f2c-a60d-588314680f7a', '09805710-3838-4c33-b167-8fb4194222eb', 'FAN-OAK-44', 'OAK', 37770, 37770, true, true, '{"blade_type": "Real wood / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "455mm / 18in", "motor_spec": "153x15  / copper winding D/C motor", "airflow": "8525 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/OAK_44.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('1548547d-c18d-4837-b082-3b227fa0a37b', '09805710-3838-4c33-b167-8fb4194222eb', 'FAN-OAK-45', 'OAK', 37770, 37770, true, true, '{"blade_type": "Real Pine wood / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "455mm / 18in", "motor_spec": "153x15  / copper winding D/C motor", "airflow": "8525 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/OAK_45.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('db1a5732-eec1-49fc-9311-6e72f0f016f6', '09805710-3838-4c33-b167-8fb4194222eb', 'FAN-OAK-46', 'OAK', 37770, 37770, true, true, '{"blade_type": "Real Dark Walnut Wood / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "455mm / 18in", "motor_spec": "153x15  / copper winding D/C motor", "airflow": "8525 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/OAK_46.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('a25e3791-5ccc-4cd3-bbdd-83fbd99c14fe', 'FAN-Trendy', 'Trendy', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('5aec42b9-def1-4498-bcba-1252996bc72f', 'a25e3791-5ccc-4cd3-bbdd-83fbd99c14fe', 'FAN-Trendy-47', 'Trendy', 28770, 28770, true, true, '{"blade_type": "Real wood / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "420mm / 16in", "motor_spec": "155 x 20  / copper winding A/C motor", "airflow": "7790", "colour": "Copper", "media": {"primaryImage": "/images/products/Trendy_47.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('f0a69144-fb9b-4c12-be79-2204fa052773', 'FAN-LUXAIR', 'LUXAIR', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('db58179c-48db-4e11-96c1-b39886b4598d', 'f0a69144-fb9b-4c12-be79-2204fa052773', 'FAN-LUXAIR-48', 'LUXAIR', 36770, 36770, true, true, '{"blade_type": "Special wooden Golden Oak Blades / 4 blades", "suitable_for": "Ceiling", "sweep": "1270mm / D 50in", "light_option": "LED 3000, 4000 & 6000k 24watts", "motor_spec": "188x15  / copper winding D/C motor", "airflow": "9150 / Summer /Winter option", "colour": "Chrome", "media": {"primaryImage": "/images/products/LUXAIR_48.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('2eea113c-8321-4288-85a4-8161ce4cc08b', 'FAN-AIRWIND', 'AIRWIND', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('24b805f0-5f7b-40cc-b5b5-60e1f759a28e', '2eea113c-8321-4288-85a4-8161ce4cc08b', 'FAN-AIRWIND-49', 'AIRWIND', 32770, 32770, true, true, '{"blade_type": "Reversible Special Wooden Blades / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm/ D 52in", "height_of_fan": "500mm / 19in", "light_option": "LED 3000, 4000 & 6000k 15watts", "motor_spec": "188 x 12  / copper winding D/C motor", "airflow": "7418 / Summer /Winter option", "colour": "Grey + Chrome", "media": {"primaryImage": "/images/products/AIRWIND_49.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b3ceed9b-9bd8-4739-8f61-19eda759f6f9', '2eea113c-8321-4288-85a4-8161ce4cc08b', 'FAN-AIRWIND-50', 'AIRWIND', 32770, 32770, true, true, '{"blade_type": "Reversible Special Wooden Blades  / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm/ D 52in", "height_of_fan": "500mm / 19in", "light_option": "LED 3000, 4000 & 6000k 15watts", "motor_spec": "188 x 12  / copper winding D/C motor", "airflow": "7418 / Summer /Winter option", "colour": "Black + Matte Black", "media": {"primaryImage": "/images/products/AIRWIND_50.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('14c6b403-1f3d-468a-a39a-826f96d83e91', '2eea113c-8321-4288-85a4-8161ce4cc08b', 'FAN-AIRWIND-51', 'AIRWIND', 32770, 32770, true, true, '{"blade_type": "Reversible Special Wooden Blades / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm/ D 52in", "height_of_fan": "500mm / 19in", "light_option": "LED 3000, 4000 & 6000k 15watts", "motor_spec": "188 x 12 / copper winding D/C motor", "airflow": "7418 / Summer /Winter option", "colour": "Chrome + Red Wood", "media": {"primaryImage": "/images/products/AIRWIND_51.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('029fbc4f-9b61-4195-973b-300e6dc76793', '2eea113c-8321-4288-85a4-8161ce4cc08b', 'FAN-AIRWIND-52', 'AIRWIND', 32770, 32770, true, true, '{"blade_type": "Reversible Special Wooden Blades  / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm/ D 52in", "height_of_fan": "500mm / 19in", "light_option": "LED 3000, 4000 & 6000k 15watts", "motor_spec": "188 x 12  / copper winding D/C motor", "airflow": "7418 / Summer /Winter option", "colour": "White + Matte White", "media": {"primaryImage": "/images/products/AIRWIND_52.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b8e1c4f6-b07c-420e-8c12-d6f74c09018e', '2eea113c-8321-4288-85a4-8161ce4cc08b', 'FAN-AIRWIND-53', 'AIRWIND', 32770, 32770, true, true, '{"blade_type": "Reversible Special Wooden Blades  / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm/ D 52in", "height_of_fan": "500mm / 19in", "light_option": "LED 3000, 4000 & 6000k 15watts", "motor_spec": "188 x 12  / copper winding D/C motor", "airflow": "7418 / Summer /Winter option", "colour": "Walnut + Matte White", "media": {"primaryImage": "/images/products/AIRWIND_53.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('fa86fb8d-c2be-4488-beec-aec34217907d', '2eea113c-8321-4288-85a4-8161ce4cc08b', 'FAN-AIRWIND-54', 'AIRWIND', 32770, 32770, true, true, '{"blade_type": "Reversible Special Wooden Blades  / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm/ D 52in", "height_of_fan": "500mm / 19in", "light_option": "LED 3000, 4000 & 6000k 15watts", "motor_spec": "188 x 12  / copper winding D/C motor", "airflow": "7418 / Summer /Winter option", "colour": "Red Wood + Antique", "media": {"primaryImage": "/images/products/AIRWIND_54.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('4ec09e93-1001-473b-b44e-f7466931c340', 'FAN-WALNUT', 'WALNUT', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('49a0106c-e91d-4c4a-81af-86360a549b54', '4ec09e93-1001-473b-b44e-f7466931c340', 'FAN-WALNUT-55', 'WALNUT', 24770, 24770, true, true, '{"blade_type": "Special wood / 4 blades", "suitable_for": "Ceiling", "sweep": "1219mm / D 48in", "height_of_fan": "420mm / 16in", "motor_spec": "155 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "colour": "Walnut + Antique"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('17d1b1de-d9d6-497c-90c4-3e2d8cdee151', '4ec09e93-1001-473b-b44e-f7466931c340', 'FAN-WALNUT-56', 'WALNUT +', 24770, 24770, true, true, '{"blade_type": "Special wood / 4 blades", "suitable_for": "Ceiling", "sweep": "1219mm / D 48in", "height_of_fan": "420mm / 16in", "light_option": "LED 3000, 4000 & 6000K 12 watts", "motor_spec": "155 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "colour": "Walnut + Antique"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('e20c9294-1e09-4d58-9514-e74c07d0cd3e', 'FAN-EURO', 'EURO', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('614bb65b-f4be-447c-8aa8-3b86eb10eee3', 'e20c9294-1e09-4d58-9514-e74c07d0cd3e', 'FAN-EURO-57', 'EURO', 18770, 18770, true, true, '{"blade_type": "Special wooden Oak blades & Special wooden Rose blades / 4 blades", "suitable_for": "Ceiling", "sweep": "1220mm / D 48in", "height_of_fan": "450mm / 18in", "light_option": "LED 3000, 4000 & 6000K 18 watts", "motor_spec": "188 x 18 / copper winding A/C motor", "airflow": "7250 / Summer /Winter option", "body_color": "Antique Brass"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('e52d4783-171f-4e7a-9538-c2077ba02743', 'FAN-HUNTER', 'HUNTER', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('0f8755ae-6981-4446-8672-ee3ed3f27af5', 'e52d4783-171f-4e7a-9538-c2077ba02743', 'FAN-HUNTER-58', 'HUNTER', 21770, 21770, true, true, '{"blade_type": "Special wood / 6 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "460mm / 18in", "light_option": "LED 3000, 4000 & 6000K 18 watts", "motor_spec": "153 x 18 / copper winding A/C motor", "airflow": "7420 / Summer /Winter option", "colour": "Walnut + Antique", "media": {"primaryImage": "/images/products/HUNTER_58.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('beab75f5-043e-4180-89d1-7ce02f39c4a6', 'FAN-ARIZONA', 'ARIZONA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('463fda8b-818a-405a-a465-9133c5c567b9', 'beab75f5-043e-4180-89d1-7ce02f39c4a6', 'FAN-ARIZONA-59', 'ARIZONA', 23770, 23770, true, true, '{"blade_type": "Special Beech wood / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "699mm / 27in", "light_option": "LED 3000, 4000 & 6000K 17 watts", "motor_spec": "188x12  / copper winding A/C motor", "airflow": "7020", "colour": "Chrome"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('add7539d-3dc2-4b7a-9880-09044cf3dd07', 'FAN-ITALIO', 'ITALIO +', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('0ad30cb6-5907-4654-9dee-804f5fd39e41', 'add7539d-3dc2-4b7a-9880-09044cf3dd07', 'FAN-ITALIO-60', 'ITALIO +', 19770, 19770, true, true, '{"blade_type": "Special wood / 4 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "585mm / 23in", "light_option": "LED 3000, 4000 & 6000K 13 watts", "motor_spec": "188 x 12 / copper winding D/C motor", "airflow": "6850 / Summer /Winter option", "colour": "Matte white", "media": {"primaryImage": "/images/products/ITALIO_60.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('c9c896c9-7952-4457-b0c7-dfa54557c30b', 'add7539d-3dc2-4b7a-9880-09044cf3dd07', 'FAN-ITALIO-61', 'ITALIO +', 19770, 19770, true, true, '{"blade_type": "Special wood / 4 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "585mm / 23in", "light_option": "LED 3000, 4000 & 6000K 13 watts", "motor_spec": "188 x 12 / copper winding D/C motor", "airflow": "6850 / Summer /Winter option", "colour": "Chrome", "media": {"primaryImage": "/images/products/ITALIO_60.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('3dbff1ad-df44-4ebb-bbb5-0f5700a4824b', 'add7539d-3dc2-4b7a-9880-09044cf3dd07', 'FAN-ITALIO-62', 'ITALIO', 18770, 18770, true, true, '{"blade_type": "Special wood / 4 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "585mm / 23in", "motor_spec": "188 x 12 / copper winding D/C motor", "airflow": "6850 / Summer /Winter option", "colour": "Chrome", "media": {"primaryImage": "/images/products/ITALIO_62.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('6431a3f2-3ff7-4314-ba3f-205a7ffb00c7', 'FAN-PUFFIN', 'PUFFIN', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('43fc5bbb-ce49-40f8-9b92-b8ca15cdfe09', '6431a3f2-3ff7-4314-ba3f-205a7ffb00c7', 'FAN-PUFFIN-63', 'PUFFIN', 0, 0, true, true, '{"blade_type": "Special wood / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 48in", "height_of_fan": "540mm / 21in", "motor_spec": "153x21  / copper winding D/C motor", "airflow": "6180", "colour": "Gun Metal"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('565ee405-d9fc-41be-a1dd-8d08589e5e1d', 'FAN-CANBERRY', 'CANBERRY', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('ca6460e1-5243-499b-b540-56948b79bbee', '565ee405-d9fc-41be-a1dd-8d08589e5e1d', 'FAN-CANBERRY-64', 'CANBERRY', 31770, 31770, true, true, '{"blade_type": "Special wood / 5 blades", "suitable_for": "Ceiling", "sweep": "1346mm / D 53in", "height_of_fan": "652mm / 25in", "light_option": "3 Light kit E27 Holder", "motor_spec": "153x18 / copper winding A/C motor", "airflow": "7140", "colour": "Spray Painted"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('9acdb784-60f1-4d88-844d-c2d628c59cfd', 'FAN-VALENCIA', 'VALENCIA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('6a036e69-0570-43e4-866c-1d1dec8a1cbc', '9acdb784-60f1-4d88-844d-c2d628c59cfd', 'FAN-VALENCIA-65', 'VALENCIA', 31770, 31770, true, true, '{"blade_type": "Special wood / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "721mm / 28in", "light_option": "5 Light kit E27 Holder", "motor_spec": "188x12 / copper winding A/C motor", "airflow": "7140", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/VALENCIA_65.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('905494dd-07ae-413e-8415-898d0f99b2dc', '9acdb784-60f1-4d88-844d-c2d628c59cfd', 'FAN-VALENCIA-66', 'VALENCIA', 31770, 31770, true, true, '{"blade_type": "Special wood / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "721mm / 28in", "light_option": "5 Light kit E27 Holder", "motor_spec": "188x12 / copper winding A/C motor", "airflow": "7140", "colour": "Sand Gold", "media": {"primaryImage": "/images/products/VALENCIA_66.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('e57d1044-631c-4bb8-80f5-29391590d98c', 'FAN-CHERRY', 'CHERRY', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('0a0a6114-e320-431b-87f2-4b0de9351a90', 'e57d1044-631c-4bb8-80f5-29391590d98c', 'FAN-CHERRY-67', 'CHERRY', 25770, 25770, true, true, '{"blade_type": "Special wood / 5 blades", "suitable_for": "Ceiling", "sweep": "1346mm / D 53in", "height_of_fan": "577mm / 22in", "motor_spec": "153x18 / copper winding A/C motor", "airflow": "7140", "colour": "Spray Painted"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('a591cd27-6741-4803-9a76-feeb95aaff3e', 'FAN-FRIONA', 'FRIONA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('f93603cd-67e1-4cd0-a4c3-95da12d975b4', 'a591cd27-6741-4803-9a76-feeb95aaff3e', 'FAN-FRIONA-68', 'FRIONA', 30770, 30770, true, true, '{"blade_type": "Special wood / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "721mm / 28in", "motor_spec": "153x15  / copper winding A/C motor", "airflow": "7140", "colour": "Chrome", "media": {"primaryImage": "/images/products/FRIONA_68.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('2773e2e4-b4af-4a93-907c-29ca0070e086', 'FAN-VINTAGE', 'VINTAGE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('8c3531b9-6dba-485b-b759-7e53acc10f2a', '2773e2e4-b4af-4a93-907c-29ca0070e086', 'FAN-VINTAGE-69', 'VINTAGE', 17770, 17770, true, true, '{"blade_type": "Special wood / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "530mm / 20in", "motor_spec": "153x15  / copper winding A/C motor", "airflow": "6460 / Summer /Winter option", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/VINTAGE_69.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('d1a9259b-cdb5-4186-a85a-bba1d806b261', 'FAN-TROPICAL', 'TROPICAL', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('2d70b416-90ba-4bd8-83da-f5bb333eb799', 'd1a9259b-cdb5-4186-a85a-bba1d806b261', 'FAN-TROPICAL-70', 'TROPICAL', 31770, 31770, true, true, '{"blade_type": "Dark Walnut Wooden Blades / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "538mm / 21in", "motor_spec": "153x15  / copper winding D/C motor", "airflow": "7416 / Summer /Winter option", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/TROPICAL_70.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('bad2e799-fec1-4404-9fe0-22eced6a5f5e', 'FAN-BOLERO', 'BOLERO', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b49ad9de-87d1-484a-a1c4-3bad9959260c', 'bad2e799-fec1-4404-9fe0-22eced6a5f5e', 'FAN-BOLERO-71', 'BOLERO', 82770, 82770, true, true, '{"blade_type": "Dual Plated Aluminium / 8 blades", "suitable_for": "Ceiling", "sweep": "1981mm / D 78in", "height_of_fan": "479mm / 19in", "motor_spec": "177 x 22  / copper winding D/C motor", "airflow": "19150/ / Summer /Winter option", "colour": "Dark Coffee"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('8f168c44-abf5-41d7-ba69-25933a403861', 'bad2e799-fec1-4404-9fe0-22eced6a5f5e', 'FAN-BOLERO-72', 'BOLERO', 124770, 124770, true, true, '{"blade_type": "Dual Plated Aluminium / 8 blades", "suitable_for": "Ceiling", "sweep": "2743mm / D 108in", "height_of_fan": "479mm / 19in", "motor_spec": "177 x 22  / copper winding D/C motor", "airflow": "29850 / Summer /Winter option", "colour": "Dark Coffee", "media": {"primaryImage": "/images/products/TROPICAL_70.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('1c91e0fd-5cda-4131-b16b-4429bb5f081f', 'FAN-SENSATION', 'SENSATION', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('0d25fe12-4169-4999-99c7-23499c5897cf', '1c91e0fd-5cda-4131-b16b-4429bb5f081f', 'FAN-SENSATION-73', 'SENSATION', 33770, 33770, true, true, '{"blade_type": "Dark Wood ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "426mm / 17in", "motor_spec": "153x16  / copper winding D/C motor", "airflow": "10750 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/SENSATION_73.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('9eb6268a-231f-4964-b72c-e365ad510656', '1c91e0fd-5cda-4131-b16b-4429bb5f081f', 'FAN-SENSATION-74', 'SENSATION', 30770, 30770, true, true, '{"blade_type": "Matte White ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "426mm / 17in", "motor_spec": "153x16  / copper winding D/C motor", "airflow": "10750 / Summer /Winter option", "colour": "Matte White", "media": {"primaryImage": "/images/products/SENSATION_74.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('06d3f018-8ea9-477b-81fb-73c4fb608b9b', '1c91e0fd-5cda-4131-b16b-4429bb5f081f', 'FAN-SENSATION-75', 'SENSATION', 30770, 30770, true, true, '{"blade_type": "Matte Black ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "426mm / 17in", "motor_spec": "153x16  / copper winding D/C motor", "airflow": "10750 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/SENSATION_75.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('030335cc-69db-4350-b039-d12d027ca938', '1c91e0fd-5cda-4131-b16b-4429bb5f081f', 'FAN-SENSATION-76', 'SENSATION', 33770, 33770, true, true, '{"blade_type": "Pine Wood ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "426mm / 17in", "motor_spec": "153x16  / copper winding D/C motor", "airflow": "10750 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/SENSATION_76.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('27092e12-e79f-4d11-9d88-124dd1def1e5', '1c91e0fd-5cda-4131-b16b-4429bb5f081f', 'FAN-SENSATION-77', 'SENSATION', 35770, 35770, true, true, '{"blade_type": "Carbon ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "426mm / 17in", "motor_spec": "153x16  / copper winding D/C motor", "airflow": "10750 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/SENSATION_77.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('55fdec51-0694-4a8c-9457-0581b66d198e', 'FAN-LILLIPUT', 'LILLIPUT', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('d6954693-4b1d-448c-b869-62c5477bc3cf', '55fdec51-0694-4a8c-9457-0581b66d198e', 'FAN-LILLIPUT-78', 'LILLIPUT', 30770, 30770, true, true, '{"blade_type": "Dark Wood ABS blades/ 3 blades / 4 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/LILLIPUT_78.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('e9ade0c8-a7be-4726-bbc3-8c2d2d7b13d6', '55fdec51-0694-4a8c-9457-0581b66d198e', 'FAN-LILLIPUT-79', 'LILLIPUT', 30770, 30770, true, true, '{"blade_type": "Pine Wood ABS / 3 blades / 4 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Chrome", "media": {"primaryImage": "/images/products/LILLIPUT_79.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('5f536937-6e47-4072-ba1c-d87df9e1c850', 'FAN-LILLIPUT_42__NEW', 'LILLIPUT 42" NEW', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('7d3d9930-29b2-47a9-9893-42db93a49f00', '5f536937-6e47-4072-ba1c-d87df9e1c850', 'FAN-LILLIPUT_42__NEW-80', 'LILLIPUT 42" NEW', 27770, 27770, true, true, '{"blade_type": "Dark Wood ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1067mm / D 42in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Antique Brass", "media": {"primaryImage": "/images/products/LILLIPUT_42__NEW_80.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('9bc23b2b-9978-428d-8c21-5ce25b436317', '5f536937-6e47-4072-ba1c-d87df9e1c850', 'FAN-LILLIPUT_42__NEW-81', 'LILLIPUT 42" NEW', 29770, 29770, true, true, '{"blade_type": "Dark Wood ABS blades/  4 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1067mm / D 42in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Antique Brass", "media": {"primaryImage": "/images/products/LILLIPUT_42__NEW_81.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('07c9fdd5-fdf3-4a1a-a396-bd1cfb937223', '5f536937-6e47-4072-ba1c-d87df9e1c850', 'FAN-LILLIPUT_42__NEW-82', 'LILLIPUT 42" NEW', 31770, 31770, true, true, '{"blade_type": "Dark Wood ABS blades/ 4 blades", "suitable_for": "Low ceiling / Hugger", "light_option": "LED 3000, 4000 & 6000K 18 watts", "sweep": "1067mm / D 42in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Antique Brass", "media": {"primaryImage": "/images/products/LILLIPUT_42__NEW_82.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('24b67363-6f75-4590-8d9f-5679e3832ea2', '5f536937-6e47-4072-ba1c-d87df9e1c850', 'FAN-LILLIPUT_42__NEW-83', 'LILLIPUT 42" NEW', 29770, 29770, true, true, '{"blade_type": "Dark Wood ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "light_option": "LED 3000, 4000 & 6000K 18 watts", "sweep": "1067mm / D 42in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Antique Brass", "media": {"primaryImage": "/images/products/LILLIPUT_42__NEW_83.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('6a6311c0-f308-4cc2-9729-5749a0a74412', '5f536937-6e47-4072-ba1c-d87df9e1c850', 'FAN-LILLIPUT_42__NEW-84', 'LILLIPUT 42" NEW', 27770, 27770, true, true, '{"blade_type": "Dark Wood ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1067mm / D 42in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/LILLIPUT_42__NEW_84.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('fff065ac-d992-4535-ba04-3a8b3c4e5d70', '5f536937-6e47-4072-ba1c-d87df9e1c850', 'FAN-LILLIPUT_42__NEW-85', 'LILLIPUT 42" NEW', 29770, 29770, true, true, '{"blade_type": "Dark Wood ABS blades/ 4 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1067mm / D 42in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/LILLIPUT_42__NEW_85.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('a617f7a1-c104-40c4-8b35-dc67ea4cd7b5', 'FAN-LILLIPUT_42_NEW', 'LILLIPUT 42 NEW', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('0405a92a-56a3-487c-8004-f6009fc2f158', 'a617f7a1-c104-40c4-8b35-dc67ea4cd7b5', 'FAN-LILLIPUT_42_NEW-86', 'LILLIPUT 42 NEW', 29770, 29770, true, true, '{"blade_type": "Dark Wood ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "light_option": "LED 3000, 4000 & 6000K 18 watts", "sweep": "1067mm / D 42in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/LILLIPUT_42_NEW_86.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('13140040-10c2-4713-a806-a3279bebbc69', '5f536937-6e47-4072-ba1c-d87df9e1c850', 'FAN-LILLIPUT_42__NEW-87', 'LILLIPUT 42" NEW', 31770, 31770, true, true, '{"blade_type": "Dark Wood ABS blades/ 4 blades", "suitable_for": "Low ceiling / Hugger", "light_option": "LED 3000, 4000 & 6000K 18 watts", "sweep": "1067mm / D 42in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/LILLIPUT_42__NEW_87.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('266090e9-d032-4972-a2c3-1154a23ab344', 'FAN-LILLIPUT_48__NEW', 'LILLIPUT 48" NEW', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('da107b6d-cb23-4be6-833d-2149ba73e024', '266090e9-d032-4972-a2c3-1154a23ab344', 'FAN-LILLIPUT_48__NEW-88', 'LILLIPUT 48" NEW', 27770, 27770, true, true, '{"blade_type": "Dark Wood ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Antique Brass", "media": {"primaryImage": "/images/products/LILLIPUT_48__NEW_88.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('c4eecc52-face-4294-aa6c-a3549e29e27a', '266090e9-d032-4972-a2c3-1154a23ab344', 'FAN-LILLIPUT_48__NEW-89', 'LILLIPUT 48" NEW', 29770, 29770, true, true, '{"blade_type": "Dark Wood ABS blades/  4 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Antique Brass", "media": {"primaryImage": "/images/products/LILLIPUT_48__NEW_89.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b01dc870-e7fe-4c19-8e2c-e58ecb323960', '266090e9-d032-4972-a2c3-1154a23ab344', 'FAN-LILLIPUT_48__NEW-90', 'LILLIPUT 48" NEW', 31770, 31770, true, true, '{"blade_type": "Dark Wood ABS blades/ 4 blades", "suitable_for": "Low ceiling / Hugger", "light_option": "LED 3000, 4000 & 6000K 18 watts", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Antique Brass", "media": {"primaryImage": "/images/products/LILLIPUT_48__NEW_90.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('ed9233f7-d564-4784-8277-515a84f8a7a3', '266090e9-d032-4972-a2c3-1154a23ab344', 'FAN-LILLIPUT_48__NEW-91', 'LILLIPUT 48" NEW', 29770, 29770, true, true, '{"blade_type": "Dark Wood ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "light_option": "LED 3000, 4000 & 6000K 18 watts", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Antique Brass", "media": {"primaryImage": "/images/products/LILLIPUT_48__NEW_91.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('9841ac6d-684a-4ec4-8067-22e9001e400d', '266090e9-d032-4972-a2c3-1154a23ab344', 'FAN-LILLIPUT_48__NEW-92', 'LILLIPUT 48" NEW', 27770, 27770, true, true, '{"blade_type": "Dark Wood ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/LILLIPUT_48__NEW_92.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('dc8ed0ae-c42d-447a-90af-44868dbd0b9d', '266090e9-d032-4972-a2c3-1154a23ab344', 'FAN-LILLIPUT_48__NEW-93', 'LILLIPUT 48" NEW', 29770, 29770, true, true, '{"blade_type": "Dark Wood ABS blades/ 4 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/LILLIPUT_48__NEW_93.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('3b45a6da-15af-45d4-a191-52949a32de25', '266090e9-d032-4972-a2c3-1154a23ab344', 'FAN-LILLIPUT_48__NEW-94', 'LILLIPUT 48" NEW', 29770, 29770, true, true, '{"blade_type": "Dark Wood ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "light_option": "LED 3000, 4000 & 6000K 18 watts", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/LILLIPUT_48__NEW_94.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('aebf27a1-6555-4e14-8079-69af6ea3e6e4', '266090e9-d032-4972-a2c3-1154a23ab344', 'FAN-LILLIPUT_48__NEW-95', 'LILLIPUT 48" NEW', 31770, 31770, true, true, '{"blade_type": "Dark Wood ABS blades/ 4 blades", "suitable_for": "Low ceiling / Hugger", "light_option": "LED 3000, 4000 & 6000K 18 watts", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/LILLIPUT_48__NEW_95.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('e6d6d194-4bb9-476b-90de-0ef5503866c2', 'FAN-SENSATION____Hugger', 'SENSATION   
Hugger', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('0f38bf57-6845-4472-8736-487cebbadf88', 'e6d6d194-4bb9-476b-90de-0ef5503866c2', 'FAN-SENSATION____Hugger-96', 'SENSATION   
Hugger', 36770, 36770, true, true, '{"blade_type": "Carbon ABS / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1422mm / D 56in", "height_of_fan": "280mm / 11in", "motor_spec": "153x16  / copper winding D/C motor", "airflow": "10750 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/SENSATION____Hugger_96.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('b3e8120c-4c41-40aa-b0a2-822d8dd26bf7', 'FAN-SENSATION__Hugger', 'SENSATION 
Hugger', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('03ddc85c-b649-4a3b-b7d2-dc166b6cdc08', 'b3e8120c-4c41-40aa-b0a2-822d8dd26bf7', 'FAN-SENSATION__Hugger-97', 'SENSATION 
Hugger', 31770, 31770, true, true, '{"blade_type": "Matte Black ABS / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1422mm / D 56in", "height_of_fan": "280mm / 11in", "motor_spec": "153x16  / copper winding D/C motor", "airflow": "10750 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/SENSATION__Hugger_97.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('a47d20c9-38b1-461c-bf7d-96d5e36d2a1d', 'FAN-SENSATION______Hugger', 'SENSATION     
Hugger', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('0539db3d-cd9a-42e6-85c9-c3436992249e', 'a47d20c9-38b1-461c-bf7d-96d5e36d2a1d', 'FAN-SENSATION______Hugger-98', 'SENSATION     
Hugger', 31770, 31770, true, true, '{"blade_type": "Matte White ABS / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1422mm / D 56in", "height_of_fan": "280mm / 11in", "motor_spec": "153x16  / copper winding D/C motor", "airflow": "10750 / Summer /Winter option", "colour": "Matte White", "media": {"primaryImage": "/images/products/SENSATION______Hugger_98.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('388e88dd-67c4-4e5d-9176-eb1290aab083', 'FAN-SENSATION_________Hugger', 'SENSATION        
Hugger', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b74b2c2e-eadd-40c1-b392-7597390454b5', '388e88dd-67c4-4e5d-9176-eb1290aab083', 'FAN-SENSATION_________Hugger-99', 'SENSATION        
Hugger', 34770, 34770, true, true, '{"blade_type": "Dark Wood ABS / 3 blades", "suitable_for": "Low ceiling / Hugger Fan", "sweep": "1422mm / D 56in", "height_of_fan": "280mm / 11in", "motor_spec": "153x16  / copper winding D/C motor", "airflow": "10750 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/SENSATION_________Hugger_99.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('c5fec8db-7028-473b-8b2f-b74130c54039', 'a47d20c9-38b1-461c-bf7d-96d5e36d2a1d', 'FAN-SENSATION______Hugger-100', 'SENSATION     
Hugger', 34770, 34770, true, true, '{"blade_type": "Pine Wood ABS / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1422mm / D 56in", "height_of_fan": "280mm / 11in", "motor_spec": "153x16  / copper winding D/C motor", "airflow": "10750 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/SENSATION______Hugger_100.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('2c5086b9-7efd-430c-9df2-ee995cbfbd4f', 'FAN-MAYBACH_Hugger', 'MAYBACH
Hugger', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('df63e6b4-cfed-4e4f-8ce9-2a9ea07b3a0f', '2c5086b9-7efd-430c-9df2-ee995cbfbd4f', 'FAN-MAYBACH_Hugger-101', 'MAYBACH
Hugger', 29770, 29770, true, true, '{"blade_type": "Black ABS / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1320mm /D 52in", "height_of_fan": "309 mm/12in", "motor_spec": "155 x 20  / copper winding D/C motor", "airflow": "7850 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/MAYBACH_Hugger_101.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('6ee1b127-f11e-4837-bd7b-5c3ff53cf29a', '2c5086b9-7efd-430c-9df2-ee995cbfbd4f', 'FAN-MAYBACH_Hugger-102', 'MAYBACH
Hugger', 29770, 29770, true, true, '{"blade_type": "White ABS / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1320mm /D 52in", "height_of_fan": "309 mm/12in", "motor_spec": "155 x 20  / copper winding D/C motor", "airflow": "7850 / Summer /Winter option", "colour": "Matte White", "media": {"primaryImage": "/images/products/MAYBACH_Hugger_102.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('faea6221-52d8-41f6-a3a8-cdc6f6e7074a', '2c5086b9-7efd-430c-9df2-ee995cbfbd4f', 'FAN-MAYBACH_Hugger-103', 'MAYBACH
Hugger', 32770, 32770, true, true, '{"blade_type": "Dark Wooden ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1320mm /D 52in", "height_of_fan": "309 mm/12in", "motor_spec": "155 x 20  / copper winding D/C motor", "airflow": "7850 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/MAYBACH_Hugger_103.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('3ad91b8c-56ad-4857-9a67-1dae3a28d349', 'FAN-RADAR', 'RADAR', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('0be75dbe-6eeb-4ffe-815a-453bde5347fa', '3ad91b8c-56ad-4857-9a67-1dae3a28d349', 'FAN-RADAR-104', 'RADAR', 51770, 51770, true, true, '{"blade_type": "Elephant Grey Wood ABS / 6 blades", "suitable_for": "ceiling", "sweep": "1676mm / D 66in", "height_of_fan": "633mm / 24in", "light_option": "LED 3000, 4000 & 6000k 12Watts", "motor_spec": "155 x 20   / copper winding D/C motor", "airflow": "14643 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/RADAR_104.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('77504292-298a-4059-b8c0-ed30a3953e76', '3ad91b8c-56ad-4857-9a67-1dae3a28d349', 'FAN-RADAR-105', 'RADAR', 49770, 49770, true, true, '{"blade_type": "Matte White ABS / 6 blades", "suitable_for": "ceiling", "sweep": "1676mm / D 66in", "height_of_fan": "633mm / 24in", "light_option": "LED 3000, 4000 & 6000k 12Watts", "motor_spec": "155 x 20   / copper winding D/C motor", "airflow": "14643 / Summer /Winter option", "colour": "Matte White", "media": {"primaryImage": "/images/products/RADAR_105.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('91bbae34-5472-4beb-88c8-f36406733d03', '3ad91b8c-56ad-4857-9a67-1dae3a28d349', 'FAN-RADAR-106', 'RADAR', 49770, 49770, true, true, '{"blade_type": "Grey ABS / 6 blades", "suitable_for": "ceiling", "sweep": "1676mm / D 66in", "height_of_fan": "633mm / 24in", "light_option": "LED 3000, 4000 & 6000k 12Watts", "motor_spec": "155 x 20   / copper winding D/C motor", "airflow": "14643 / Summer /Winter option", "colour": "Chrome", "media": {"primaryImage": "/images/products/RADAR_106.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('39d88ddd-4fbf-4d2b-aba2-2180225ef208', '3ad91b8c-56ad-4857-9a67-1dae3a28d349', 'FAN-RADAR-107', 'RADAR', 51770, 51770, true, true, '{"blade_type": "Walnut Wood ABS / 6 blades", "suitable_for": "ceiling", "sweep": "1676mm / D 66in", "height_of_fan": "633mm / 24in", "light_option": "LED 3000, 4000 & 6000k 12Watts", "motor_spec": "155 x 20   / copper winding D/C motor", "airflow": "14643 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/RADAR_107.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('669fe08b-a06b-4d95-8db5-ccd9833f091f', '3ad91b8c-56ad-4857-9a67-1dae3a28d349', 'FAN-RADAR-108', 'RADAR', 49770, 49770, true, true, '{"blade_type": "Matte Black ABS / 6 blades", "suitable_for": "ceiling", "sweep": "1676mm / D 66in", "height_of_fan": "633mm / 24in", "light_option": "LED 3000, 4000 & 6000k 12Watts", "motor_spec": "155 x 20   / copper winding D/C motor", "airflow": "14643 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/RADAR_108.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('44dcba87-2541-40d7-82cf-915e5612068d', 'FAN-GRAINS', 'GRAINS', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('de6fc6e1-b041-4d9a-a037-1290966c06d9', '44dcba87-2541-40d7-82cf-915e5612068d', 'FAN-GRAINS-109', 'GRAINS', 40770, 40770, true, true, '{"blade_type": "Walnut Wood ABS / 6 blades", "suitable_for": "ceiling", "sweep": "1676mm / D 66in", "height_of_fan": "580mm / 23in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "13530 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/GRAINS_109.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('4973d15f-a656-4f96-8258-d6a8af5c58c6', '44dcba87-2541-40d7-82cf-915e5612068d', 'FAN-GRAINS-110', 'GRAINS +', 41770, 41770, true, true, '{"blade_type": "Walnut Wood ABS / 6 blades", "suitable_for": "ceiling", "sweep": "1676mm / D 66in", "height_of_fan": "580mm / 23in", "light_option": "LED 3000, 4000 & 6000k 24 Watts", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "13530 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/GRAINS_110.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('8bd940c9-9db4-4ebd-9bda-d5298abe7a48', 'FAN-VENICE', 'VENICE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('e7f2f427-10af-4e4e-9a22-eec7609e9ca5', '8bd940c9-9db4-4ebd-9bda-d5298abe7a48', 'FAN-VENICE-111', 'VENICE', 26770, 26770, true, true, '{"blade_type": "Black ABS / 3 blades", "suitable_for": "ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "480mm / 19in", "motor_spec": "153 x 20  / copper winding D/C motor", "airflow": "9980 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/VENICE_111.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('eff7074c-6aa0-4284-b80d-0dfa2db4e2d7', 'FAN-AIRFORCE', 'AIRFORCE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('295d3e7d-9185-44f3-83e1-0071d6bbb5e3', 'eff7074c-6aa0-4284-b80d-0dfa2db4e2d7', 'FAN-AIRFORCE-112', 'AIRFORCE', 23770, 23770, true, true, '{"suitable_for": "ceilig", "sweep": "1270mm /D 50in", "height_of_fan": "356 mm/14in", "motor_spec": "153 x 16  / copper winding D/C motor", "airflow": "10080 / Summer /Winter option", "colour": "Matte White", "media": {"primaryImage": "/images/products/AIRFORCE_112.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('f5ae883f-60ed-4236-b249-574789b90576', 'eff7074c-6aa0-4284-b80d-0dfa2db4e2d7', 'FAN-AIRFORCE-113', 'AIRFORCE', 26770, 26770, true, true, '{"suitable_for": "ceiling", "sweep": "1270mm /D 50in", "height_of_fan": "356 mm/14in", "motor_spec": "153 x 16  / copper winding D/C motor", "airflow": "10080 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/AIRFORCE_113.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('47bb6f86-5842-4edc-93f5-d8feea9af77f', 'eff7074c-6aa0-4284-b80d-0dfa2db4e2d7', 'FAN-AIRFORCE-114', 'AIRFORCE', 23770, 23770, true, true, '{"suitable_for": "ceiling", "sweep": "1270mm /D 50in", "height_of_fan": "356 mm/14in", "motor_spec": "153 x 16  / copper winding D/C motor", "airflow": "10080 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/AIRFORCE_114.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('681dc476-6d1b-41ac-bb49-36c557269dfe', 'eff7074c-6aa0-4284-b80d-0dfa2db4e2d7', 'FAN-AIRFORCE-115', 'AIRFORCE', 26770, 26770, true, true, '{"suitable_for": "ceiling", "sweep": "1270mm /D 50in", "height_of_fan": "356 mm/14in", "motor_spec": "153 x 16  / copper winding D/C motor", "airflow": "10080 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/AIRFORCE_115.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('8c0e315d-5b46-49ef-91a4-b934855776ab', 'eff7074c-6aa0-4284-b80d-0dfa2db4e2d7', 'FAN-AIRFORCE-116', 'AIRFORCE', 26770, 26770, true, true, '{"blade_type": "Ebony ABS / 3 blades", "suitable_for": "ceiling", "sweep": "1270mm /D 50in", "height_of_fan": "356 mm/14in", "motor_spec": "153 x 16  / copper winding D/C motor", "airflow": "10080 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/AIRFORCE_116.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('36d66428-be79-4b92-b54a-9945c8cbeae3', 'FAN-CLASSIC', 'CLASSIC', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('7e373e98-8b58-4778-a2ac-d7c1a6fd23ee', '36d66428-be79-4b92-b54a-9945c8cbeae3', 'FAN-CLASSIC-117', 'CLASSIC', 30770, 30770, true, true, '{"blade_type": "Brown Rattan ABS blades  / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "480mm / 18in", "motor_spec": "155 x 20   / copper winding A/C motor", "airflow": "8250 / Summer /Winter option", "body_color": "Dark Bronze", "media": {"primaryImage": "/images/products/CLASSIC_117.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('9839db37-43cc-4ef8-9f4b-19c5ff1a7c53', '36d66428-be79-4b92-b54a-9945c8cbeae3', 'FAN-CLASSIC-118', 'CLASSIC', 30770, 30770, true, true, '{"blade_type": "Dark Brown Rattan ABS blades / 5 blades", "suitable_for": "ceilimg", "sweep": "1320mm / D 52in", "height_of_fan": "480mm / 18in", "motor_spec": "155 x 20   / copper winding A/C motor", "airflow": "8250 / Summer /Winter option", "body_color": "Dark Bronze", "media": {"primaryImage": "/images/products/CLASSIC_118.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('911fa348-6d4f-4b75-aa64-fb384a8c7315', '36d66428-be79-4b92-b54a-9945c8cbeae3', 'FAN-CLASSIC-119', 'CLASSIC', 30770, 30770, true, true, '{"blade_type": "Matte White Rattan ABS blades / 5 blades", "suitable_for": "ceilimg", "sweep": "1320mm / D 52in", "height_of_fan": "480mm / 18in", "motor_spec": "155 x 20   / copper winding A/C motor", "airflow": "8250 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/CLASSIC_119.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('e3426cfb-bd3d-4b1e-995a-fbb3c4c96907', '36d66428-be79-4b92-b54a-9945c8cbeae3', 'FAN-CLASSIC-120', 'CLASSIC', 38770, 38770, true, true, '{"blade_type": "Brown Rattan ABS  / 5 blades", "suitable_for": "Wall", "sweep": "1320mm / D 52in", "height_of_fan": "480mm / 18in", "motor_spec": "155 x 20   / copper winding A/C motor", "airflow": "8950 / Summer /Winter option", "colour": "Dark Brown", "media": {"primaryImage": "/images/products/CLASSIC_120.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('c3d6fedd-2bb5-49a3-8457-1e8b2272907e', '36d66428-be79-4b92-b54a-9945c8cbeae3', 'FAN-CLASSIC-121', 'CLASSIC', 38770, 38770, true, true, '{"blade_type": "Dark Brown Rattan ABS  / 5 blades", "suitable_for": "Wall", "sweep": "1320mm / D 52in", "height_of_fan": "480mm / 18in", "motor_spec": "155 x 20   / copper winding A/C motor", "airflow": "8950 / Summer /Winter option", "colour": "Dark Brown", "media": {"primaryImage": "/images/products/CLASSIC_121.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('72e1c20c-0c55-4b97-a2e9-b1e491389234', '36d66428-be79-4b92-b54a-9945c8cbeae3', 'FAN-CLASSIC-122', 'CLASSIC', 38770, 38770, true, true, '{"blade_type": "Matte White ABS  / 5 blades", "suitable_for": "Wall", "sweep": "1320mm / D 52in", "height_of_fan": "480mm / 18in", "motor_spec": "155 x 20   / copper winding A/C motor", "airflow": "8950 / Summer /Winter option", "colour": "Matte white", "media": {"primaryImage": "/images/products/CLASSIC_122.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('c27e5ba3-ca5a-43a8-89f3-f5100f1bbcd2', 'FAN-VORTEX', 'VORTEX', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('6b873cf9-2e2a-43bd-b388-776fae07fc63', 'c27e5ba3-ca5a-43a8-89f3-f5100f1bbcd2', 'FAN-VORTEX-123', 'VORTEX', 28770, 28770, true, true, '{"blade_type": "Light Wood ABS  / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "460mm / 18 in", "motor_spec": "153 x 15 / copper winding D/C motor", "airflow": "8950 / Summer /Winter option", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/VORTEX_123.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b043baa2-e267-4d46-8579-5eddeeb50c83', 'c27e5ba3-ca5a-43a8-89f3-f5100f1bbcd2', 'FAN-VORTEX-124', 'VORTEX', 28770, 28770, true, true, '{"blade_type": "Matte Black ABS  / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "460mm / 18 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "8950 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/VORTEX_124.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b9d1b25e-1873-4a61-9541-8a460bdfe879', 'c27e5ba3-ca5a-43a8-89f3-f5100f1bbcd2', 'FAN-VORTEX-125', 'VORTEX', 28770, 28770, true, true, '{"blade_type": "Matte Black ABS  / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "460mm / 18 in", "motor_spec": "153 x 15 / copper winding D/C motor", "airflow": "8950 / Summer /Winter option", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/VORTEX_125.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('af58c272-a834-40cf-b999-1462b9694dc5', 'c27e5ba3-ca5a-43a8-89f3-f5100f1bbcd2', 'FAN-VORTEX-126', 'VORTEX', 28770, 28770, true, true, '{"blade_type": "Matte White ABS  / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "460mm / 18 in", "motor_spec": "153 x 15 / copper winding D/C motor", "airflow": "8950 / Summer /Winter option", "colour": "Chrome", "media": {"primaryImage": "/images/products/VORTEX_126.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('cf573132-439e-4001-93f0-0ec67a5a8888', 'FAN-COLUMBIA', 'COLUMBIA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('bea9c800-7970-4b2c-b764-412f7374f462', 'cf573132-439e-4001-93f0-0ec67a5a8888', 'FAN-COLUMBIA-127', 'COLUMBIA', 28770, 28770, true, true, '{"blade_type": "Matte White ABS  / 5 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "560mm / 20 in", "motor_spec": "/ copper winding D/C motor", "airflow": "10000 / Summer /Winter option", "colour": "Matte white", "media": {"primaryImage": "/images/products/COLUMBIA_127.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('210ca837-a468-4c7c-9d24-a5bdac29a57b', 'cf573132-439e-4001-93f0-0ec67a5a8888', 'FAN-COLUMBIA-128', 'COLUMBIA', 28770, 28770, true, true, '{"blade_type": "Matte Black ABS  / 5 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "560mm / 20 in", "motor_spec": "/ copper winding D/C motor", "airflow": "10000 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/COLUMBIA_128.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('47e64665-12e5-47a3-adde-c6a6245578fa', 'cf573132-439e-4001-93f0-0ec67a5a8888', 'FAN-COLUMBIA-129', 'COLUMBIA', 34770, 34770, true, true, '{"blade_type": "Oak Wooden ABS  / 5 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "560mm / 20 in", "motor_spec": "/ copper winding D/C motor", "airflow": "10000 / Summer /Winter option", "colour": "Oak Wooden", "media": {"primaryImage": "/images/products/COLUMBIA_129.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('e936c027-c8b0-4254-a091-3a41f6677b6b', 'FAN-ORION_PLUS', 'ORION PLUS', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('f968274c-c7c6-4cf5-8081-6498afc1b8c3', 'e936c027-c8b0-4254-a091-3a41f6677b6b', 'FAN-ORION_PLUS-130', 'ORION PLUS', 43770, 43770, true, true, '{"blade_type": "Dark Special wood  / 8 blades", "suitable_for": "ceilimg", "sweep": "1524mm / D 60in", "height_of_fan": "478mm / 19in", "light_option": "LED 3000, 4000 & 6000k 22Watts", "motor_spec": "copper winding D/C motor", "airflow": "11230 / Summer /Winter option", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/ORION_PLUS_130.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('6258bfe1-996c-43d8-adda-d5505f3fd0d8', 'FAN-ORION', 'ORION', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('5f033461-71d4-4737-bc2b-33ecabcd265f', '6258bfe1-996c-43d8-adda-d5505f3fd0d8', 'FAN-ORION-131', 'ORION', 42770, 42770, true, true, '{"blade_type": "Dark Special wood  / 8 blades", "suitable_for": "ceilimg", "sweep": "1524mm / D 60in", "height_of_fan": "478mm / 19in", "motor_spec": "copper winding D/C motor", "airflow": "11230 / Summer /Winter option", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/ORION_131.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('7a00b37f-50ae-4270-a8a2-75e6a86c3114', 'FAN-SWAN_PLUS', 'SWAN PLUS', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('fcb6eebb-6d02-4535-9224-9b987e01e6fa', '7a00b37f-50ae-4270-a8a2-75e6a86c3114', 'FAN-SWAN_PLUS-132', 'SWAN PLUS', 23770, 23770, true, true, '{"blade_type": "Reversible Walnut Special Wooden Blades & Oak Special Wooden Blades / 3 blades", "suitable_for": "ceilimg", "sweep": "1321mm / D 52in", "height_of_fan": "300mm / 12in", "light_option": "LED 3000, 4000 & 6000k 18Watts", "motor_spec": "153 x 12   / copper winding D/C motor", "airflow": "7350 / Summer /Winter option", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/SWAN_PLUS_132.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('5ca3fb77-4906-4e8f-bce6-ec78e42b6af7', 'FAN-SWAN', 'SWAN', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('ed3258c2-b3c4-4a57-afdd-50e44d5a5fb4', '5ca3fb77-4906-4e8f-bce6-ec78e42b6af7', 'FAN-SWAN-133', 'SWAN', 22770, 22770, true, true, '{"blade_type": "Reversible Walnut Special Wooden Blades & Oak Special Wooden Blades / 3 blades", "suitable_for": "ceilimg", "sweep": "1321mm / D 52in", "height_of_fan": "300mm / 12in", "motor_spec": "153 x 12   / copper winding D/C motor", "airflow": "7350 / Summer /Winter option", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/SWAN_133.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('567851aa-0bdc-4e8d-a30a-d6f8ddc60fda', 'FAN-SWIFT_PLUS', 'SWIFT PLUS', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('5fec8590-bb07-4711-9b15-7bc6588770c1', '567851aa-0bdc-4e8d-a30a-d6f8ddc60fda', 'FAN-SWIFT_PLUS-134', 'SWIFT PLUS', 25770, 25770, true, true, '{"blade_type": "Matte Black ABS  / 5 blades", "suitable_for": "ceilimg", "sweep": "1524mm / D 60in", "height_of_fan": "415mm / 16in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 15 / copper winding D/C motor", "airflow": "10350 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/SWIFT_PLUS_134.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('29a9d4ec-e59b-4867-bc58-1a8b9abbcabd', '567851aa-0bdc-4e8d-a30a-d6f8ddc60fda', 'FAN-SWIFT_PLUS-135', 'SWIFT PLUS', 25770, 25770, true, true, '{"blade_type": "Matte White ABS  / 5 blades", "suitable_for": "ceilimg", "sweep": "1524mm / D 60in", "height_of_fan": "415mm / 16in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 15 / copper winding D/C motor", "airflow": "10350 / Summer /Winter option", "colour": "Matte White", "media": {"primaryImage": "/images/products/SWIFT_PLUS_135.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('c9812b35-8279-474e-b2f2-224e26f4d618', '567851aa-0bdc-4e8d-a30a-d6f8ddc60fda', 'FAN-SWIFT_PLUS-136', 'SWIFT PLUS', 28770, 28770, true, true, '{"blade_type": "Golden Oak Wooden ABS Blade  / 5 blades", "suitable_for": "ceilimg", "sweep": "1524mm / D 60in", "height_of_fan": "415mm / 16in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 15 / copper winding D/C motor", "airflow": "10350 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/SWIFT_PLUS_136.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('e8df564e-edb9-4a47-802c-350755741676', 'FAN-MAYBACH', 'MAYBACH', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('e1a7c699-cb7c-495c-91c7-a0c303eb61ff', 'e8df564e-edb9-4a47-802c-350755741676', 'FAN-MAYBACH-137', 'MAYBACH', 28770, 28770, true, true, '{"blade_type": "Black ABS / 3 blades", "suitable_for": "ceilimg", "sweep": "1320mm /D 52in", "height_of_fan": "430 mm/17in", "motor_spec": "155 x 20  / copper winding D/C motor", "airflow": "7850 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/MAYBACH_137.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('f85437d6-97c2-4cdd-8634-90ee9582c46c', 'e8df564e-edb9-4a47-802c-350755741676', 'FAN-MAYBACH-138', 'MAYBACH', 28770, 28770, true, true, '{"blade_type": "White ABS / 3 blades", "suitable_for": "ceilimg", "sweep": "1320mm /D 52in", "height_of_fan": "430 mm/17in", "motor_spec": "155 x 20  / copper winding D/C motor", "airflow": "7850 / Summer /Winter option", "colour": "Matte White", "media": {"primaryImage": "/images/products/MAYBACH_138.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('9922930a-f644-49d6-aeeb-fdf58cf57010', 'e8df564e-edb9-4a47-802c-350755741676', 'FAN-MAYBACH-139', 'MAYBACH', 31770, 31770, true, true, '{"blade_type": "Pine Wood ABS / 3 blades", "suitable_for": "ceilimg", "sweep": "1320mm /D 52in", "height_of_fan": "430 mm/17in", "motor_spec": "155 x 20  / copper winding D/C motor", "airflow": "7850 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/MAYBACH_139.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('e2ca4b15-e280-447b-807f-06fe1bb99293', 'e8df564e-edb9-4a47-802c-350755741676', 'FAN-MAYBACH-140', 'MAYBACH', 31770, 31770, true, true, '{"blade_type": "Dark Walnut Wooden ABS / 3 blades", "suitable_for": "ceilimg", "sweep": "1320mm /D 52in", "height_of_fan": "430 mm/17in", "motor_spec": "155 x 20  / copper winding D/C motor", "airflow": "7850 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/MAYBACH_140.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('52ffed5c-f7a5-4492-9a63-4892ff35c7eb', 'e8df564e-edb9-4a47-802c-350755741676', 'FAN-MAYBACH-141', 'MAYBACH', 31770, 31770, true, true, '{"blade_type": "Pine Wood ABS / 3 blades", "suitable_for": "ceilimg", "sweep": "1320mm /D 52in", "height_of_fan": "430 mm/17in", "motor_spec": "155 x 20  / copper winding D/C motor", "airflow": "7850 / Summer /Winter option", "colour": "Matte White", "media": {"primaryImage": "/images/products/MAYBACH_141.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('ab577d7f-5e73-4f4a-be7e-b1cca6a7ffa8', 'FAN-COLUMBIA_Hugger', 'COLUMBIA
Hugger', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('aac20bb4-66fa-4d0d-83d8-d37cef12adc3', 'ab577d7f-5e73-4f4a-be7e-b1cca6a7ffa8', 'FAN-COLUMBIA_Hugger-142', 'COLUMBIA
Hugger', 29770, 29770, true, true, '{"blade_type": "Matte Black ABS  / 5 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1422mm / D 56in", "height_of_fan": "254mm / 10 in", "motor_spec": "/ copper winding D/C motor", "airflow": "10000 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/COLUMBIA_Hugger_142.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('8ec1a232-469a-4829-b207-dc4349c73292', 'ab577d7f-5e73-4f4a-be7e-b1cca6a7ffa8', 'FAN-COLUMBIA_Hugger-143', 'COLUMBIA
Hugger', 29770, 29770, true, true, '{"blade_type": "Matte White ABS blades / 5 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1422mm / D 56in", "height_of_fan": "254mm / 10 in", "motor_spec": "/ copper winding D/C motor", "airflow": "10000 / Summer /Winter option", "colour": "Matte white", "media": {"primaryImage": "/images/products/COLUMBIA_Hugger_143.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('24746d17-94e3-4bb8-92b0-6f73f73e107e', 'ab577d7f-5e73-4f4a-be7e-b1cca6a7ffa8', 'FAN-COLUMBIA_Hugger-144', 'COLUMBIA
Hugger', 35770, 35770, true, true, '{"blade_type": "Brown Wooden ABS blades / 5 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1422mm / D 56in", "height_of_fan": "254mm / 10 in", "motor_spec": "/ copper winding D/C motor", "airflow": "10000 / Summer /Winter option", "colour": "Matte white", "media": {"primaryImage": "/images/products/COLUMBIA_Hugger_144.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('8961c5f4-e9bf-4ae6-824e-6a6a9fb94f55', 'FAN-VORTEX_Hugger', 'VORTEX
Hugger', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('8f0c0779-4475-4a05-a91c-0d1de4de251c', '8961c5f4-e9bf-4ae6-824e-6a6a9fb94f55', 'FAN-VORTEX_Hugger-145', 'VORTEX
Hugger', 29770, 29770, true, true, '{"blade_type": "Matte Black ABS  / 5 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1320mm / D 52in", "height_of_fan": "309mm / 12 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "8950 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/VORTEX_Hugger_145.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('6218be3a-e25a-4a55-b790-8b3dc2b28d0a', '8961c5f4-e9bf-4ae6-824e-6a6a9fb94f55', 'FAN-VORTEX_Hugger-146', 'VORTEX
Hugger', 29770, 29770, true, true, '{"blade_type": "Matte White ABS  / 5 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1320mm / D 52in", "height_of_fan": "309mm / 12 in", "motor_spec": "153 x 15 / copper winding D/C motor", "airflow": "8950 / Summer /Winter option", "colour": "Chrome", "media": {"primaryImage": "/images/products/VORTEX_Hugger_146.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('7debaf5d-1d26-48b0-abf4-cd15cf1385fe', '8961c5f4-e9bf-4ae6-824e-6a6a9fb94f55', 'FAN-VORTEX_Hugger-147', 'VORTEX
Hugger', 29770, 29770, true, true, '{"blade_type": "Light Wood ABS  / 5 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1320mm / D 52in", "height_of_fan": "309mm / 12 in", "motor_spec": "153 x 15 / copper winding D/C motor", "airflow": "8950 / Summer /Winter option", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/VORTEX_Hugger_147.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('49c01295-8930-4464-b5f1-3020880c88f2', 'FAN-CLASSIC_Hugger', 'CLASSIC
Hugger', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('744db411-37a4-4eda-bdd5-770b38bdd906', '49c01295-8930-4464-b5f1-3020880c88f2', 'FAN-CLASSIC_Hugger-148', 'CLASSIC
Hugger', 31770, 31770, true, true, '{"blade_type": "Brown Rattan ABS blades  / 5 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1320mm / D 52in", "height_of_fan": "480mm / 18in", "motor_spec": "155 x 20   / copper winding A/C motor", "airflow": "8250 / Summer /Winter option", "body_color": "Dark Bronze & Black", "media": {"primaryImage": "/images/products/CLASSIC_Hugger_148.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('36728d9d-8a9d-4a25-9321-2f90e3ce4586', '49c01295-8930-4464-b5f1-3020880c88f2', 'FAN-CLASSIC_Hugger-149', 'CLASSIC
Hugger', 31770, 31770, true, true, '{"blade_type": "Dark Brown Rattan ABS blades / 5 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1320mm / D 52in", "height_of_fan": "480mm / 18in", "motor_spec": "155 x 20   / copper winding A/C motor", "airflow": "8250 / Summer /Winter option", "body_color": "Dark Bronze & Black", "media": {"primaryImage": "/images/products/CLASSIC_Hugger_149.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b138cd93-a459-463c-bd9f-7e99315423a4', '49c01295-8930-4464-b5f1-3020880c88f2', 'FAN-CLASSIC_Hugger-150', 'CLASSIC
Hugger', 31770, 31770, true, true, '{"blade_type": "Matte White Rattan ABS blades / 5 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1320mm / D 52in", "height_of_fan": "480mm / 18in", "motor_spec": "155 x 20   / copper winding A/C motor", "airflow": "8250 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/CLASSIC_Hugger_150.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('4bacd326-3362-4989-8a08-5c1ff5cf3a23', 'FAN-ARUM', 'ARUM', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('8e9a49c1-57c6-4ebc-a1ab-cc2a82cc46d6', '4bacd326-3362-4989-8a08-5c1ff5cf3a23', 'FAN-ARUM-151', 'ARUM', 29770, 29770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "559mm / D 22in", "height_of_fan": "430mm / 17in", "light_option": "3000K, 4000K & 6000K LED 18Watts / DIM", "motor_spec": "140 x 20   / copper winding D/C motor", "airflow": "6350 / Summer /Winter option", "colour": "French Gold", "media": {"primaryImage": "/images/products/ARUM_151.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('96226dd7-681b-416a-aabc-3497f2063ded', 'FAN-ALICE', 'ALICE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('645c62b9-ff31-465b-b4db-26fbaf116eb8', '96226dd7-681b-416a-aabc-3497f2063ded', 'FAN-ALICE-152', 'ALICE', 29770, 29770, true, true, '{"blade_type": "Transparent Retractable ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "711mm / D 28in", "height_of_fan": "430mm / 17in", "light_option": "3000K, 4000K & 6000K LED 80 + 30Watts", "motor_spec": "140 x 20   / copper winding D/C motor", "airflow": "6350 / Summer /Winter option", "colour": "Champaign Gold", "media": {"primaryImage": "/images/products/ALICE_152.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('0755a1f0-22ae-4d59-8b8d-81e952785353', 'FAN-WINDSOR', 'WINDSOR', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('45c62f42-d9cc-4d98-a1fd-b705e1d03db9', '0755a1f0-22ae-4d59-8b8d-81e952785353', 'FAN-WINDSOR-153', 'WINDSOR', 26770, 26770, true, true, '{"blade_type": "Dark Wood ABS  / 3 blades", "suitable_for": "Ceiling / Wall", "sweep": "305mm / D 12in", "height_of_fan": "620mm / 24in", "motor_spec": "52 x 10 / copper winding D/C motor", "airflow": "9650 / Summer /Winter option", "oscillation": "80\u00ba wide-angle", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/WINDSOR_153.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('f9cec5d0-e308-4798-8234-baec7408099e', 'FAN-ZINNIA', 'ZINNIA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('9e232e48-80fb-44af-babc-e914525246a4', 'f9cec5d0-e308-4798-8234-baec7408099e', 'FAN-ZINNIA-154', 'ZINNIA', 43770, 43770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "450mm / 17in", "light_option": "3000K, 4000K & 6000K  LED 32 Watts", "motor_spec": "188 x 22   / copper winding D/C motor", "airflow": "8475 / Summer /Winter option", "body_color": "French Gold", "media": {"primaryImage": "/images/products/ZINNIA_154.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('ac9e18a7-0552-46e6-91c7-70428acefc77', 'FAN-ELEGANT', 'ELEGANT', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('736695b4-22e1-428c-a72c-b9555961dc0d', 'ac9e18a7-0552-46e6-91c7-70428acefc77', 'FAN-ELEGANT-155', 'ELEGANT', 29770, 29770, true, true, '{"blade_type": "Matte Black ABS blades  / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "366mm / 15in", "motor_spec": "155 x 18  / copper winding D/C motor", "airflow": "8250 / Summer /Winter option", "body_color": "Gold", "media": {"primaryImage": "/images/products/ELEGANT_155.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('639002e4-1b07-417a-b2bb-570319dda33a', 'ac9e18a7-0552-46e6-91c7-70428acefc77', 'FAN-ELEGANT-156', 'ELEGANT', 29770, 29770, true, true, '{"blade_type": "Matte Black ABS blades  / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "366mm / 15in", "motor_spec": "155 x 18  / copper winding D/C motor", "airflow": "8250 / Summer /Winter option", "body_color": "Chrome", "media": {"primaryImage": "/images/products/ELEGANT_156.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('581b22ba-d40b-4a5d-90b5-5b8386ee328a', 'ac9e18a7-0552-46e6-91c7-70428acefc77', 'FAN-ELEGANT-157', 'ELEGANT', 29770, 29770, true, true, '{"blade_type": "Matte White ABS  / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "366mm / 15in", "motor_spec": "155 x 18  / copper winding D/C motor", "airflow": "8250 / Summer /Winter option", "body_color": "Gold", "media": {"primaryImage": "/images/products/ELEGANT_157.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('73a42411-8553-45b3-b1d2-d06476c299be', 'ac9e18a7-0552-46e6-91c7-70428acefc77', 'FAN-ELEGANT-158', 'ELEGANT', 29770, 29770, true, true, '{"blade_type": "Matte White ABS  / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "366mm / 15in", "motor_spec": "155 x 18  / copper winding D/C motor", "airflow": "8250 / Summer /Winter option", "body_color": "Chrome", "media": {"primaryImage": "/images/products/ELEGANT_158.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('e3e8f6e3-da82-48c8-b77a-5b28a4993d95', 'FAN-INFINITY', 'INFINITY', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('daa326a1-1949-4c34-b47e-ed2cedb341b0', 'e3e8f6e3-da82-48c8-b77a-5b28a4993d95', 'FAN-INFINITY-159', 'INFINITY', 27770, 27770, true, true, '{"blade_type": "Wood ABS blades / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "366mm / 15in", "motor_spec": "155 x 18  / copper winding D/C motor", "airflow": "8250 / Summer /Winter option", "body_color": "Wood"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('39a0044c-2861-497c-a2c8-20e8e2fbcd7d', 'FAN-AUDI', 'AUDI', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('6efec6bf-38af-4d3a-9183-633c2eacff6e', '39a0044c-2861-497c-a2c8-20e8e2fbcd7d', 'FAN-AUDI-160', 'AUDI', 24770, 24770, true, true, '{"blade_type": "Matte White ABS  / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "482mm / 19in", "motor_spec": "153 x 15   / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "colour": "Matte White", "media": {"primaryImage": "/images/products/AUDI_160.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('6254ba17-e9e4-49ed-bf57-97dc2dde5cc9', 'FAN-ORCHID', 'ORCHID', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('81d0d595-c95b-4100-aff7-92060a2b9aac', '6254ba17-e9e4-49ed-bf57-97dc2dde5cc9', 'FAN-ORCHID-161', 'ORCHID', 35770, 35770, true, true, '{"blade_type": "Matte White ABS  / 3 blades", "suitable_for": "Ceiling", "sweep": "1270mm /D 50in", "height_of_fan": "477mm / 18in", "light_option": "LED 36watts 4 colour", "motor_spec": "153 x 18  / copper winding D/C motor", "airflow": "8401 / Summer /Winter option", "colour": "Matte White"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('37f9f85b-d214-4691-8aef-32ae21bf7816', 'FAN-ASTER', 'ASTER', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('7e7c0e16-c3d5-491c-94c0-91983441fce0', '37f9f85b-d214-4691-8aef-32ae21bf7816', 'FAN-ASTER-162', 'ASTER', 31770, 31770, true, true, '{"blade_type": "Matte White ABS  / 3 blades", "suitable_for": "Ceiling", "sweep": "1168mm / D 46in", "height_of_fan": "555mm / 21in", "light_option": "LED 45Watts", "motor_spec": "153 x 18  / copper winding D/C motor", "airflow": "6648 / Summer /Winter option", "colour": "Matte White", "media": {"primaryImage": "/images/products/ASTER_162.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('5754df5f-6ff1-48c8-b2b1-524523b22066', 'FAN-COASTA__56', 'COASTA ''56'' +', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('8190d7b3-dea6-47bd-a333-4ce8ccc6cce8', '5754df5f-6ff1-48c8-b2b1-524523b22066', 'FAN-COASTA__56-163', 'COASTA ''56'' +', 29770, 29770, true, true, '{"blade_type": "Dark Wood ABS blades / 3 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "501mm / 20in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 18  / copper winding D/C motor", "airflow": "9930 / Summer /Winter option", "body_color": "Dark Wood", "media": {"primaryImage": "/images/products/COASTA__56_163.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('208710ce-8eb2-4abf-b7fd-9604fedce0d0', '5754df5f-6ff1-48c8-b2b1-524523b22066', 'FAN-COASTA__56-164', 'COASTA ''56''', 28770, 28770, true, true, '{"blade_type": "Light Wood ABS blades / 3 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "501mm / 20in", "motor_spec": "153 x 18  / copper winding D/C motor", "airflow": "9930 / Summer /Winter option", "body_color": "Light Wood", "media": {"primaryImage": "/images/products/COASTA__56_164.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('5be18637-e641-4a47-9478-98ab26f6203a', '5754df5f-6ff1-48c8-b2b1-524523b22066', 'FAN-COASTA__56-165', 'COASTA ''56'' +', 29770, 29770, true, true, '{"blade_type": "Light Wood ABS blades / 3 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "501mm / 20in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 18  / copper winding D/C motor", "airflow": "9930 / Summer /Winter option", "body_color": "Light Wood", "media": {"primaryImage": "/images/products/COASTA__56_165.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('f2af5119-2abf-4f65-827a-5b1dd9f04a9f', '5754df5f-6ff1-48c8-b2b1-524523b22066', 'FAN-COASTA__56-166', 'COASTA ''56''', 28770, 28770, true, true, '{"blade_type": "Matte White ABS blades / 3 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "501mm / 20in", "motor_spec": "153 x 18  / copper winding D/C motor", "airflow": "9930 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/COASTA__56_166.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('9f7446b9-164f-46bc-8c8f-4a25ab74eb72', '5754df5f-6ff1-48c8-b2b1-524523b22066', 'FAN-COASTA__56-167', 'COASTA ''56'' +', 29770, 29770, true, true, '{"blade_type": "Matte White ABS blades / 3 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "501mm / 20in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 18  / copper winding D/C motor", "airflow": "9930 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/COASTA__56_167.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('8cbe187c-7f12-4cb1-8dd9-98cdf952b2ad', 'FAN-COASTA__36', 'COASTA ''36''', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('cf7b35c5-6a88-46e7-8e06-9145c1896c7f', '8cbe187c-7f12-4cb1-8dd9-98cdf952b2ad', 'FAN-COASTA__36-168', 'COASTA ''36''', 28770, 28770, true, true, '{"blade_type": "Matte White ABS blades / 3 blades", "suitable_for": "Ceiling", "sweep": "914mm / D 36 in", "height_of_fan": "501mm / 20in", "motor_spec": "153 x 18  / copper winding D/C motor", "airflow": "7286 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/COASTA__36_168.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('ea3e6a0d-f496-49ac-9734-8400ad458a55', '8cbe187c-7f12-4cb1-8dd9-98cdf952b2ad', 'FAN-COASTA__36-169', 'COASTA ''36'' +', 29770, 29770, true, true, '{"blade_type": "Matte White ABS blades / 3 blades", "suitable_for": "Ceiling", "sweep": "914mm / D 36 in", "height_of_fan": "501mm / 20in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 18  / copper winding D/C motor", "airflow": "7286 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/COASTA__36_169.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('5dc13a9d-8819-4dbd-8660-53f655dfe2c7', '8cbe187c-7f12-4cb1-8dd9-98cdf952b2ad', 'FAN-COASTA__36-170', 'COASTA ''36'' +', 29770, 29770, true, true, '{"blade_type": "Light Wood ABS blades / 3 blades", "suitable_for": "Ceiling", "sweep": "914mm / D 36 in", "height_of_fan": "501mm / 20in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 18  / copper winding D/C motor", "airflow": "7286 / Summer /Winter option", "body_color": "Light Wood", "media": {"primaryImage": "/images/products/COASTA__36_170.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b8859970-f1ae-4d2c-9f2a-f54874f4c563', '8cbe187c-7f12-4cb1-8dd9-98cdf952b2ad', 'FAN-COASTA__36-171', 'COASTA ''36''', 28770, 28770, true, true, '{"blade_type": "Light Wood ABS blades  / 3 blades", "suitable_for": "Ceiling", "sweep": "914mm / D 36 in", "height_of_fan": "501mm / 20in", "motor_spec": "153 x 18  / copper winding D/C motor", "airflow": "7286 / Summer /Winter option", "body_color": "Light Wood", "media": {"primaryImage": "/images/products/COASTA__36_171.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('0a8ea20c-b2ea-4bb8-af0f-01ead080756e', 'FAN-ORION_Hugger', 'ORION
Hugger', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('69ef6f09-8448-4f98-9e60-f2b0de2ce7bb', '0a8ea20c-b2ea-4bb8-af0f-01ead080756e', 'FAN-ORION_Hugger-172', 'ORION
Hugger', 43770, 43770, true, true, '{"blade_type": "Dark Special wood  / 8 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1524mm / D 60in", "height_of_fan": "335mm / 13in", "motor_spec": "copper winding D/C motor", "airflow": "11230 / Summer /Winter option", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/ORION_Hugger_172.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('d66e7afd-e37b-4bb2-b74f-23cc20aed392', 'FAN-ORION_PLUS_Hugger', 'ORION PLUS
Hugger', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('a6c468f9-b1c3-4d7f-abbd-213a9cd46cf9', 'd66e7afd-e37b-4bb2-b74f-23cc20aed392', 'FAN-ORION_PLUS_Hugger-173', 'ORION PLUS
Hugger', 44770, 44770, true, true, '{"blade_type": "Dark Special wood  / 8 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1524mm / D 60in", "height_of_fan": "335mm / 13in", "light_option": "LED 3000, 4000 & 6000k 22Watts", "motor_spec": "copper winding D/C motor", "airflow": "11230 / Summer /Winter option", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/ORION_PLUS_Hugger_173.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('8f8b7d0b-d33f-48b3-a88d-9087fe8cc279', 'FAN-FALCON__Hugger', 'FALCON 
Hugger', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('d466d669-682f-46f3-9940-5ef343d35ec0', '8f8b7d0b-d33f-48b3-a88d-9087fe8cc279', 'FAN-FALCON__Hugger-174', 'FALCON 
Hugger', 28770, 28770, true, true, '{"blade_type": "Light Walnut Wood ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1422mm / D 56in", "height_of_fan": "309mm / 12in", "light_option": "LED 3000, 4000 & 6000K 18Watts", "motor_spec": "153 x 12  / copper winding D/C motor", "airflow": "9350 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/FALCON__Hugger_174.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('672359ec-bc77-4384-b7bf-e7dd7b3c55dd', '8f8b7d0b-d33f-48b3-a88d-9087fe8cc279', 'FAN-FALCON__Hugger-175', 'FALCON 
Hugger', 26770, 26770, true, true, '{"blade_type": "Matte White ABS / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1422mm / D 56in", "height_of_fan": "309mm / 12in", "light_option": "LED 3000, 4000 & 6000K 18Watts", "motor_spec": "153 x 12  / copper winding D/C motor", "airflow": "9350 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/FALCON__Hugger_175.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('35248ca1-cdd4-486c-bd14-da2ce76754f8', '8f8b7d0b-d33f-48b3-a88d-9087fe8cc279', 'FAN-FALCON__Hugger-176', 'FALCON 
Hugger', 26770, 26770, true, true, '{"blade_type": "Matte Black ABS blades / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1422mm / D 56in", "height_of_fan": "309mm / 12in", "light_option": "LED 3000, 4000 & 6000K 18Watts", "motor_spec": "153 x 12  / copper winding D/C motor", "airflow": "9350 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/FALCON__Hugger_176.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('a98f1df7-4380-4664-8419-7c9e70d85eae', '8f8b7d0b-d33f-48b3-a88d-9087fe8cc279', 'FAN-FALCON__Hugger-177', 'FALCON 
Hugger', 28770, 28770, true, true, '{"blade_type": "Oakgold Wooden ABS blade / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1422mm / D 56in", "height_of_fan": "309mm / 12in", "light_option": "LED 3000, 4000 & 6000K 18Watts", "motor_spec": "153 x 12  / copper winding D/C motor", "airflow": "9350 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/FALCON__Hugger_177.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('ff0a7eba-9048-41e4-9311-cd8ccfe1168f', 'FAN-MILANO', 'MILANO  +', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('68b1ca00-8c71-4194-9172-92a2cd718cb8', 'ff0a7eba-9048-41e4-9311-cd8ccfe1168f', 'FAN-MILANO-178', 'MILANO  +', 31770, 31770, true, true, '{"blade_type": "White ABS  / 6 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52 in", "height_of_fan": "517mm / 20in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 18  / copper winding D/C motor", "airflow": "8475 / Summer /Winter option", "colour": "Matte White"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b2b34378-56eb-478a-8d2e-c1216db675bd', 'ff0a7eba-9048-41e4-9311-cd8ccfe1168f', 'FAN-MILANO-179', 'MILANO  +', 31770, 31770, true, true, '{"blade_type": "Grey ABS  / 6 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52 in", "height_of_fan": "517mm / 20in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 18  / copper winding D/C motor", "airflow": "8475 / Summer /Winter option", "colour": "Chrome", "media": {"primaryImage": "/images/products/FALCON__Hugger_177.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('c886a798-0480-44bb-8570-0365136a288c', 'FAN-WHISPER', 'WHISPER', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('db76dba0-4703-4c36-ab85-fd6899ed239e', 'c886a798-0480-44bb-8570-0365136a288c', 'FAN-WHISPER-180', 'WHISPER', 28770, 28770, true, true, '{"blade_type": "Dark Wood ABS  / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52 in", "height_of_fan": "480mm / 19in", "motor_spec": "155 x 20  / copper winding D/C motor", "airflow": "9535 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/WHISPER_180.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('5ca8ae9c-89e0-4feb-acd4-ea642e52480f', 'FAN-IRIS', 'IRIS', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('1a29b795-77a6-42ba-806c-2bfe67d662ef', '5ca8ae9c-89e0-4feb-acd4-ea642e52480f', 'FAN-IRIS-181', 'IRIS', 27770, 27770, true, true, '{"blade_type": "Transparent Blue ABS blades / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52 in", "height_of_fan": "578mm / 23in", "light_option": "LED 3000, 4000 & 6000k 18Watts", "motor_spec": "188 x 18 / copper winding A/C motor", "airflow": "8750", "body_color": "Chrome"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('ab9949e7-41b0-424f-b20f-46c5abee6923', '5ca8ae9c-89e0-4feb-acd4-ea642e52480f', 'FAN-IRIS-182', 'IRIS', 27770, 27770, true, true, '{"blade_type": "Transparent ABS blades / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52 in", "height_of_fan": "578mm / 23in", "light_option": "LED 3000, 4000 & 6000k 18Watts", "motor_spec": "188 x 18 / copper winding A/C motor", "airflow": "8750", "body_color": "Chrome", "media": {"primaryImage": "/images/products/WHISPER_180.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('85e31488-935e-4607-bd89-2c5566d32f5d', 'FAN-WIND_MILL', 'WIND MILL', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('d2fc49b4-7793-45fc-b98e-4fec5fc3860b', '85e31488-935e-4607-bd89-2c5566d32f5d', 'FAN-WIND_MILL-183', 'WIND MILL', 30770, 30770, true, true, '{"blade_type": "Transparent Blue ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1270mm / D 50 in", "height_of_fan": "549mm / 21in", "light_option": "LED 3000, 4000 & 6000k 18Watts", "motor_spec": "188 x 20 / copper winding A/C motor", "airflow": "7410", "colour": "Chrome"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('d8660080-029b-48d7-9b45-ac17b3ce00fe', '85e31488-935e-4607-bd89-2c5566d32f5d', 'FAN-WIND_MILL-184', 'WIND MILL', 29770, 29770, true, true, '{"blade_type": "Matte White ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1270mm / D 50 in", "height_of_fan": "549mm / 21in", "light_option": "LED 3000, 4000 & 6000k 18Watts", "motor_spec": "188 x 20 / copper winding A/C motor", "airflow": "7410", "colour": "White", "media": {"primaryImage": "/images/products/WHISPER_180.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('5e2d7fc4-8473-4839-a58b-f1746654368c', 'FAN-AMOR', 'AMOR', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('73be39b8-db7b-4f4d-99a6-99c2821664cb', '5e2d7fc4-8473-4839-a58b-f1746654368c', 'FAN-AMOR-185', 'AMOR', 33770, 33770, true, true, '{"blade_type": "Brown ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1066mm / D 42in", "height_of_fan": "454mm / 17in", "light_option": "LED 3000, 4000 & 6000k  55 watts 4 colour", "motor_spec": "153 x 20 / copper winding D/C motor", "airflow": "6360 / Summer /Winter option", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/AMOR_185.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('23fadb15-53e0-4212-bf7c-4e594534309e', 'FAN-MINIZO', 'MINIZO', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('60e47efe-0098-4dce-8146-e5e10e159d48', '23fadb15-53e0-4212-bf7c-4e594534309e', 'FAN-MINIZO-186', 'MINIZO', 23770, 23770, true, true, '{"blade_type": "Wood ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "711mm / D 28in", "height_of_fan": "350mm / 14in", "light_option": "LED 3000, 4000 & 6000k  18 watts", "motor_spec": "139 x 20 / copper winding D/C motor", "airflow": "7210 / Summer /Winter option", "colour": "Wood", "media": {"primaryImage": "/images/products/MINIZO_186.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('a7bf13a6-a2ed-4934-aef3-55260cfd6147', '23fadb15-53e0-4212-bf7c-4e594534309e', 'FAN-MINIZO-187', 'MINIZO', 22770, 22770, true, true, '{"blade_type": "Matte White ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "711mm / D 28in", "height_of_fan": "350mm / 14in", "light_option": "LED 3000, 4000 & 6000k  18 watts", "motor_spec": "139 x 20 / copper winding D/C motor", "airflow": "7210 / Summer /Winter option", "colour": "Matte White", "media": {"primaryImage": "/images/products/MINIZO_187.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('537981b7-6c97-427c-b36d-52cfd0bec727', 'FAN-APACHE', 'APACHE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('0e565254-065f-44b9-b3db-a32bd45c0694', '537981b7-6c97-427c-b36d-52cfd0bec727', 'FAN-APACHE-188', 'APACHE', 27770, 27770, true, true, '{"blade_type": "Matte White ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 48in", "light_option": "LED 3000, 4000 & 6000k  15 watts", "motor_spec": "155 x 20 / copper winding D/C motor", "airflow": "7210 / Summer /Winter option", "colour": "Chrome", "media": {"primaryImage": "/images/products/APACHE_188.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('e5fb778e-e8d0-4913-b830-a96204ddee85', 'FAN-IBIS', 'IBIS', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('88344ec0-7709-4043-adce-d827b1a77bc3', 'e5fb778e-e8d0-4913-b830-a96204ddee85', 'FAN-IBIS-189', 'IBIS', 20770, 20770, true, true, '{"blade_type": "Matte White ABS / 5 blades", "suitable_for": "Ceiling", "sweep": "1117mm /D 44in", "light_option": "LED 3000, 4000 & 6000k  40 watts", "motor_spec": "153 x 15 / copper winding D/C motor", "airflow": "6450 / Summer /Winter option", "colour": "White", "media": {"primaryImage": "/images/products/IBIS_189.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('3f176a8f-86b5-4bdd-b507-95ef8d939846', 'e5fb778e-e8d0-4913-b830-a96204ddee85', 'FAN-IBIS-190', 'IBIS', 20770, 20770, true, true, '{"blade_type": "Beige ABS / 5 blades", "suitable_for": "Ceiling", "sweep": "1117mm /D 44in", "light_option": "LED 3000, 4000 & 6000k  40 watts", "motor_spec": "153 x 15 / copper winding D/C motor", "airflow": "6450 / Summer /Winter option", "colour": "Matte Brown", "media": {"primaryImage": "/images/products/IBIS_190.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('797b5c51-0aa5-499f-bf91-9a3b992ec95e', 'FAN-KIDZY', 'KIDZY', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('969ceabd-1662-4dde-a2f5-c1eae173e103', '797b5c51-0aa5-499f-bf91-9a3b992ec95e', 'FAN-KIDZY-191', 'KIDZY', 27770, 27770, true, true, '{"blade_type": "Blue, Red & Yellow ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "914mm / D 36in", "height_of_fan": "558mm / 21in", "light_option": "LED 3000, 4000 & 6000k  24 watts", "motor_spec": "153 x 18 / copper winding D/C motor", "airflow": "5576 / Summer /Winter option", "colour": "Lemon Yellow"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('2dd65e07-49b2-4c4e-9c73-9f87519a01b2', 'FAN-GALAXY', 'GALAXY', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('7a90bbb7-dd96-4c9f-80f4-a158f1daaf3a', '2dd65e07-49b2-4c4e-9c73-9f87519a01b2', 'FAN-GALAXY-192', 'GALAXY', 36770, 36770, true, true, '{"blade_type": "Blue, Red & Yellow ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1066mm / D 42in", "height_of_fan": "536mm / 21in", "light_option": "LED 3000, 4000 & 6000k  52 watts", "motor_spec": "153 x 18 / copper winding D/C motor", "airflow": "6534 / Summer /Winter option", "colour": "Blue"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('c546a784-366a-4564-9b6c-90be49f0648d', 'FAN-FLAMINGO', 'FLAMINGO', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('dc395f79-9d51-4c70-a43d-37b01eb1caaa', 'c546a784-366a-4564-9b6c-90be49f0648d', 'FAN-FLAMINGO-193', 'FLAMINGO', 25770, 25770, true, true, '{"blade_type": "White ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "914mm / D 36in", "height_of_fan": "510mm / 20in", "light_option": "LED 3000, 4000 & 6000k  15 watts", "motor_spec": "155 x 18 / copper winding A/C motor", "airflow": "3980", "colour": "Matte White", "media": {"primaryImage": "/images/products/FLAMINGO_193.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('d0795347-b613-4dc2-933b-06a7489bf6bf', 'c546a784-366a-4564-9b6c-90be49f0648d', 'FAN-FLAMINGO-194', 'FLAMINGO', 30770, 30770, true, true, '{"blade_type": "Grey ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "914mm / D 36in", "height_of_fan": "510mm / 20in", "light_option": "LED 3000, 4000 & 6000k  15 watts", "motor_spec": "155 x 18 / copper winding A/C motor", "airflow": "3980", "colour": "Chrome", "media": {"primaryImage": "/images/products/IBIS_190.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('483f98d2-9bd0-4863-9a26-cd35212d4a2e', 'FAN-SPANIO', 'SPANIO', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('4d3aea4b-35f8-4235-9660-822b4be61d70', '483f98d2-9bd0-4863-9a26-cd35212d4a2e', 'FAN-SPANIO-195', 'SPANIO', 28770, 28770, true, true, '{"blade_type": "Dark Coffee ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "576mm / 23in", "light_option": "LED 3000, 4000 & 6000k  18 watts", "motor_spec": "188 x 12 / copper winding A/C motor", "airflow": "6360", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/SPANIO_195.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('881d78a9-4297-4615-9298-5098bc77d61e', 'FAN-MACH', 'MACH', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('40883b69-87ca-4e30-8407-e648817d7662', '881d78a9-4297-4615-9298-5098bc77d61e', 'FAN-MACH-196', 'MACH', 22770, 22770, true, true, '{"blade_type": "Dark Wood ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1066mm / D 42in", "height_of_fan": "576mm / 23in", "light_option": "LED 3000, 4000 & 6000k  24 watts", "motor_spec": "155 x 15 / copper winding D/C motor", "airflow": "6360 / Summer /Winter option", "colour": "Bronze", "media": {"primaryImage": "/images/products/MACH_196.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('cd261cc5-9d46-48f5-b6df-e6577dc2710c', 'FAN-DAISY', 'DAISY', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('9f19c410-cff7-46c4-8f94-6789df1aee11', 'cd261cc5-9d46-48f5-b6df-e6577dc2710c', 'FAN-DAISY-197', 'DAISY', 27770, 27770, true, true, '{"blade_type": "Dark Wood ABS / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "480mm / 18in", "motor_spec": "155 x 20 / copper winding A/C motor", "airflow": "6550 / Summer /Winter option", "colour": "Dark Brown", "media": {"primaryImage": "/images/products/DAISY_197.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('82af3a11-6849-4576-836f-bd37a061b66e', 'cd261cc5-9d46-48f5-b6df-e6577dc2710c', 'FAN-DAISY-198', 'DAISY +', 28770, 28770, true, true, '{"blade_type": "Dark Wood ABS / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "480mm / 18in", "light_option": "LED 8watts", "motor_spec": "155 x 20 / copper winding A/C motor", "airflow": "6550 / Summer /Winter option", "colour": "Dark Brown"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b2a3d043-16bb-4347-bb61-5f5b81f17da3', 'cd261cc5-9d46-48f5-b6df-e6577dc2710c', 'FAN-DAISY-199', 'DAISY', 27770, 27770, true, true, '{"blade_type": "Matte White ABS / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "480mm / 18in", "motor_spec": "155 x 20 / copper winding A/C motor", "airflow": "6550 / Summer /Winter option", "colour": "Matte White", "media": {"primaryImage": "/images/products/DAISY_199.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('a30cd0e1-a762-4c88-b2c6-5e0bad5864b7', 'FAN-MAPLE', 'MAPLE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('f35fe157-3124-4388-b1c7-711dffb95283', 'a30cd0e1-a762-4c88-b2c6-5e0bad5864b7', 'FAN-MAPLE-200', 'MAPLE', 0, 0, true, true, '{"blade_type": "Dark Wood ABS / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "647mm / 25in", "motor_spec": "188 x 15 / copper winding A/C motor", "airflow": "6391 / Summer /Winter option", "colour": "Antique Brass"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('2ad0d8d7-bc38-4d02-b696-861fe8442ff2', 'FAN-EUROPIA', 'EUROPIA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('fa6dbe9c-d462-49b3-a7c2-cb56711812e4', '2ad0d8d7-bc38-4d02-b696-861fe8442ff2', 'FAN-EUROPIA-201', 'EUROPIA', 28770, 28770, true, true, '{"blade_type": "Dark Brown ABS / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "597mm / 23in", "light_option": "LED 3000, 4000 & 6000k 18watts", "motor_spec": "188 x 18  / copper winding A/C motor", "airflow": "9530", "colour": "Antique Brass"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('848e9013-e647-4258-9bcc-d38d9ec526c1', 'FAN-RIO', 'RIO', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('2d807ee2-fb9d-4f28-b7ff-efce42721970', '848e9013-e647-4258-9bcc-d38d9ec526c1', 'FAN-RIO-202', 'RIO', 28770, 28770, true, true, '{"blade_type": "Dark Brown ABS / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "577mm / 22in", "light_option": "LED 3000, 4000 & 6000k 18watts", "motor_spec": "188 x 18  / copper winding A/C motor", "airflow": "9530", "colour": "Antique Brass"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('d6421f3b-d29c-46b4-960a-b2e994a98f96', 'FAN-BREEZA', 'BREEZA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b05a3d08-d8ae-47af-aa01-f0d58a3733cd', 'd6421f3b-d29c-46b4-960a-b2e994a98f96', 'FAN-BREEZA-203', 'BREEZA', 15770, 15770, true, true, '{"blade_type": "White ABS blades / 3 blades", "suitable_for": "Ceiling", "sweep": "1219mm / D 48in", "height_of_fan": "450mm / 17in", "light_option": "LED 3000, 4000 & 6000k 15watts", "motor_spec": "153 x 18   / copper winding A/C motor", "airflow": "6550 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/BREEZA_203.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('96a7d829-3a2c-4175-af75-792846ed99e3', 'd6421f3b-d29c-46b4-960a-b2e994a98f96', 'FAN-BREEZA-204', 'BREEZA', 15770, 15770, true, true, '{"blade_type": "Black ABS blades/ 3 blades", "suitable_for": "Ceiling", "sweep": "1219mm / D 48in", "height_of_fan": "450mm / 17in", "light_option": "LED 3000, 4000 & 6000k 15watts", "motor_spec": "153 x 18   / copper winding A/C motor", "airflow": "6550 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/DAISY_199.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('88d85f55-6f72-407d-ba7d-54627f401888', 'FAN-RAFFLE', 'RAFFLE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('43ff3f4e-776e-4b9d-8ae6-3e7d91029b9a', '88d85f55-6f72-407d-ba7d-54627f401888', 'FAN-RAFFLE-205', 'RAFFLE', 15770, 15770, true, true, '{"blade_type": "Matte Black ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1346mm / D 53in", "height_of_fan": "470mm / 18in", "motor_spec": "188 x 22  / copper winding A/C motor", "airflow": "9650 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/RAFFLE_205.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('868a6d97-2f95-46f7-94a3-4512b26b82ea', '88d85f55-6f72-407d-ba7d-54627f401888', 'FAN-RAFFLE-206', 'RAFFLE', 15770, 15770, true, true, '{"blade_type": "Matte White ABS blades / 4 blades", "suitable_for": "Ceiling", "sweep": "1346mm / D 53in", "height_of_fan": "470mm / 18in", "motor_spec": "188 x 22  / copper winding A/C motor", "airflow": "9650 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/RAFFLE_206.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('29f0e85c-f358-4c66-ace3-4338ee110a8c', '88d85f55-6f72-407d-ba7d-54627f401888', 'FAN-RAFFLE-207', 'RAFFLE', 17770, 17770, true, true, '{"blade_type": "Dark Wood ABS blades/ 4 blades", "suitable_for": "Ceiling", "sweep": "1346mm / D 53in", "height_of_fan": "470mm / 18in", "motor_spec": "188 x 22  / copper winding A/C motor", "airflow": "9650 / Summer /Winter option", "body_color": "Wood", "media": {"primaryImage": "/images/products/RAFFLE_207.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('d1dbf204-f3e8-47fb-a044-c129e718617a', 'FAN-GRACE', 'GRACE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('3085cf2e-12c2-449f-af97-f27f613732cb', 'd1dbf204-f3e8-47fb-a044-c129e718617a', 'FAN-GRACE-208', 'GRACE', 83770, 83770, true, true, '{"blade_type": "Transparent Black ABS / 14 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "820mm / 32in", "light_option": "4000K  LED 38 Watts", "motor_spec": "153 x 20  / copper winding D/C motor", "airflow": "8475 / Summer /Winter option", "body_color": "Gun Metal", "media": {"primaryImage": "/images/products/GRACE_208.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('7f9d6e8c-d5a7-4b99-ac58-300bb12d89da', 'FAN-EXCLUSIVE', 'EXCLUSIVE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('57042961-3ed9-4492-82ab-70ddc2410613', '7f9d6e8c-d5a7-4b99-ac58-300bb12d89da', 'FAN-EXCLUSIVE-209', 'EXCLUSIVE', 83770, 83770, true, true, '{"blade_type": "Transparent ABS / 14 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "820mm / 32in", "light_option": "4000K  LED 38 Watts", "motor_spec": "153 x 20  / copper winding D/C motor", "airflow": "8475 / Summer /Winter option", "body_color": "Chrome", "media": {"primaryImage": "/images/products/EXCLUSIVE_209.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('30c2a1a8-864e-4bc2-9032-a56b9e285454', 'FAN-BLOOM', 'BLOOM', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('85e2edab-19db-4452-9693-ddf5e627960c', '30c2a1a8-864e-4bc2-9032-a56b9e285454', 'FAN-BLOOM-210', 'BLOOM', 35770, 35770, true, true, '{"blade_type": "Transparent ABS / 8 blades", "suitable_for": "Ceiling", "sweep": "1066mm / D 42in", "height_of_fan": "780mm / 30in", "light_option": "1 Light kit E27 Holder", "motor_spec": "188 x 15  / copper winding A/C motor", "airflow": "6710", "colour": "Chrome", "media": {"primaryImage": "/images/products/BLOOM_210.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('42c08f02-fd51-4dbd-8c62-f4136b8144ed', 'FAN-TULIP', 'TULIP', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('4cd04f8d-9ad2-4bfe-9c37-77c7044382c0', '42c08f02-fd51-4dbd-8c62-f4136b8144ed', 'FAN-TULIP-211', 'TULIP', 35770, 35770, true, true, '{"blade_type": "Transparent Grape Brown ABS / 8 blades", "suitable_for": "Ceiling", "sweep": "1066mm / D 42in", "height_of_fan": "780mm / 30in", "light_option": "1 Light kit E27 Holder", "motor_spec": "188 x 15  / copper winding A/C motor", "airflow": "6710", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/TULIP_211.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('935db186-ea60-4bcb-9798-1ee8353d9097', 'FAN-MERC', 'MERC', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('81391d1f-432f-498c-aa43-4582bd79dac3', '935db186-ea60-4bcb-9798-1ee8353d9097', 'FAN-MERC-212', 'MERC', 88770, 88770, true, true, '{"blade_type": "Transparent ABS / 6 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "820mm / 33in", "light_option": "4000K  LED 45 Watts", "motor_spec": "143x 20  / copper winding D/C motor", "airflow": "8745", "colour": "Chrome", "media": {"primaryImage": "/images/products/MERC_212.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('3c253470-4e3f-441c-95ba-2d300236407b', '935db186-ea60-4bcb-9798-1ee8353d9097', 'FAN-MERC-213', 'MERC', 88770, 88770, true, true, '{"blade_type": "Transparent ABS / 6 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "820mm / 33in", "light_option": "4000K  LED 45 Watts", "motor_spec": "143x 20  / copper winding D/C motor", "airflow": "8745", "colour": "Gold", "media": {"primaryImage": "/images/products/MERC_213.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('d2c18b3d-67f9-4613-b32f-4551645c655f', 'FAN-MERC_X_SERIES', 'MERC X SERIES', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('4362b0f4-775d-4664-9d64-3e89e5c7aafe', 'd2c18b3d-67f9-4613-b32f-4551645c655f', 'FAN-MERC_X_SERIES-214', 'MERC X SERIES', 88770, 88770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1117mm / D 44in", "height_of_fan": "820mm / 33in", "light_option": "4000K  LED 45 Watts", "motor_spec": "153x 20  / copper winding D/C motor", "airflow": "8475 / Summer /Winter option", "colour": "Chrome", "media": {"primaryImage": "/images/products/MERC_X_SERIES_214.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('e6d02617-918b-4e96-80bb-6e360a70eec0', 'd2c18b3d-67f9-4613-b32f-4551645c655f', 'FAN-MERC_X_SERIES-215', 'MERC X SERIES', 88770, 88770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1117mm / D 44in", "height_of_fan": "820mm / 33in", "light_option": "4000K  LED 45 Watts", "motor_spec": "153x 20  / copper winding D/C motor", "airflow": "8475 / Summer /Winter option", "colour": "Gold", "media": {"primaryImage": "/images/products/MERC_X_SERIES_215.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('fcb500f9-02d0-4a3c-9041-6cb6d8777479', 'FAN-ROLEX', 'ROLEX', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('1ccc1a31-3692-4f6d-99ab-5d37f36ff6d6', 'fcb500f9-02d0-4a3c-9041-6cb6d8777479', 'FAN-ROLEX-216', 'ROLEX', 70770, 70770, true, true, '{"blade_type": "Transparent Retractable ABS blades / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "530mm / 20in", "light_option": "3000K, 4000K & 6000K  LED 64 Watts", "motor_spec": "188 x 22   / copper winding A/C motor", "airflow": "8475", "body_color": "French Gold", "media": {"primaryImage": "/images/products/ROLEX_216.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('e57a6702-3abe-4834-a744-ebf0ed9370ae', 'FAN-EMERALD', 'EMERALD', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('421b2a6f-a29b-4890-adfc-ded0dc08f9fa', 'e57a6702-3abe-4834-a744-ebf0ed9370ae', 'FAN-EMERALD-217', 'EMERALD', 49770, 49770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1117mm /D  44in", "height_of_fan": "574mm / 22in", "light_option": "3000K, 4000K & 6000K  LED 36 Watts", "motor_spec": "153x 15  / copper winding D/C motor", "airflow": "7495", "colour": "Chrome", "media": {"primaryImage": "/images/products/EMERALD_217.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('d5d2f3da-4825-4e0b-addc-180a29c89122', 'FAN-SOLITAIRE', 'SOLITAIRE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('8a4c07a7-a1e0-4b4d-b6bc-a83d96dcdad1', 'd5d2f3da-4825-4e0b-addc-180a29c89122', 'FAN-SOLITAIRE-218', 'SOLITAIRE', 68770, 68770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1117mm /D  44in", "height_of_fan": "574mm / 22in", "light_option": "3000K, 4000K & 6000K  LED 36 Watts", "motor_spec": "153x 15  / copper winding D/C motor", "airflow": "7495", "colour": "Chrome"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('8576b885-f81a-40ba-81eb-3220f94ab193', 'FAN-COOPER', 'COOPER', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('f5649b68-3e7f-4e58-b090-59cf955959e0', '8576b885-f81a-40ba-81eb-3220f94ab193', 'FAN-COOPER-219', 'COOPER', 38770, 38770, true, true, '{"blade_type": "Transparent Coffee Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm /D  42in", "height_of_fan": "500mm / 19in", "light_option": "3000K, 4000K & 6000K  LED 32 Watts", "motor_spec": "172 x 15  / copper winding A/C motor", "airflow": "7950", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/COOPER_219.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('badff0c7-d762-4b19-97d4-40f6f2f2549f', 'FAN-MONALISA', 'MONALISA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('1340f95a-06ff-4307-991a-8cd54353a9d7', 'badff0c7-d762-4b19-97d4-40f6f2f2549f', 'FAN-MONALISA-220', 'MONALISA', 35770, 35770, true, true, '{"blade_type": "Transparent Coffee Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm /D  42in", "height_of_fan": "610mm / 24in", "light_option": "3000K, 4000K & 6000K  LED 36 Watts", "motor_spec": "172 x 15  / copper winding A/C motor", "airflow": "7950", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/MONALISA_220.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('72a16778-645a-408a-90ed-c01106646a58', 'FAN-RUBY', 'RUBY', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('8f8bf2ec-908b-4c52-86b6-4c1db5c462ca', '72a16778-645a-408a-90ed-c01106646a58', 'FAN-RUBY-221', 'RUBY', 37770, 37770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm /D  42in", "height_of_fan": "500mm / 19in", "light_option": "3000K, 4000K & 6000K  LED 32 Watts", "motor_spec": "172 x 15  / copper winding A/C motor", "airflow": "7950", "colour": "French Gold", "media": {"primaryImage": "/images/products/RUBY_221.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('1675ec5d-43c7-482d-af79-b0a770a99b5d', 'FAN-PLATINUM', 'PLATINUM', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('256ea86c-92dc-4f81-825c-504742fc3220', '1675ec5d-43c7-482d-af79-b0a770a99b5d', 'FAN-PLATINUM-222', 'PLATINUM', 34770, 34770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm /D  42in", "height_of_fan": "500mm / 19in", "light_option": "3000K, 4000K & 6000K  LED 32 Watts", "motor_spec": "172 x 15  / copper winding A/C motor", "airflow": "7950", "colour": "Chrome", "media": {"primaryImage": "/images/products/PLATINUM_222.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('75402887-d309-45fb-942f-1be506b4daff', '1675ec5d-43c7-482d-af79-b0a770a99b5d', 'FAN-PLATINUM-223', 'PLATINUM', 34770, 34770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm /D  42in", "height_of_fan": "500mm / 19in", "light_option": "3000K, 4000K & 6000K  LED 32 Watts", "motor_spec": "172 x 15  / copper winding A/C motor", "airflow": "7950", "colour": "French Gold", "media": {"primaryImage": "/images/products/PLATINUM_223.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('1407d0a3-39b6-4db6-8f69-b2b2dabed50e', 'FAN-ROYAL', 'ROYAL', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('3ec81e8b-7e0e-42dd-b132-15bce3f32f52', '1407d0a3-39b6-4db6-8f69-b2b2dabed50e', 'FAN-ROYAL-224', 'ROYAL', 70770, 70770, true, true, '{"blade_type": "Transparent Retractable ABS / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "620mm / 24in", "light_option": "3000K, 4000K & 6000K  LED 64 Watts", "motor_spec": "188 x 22   / copper winding A/C motor", "airflow": "8475", "colour": "French Gold", "media": {"primaryImage": "/images/products/ROYAL_224.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('47fb92b4-474c-49c5-bf37-c6a181f1f3a5', 'FAN-SAPPHIRE', 'SAPPHIRE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('bec6c192-7bd4-4db5-8e4e-5225c33a49da', '47fb92b4-474c-49c5-bf37-c6a181f1f3a5', 'FAN-SAPPHIRE-225', 'SAPPHIRE', 31770, 31770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm /D  42in", "height_of_fan": "620mm / 24in", "light_option": "3000K, 4000K & 6000K  LED 36 Watts", "motor_spec": "172 x 15  / copper winding A/C motor", "airflow": "7950", "colour": "French Gold", "media": {"primaryImage": "/images/products/SAPPHIRE_225.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('a4c96274-3a8f-422b-86a7-803ab809e39c', 'FAN-CRYSTAL', 'CRYSTAL', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('3fe36eaf-11a4-4035-b255-53b1e6847c64', 'a4c96274-3a8f-422b-86a7-803ab809e39c', 'FAN-CRYSTAL-226', 'CRYSTAL', 30770, 30770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm /D  42in", "height_of_fan": "500mm / 19in", "light_option": "3000K, 4000K & 6000K  LED 32 Watts", "motor_spec": "172 x 15  / copper winding A/C motor", "airflow": "7950", "colour": "Chrome"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('db700542-a53f-44ab-a912-be37d96691d9', 'a4c96274-3a8f-422b-86a7-803ab809e39c', 'FAN-CRYSTAL-227', 'CRYSTAL', 30770, 30770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm /D  42in", "height_of_fan": "500mm / 19in", "light_option": "3000K, 4000K & 6000K  LED 32 Watts", "motor_spec": "172 x 15  / copper winding A/C motor", "airflow": "7950", "colour": "French Gold", "media": {"primaryImage": "/images/products/SAPPHIRE_225.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('66254cab-762e-44ce-abb3-673b42fb45ad', 'FAN-SPARKLE', 'SPARKLE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('f76d95df-5ffa-4e60-a974-b9778c0e3ec3', '66254cab-762e-44ce-abb3-673b42fb45ad', 'FAN-SPARKLE-228', 'SPARKLE', 34770, 34770, true, true, '{"blade_type": "Transparent Dark Brown Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm /D  42in", "height_of_fan": "480mm / 19in", "light_option": "3000K, 4000K & 6000K  LED 48 Watts", "motor_spec": "172 x 15  / copper winding D/C motor", "airflow": "7250 / Summer / Wintwer Option", "colour": "Dark Brown", "media": {"primaryImage": "/images/products/SPARKLE_228.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('b1dcd5b9-1d5f-4cbd-a2fb-a5bb6d956aef', 'FAN-BRONZE', 'BRONZE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('3bc76618-a79f-4dcd-a7ed-3e1171f02410', 'b1dcd5b9-1d5f-4cbd-a2fb-a5bb6d956aef', 'FAN-BRONZE-229', 'BRONZE', 32770, 32770, true, true, '{"blade_type": "Transparent Coffee Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm /D  42in", "height_of_fan": "500mm / 19in", "light_option": "3000K, 4000K & 6000K  LED 55 Watts", "motor_spec": "153 x 15  / copper winding A/C motor", "airflow": "7950", "colour": "Bronze", "media": {"primaryImage": "/images/products/BRONZE_229.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('54f3dacf-189a-41cf-af3f-920da56dbd05', 'FAN-RAYS', 'RAYS', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('43a32cf5-0010-46b3-a823-bb4f51abd839', '54f3dacf-189a-41cf-af3f-920da56dbd05', 'FAN-RAYS-230', 'RAYS', 34770, 34770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm /D  42in", "height_of_fan": "490mm / 19in", "light_option": "3000K, 4000K & 6000K  LED 32 Watts", "motor_spec": "153 x 15  / copper winding A/C motor", "airflow": "7950", "colour": "Matte White"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('520ef087-ef91-487f-acb7-1dfa6e4a2cdf', 'FAN-FUSION', 'FUSION', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('a0db4eeb-abc6-49a7-a301-13b1fe70dfe7', '520ef087-ef91-487f-acb7-1dfa6e4a2cdf', 'FAN-FUSION-231', 'FUSION', 38770, 38770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm /D  42in", "height_of_fan": "480mm / 18in", "light_option": "3000K, 4000K & 6000K  LED 32 Watts", "motor_spec": "172 x 15  / copper winding A/C motor", "airflow": "7950", "special_feature": "Inbuilt Bluetooth Speakers", "colour": "Matte White", "media": {"primaryImage": "/images/products/FUSION_231.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('2ce70da2-cca6-4403-8444-17aae8b81ad9', 'FAN-JUPITER', 'JUPITER', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('ceb9ce86-1065-4f0e-9c69-69b920391685', '2ce70da2-cca6-4403-8444-17aae8b81ad9', 'FAN-JUPITER-232', 'JUPITER', 27770, 27770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm /D  42in", "height_of_fan": "480mm / 18in", "light_option": "3000K, 4000K & 6000K  LED 55 Watts", "motor_spec": "153 x 15  / copper winding A/C motor", "airflow": "7550", "colour": "Antique Brass"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('eddd76d8-41e7-4c7b-a33c-f399682730cd', 'FAN-RAINBOW', 'RAINBOW', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b190aeae-2e05-4bfc-9837-0b17c4731b12', 'eddd76d8-41e7-4c7b-a33c-f399682730cd', 'FAN-RAINBOW-233', 'RAINBOW', 19770, 19770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "914mm /D 36in", "height_of_fan": "530mm / 20in", "light_option": "3000K, 4000K & 6000K  LED 36 Watts", "motor_spec": "153 x 12 / copper winding A/C motor", "airflow": "6280", "colour": "Matte Pink", "media": {"primaryImage": "/images/products/RAINBOW_233.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('21cb7dde-4b80-4409-a627-4435d1dd891c', 'eddd76d8-41e7-4c7b-a33c-f399682730cd', 'FAN-RAINBOW-234', 'RAINBOW', 19770, 19770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "914mm /D 36in", "height_of_fan": "530mm / 20in", "light_option": "3000K, 4000K & 6000K  LED 36 Watts", "motor_spec": "153 x 12 / copper winding A/C motor", "airflow": "6280", "colour": "Matte Blue", "media": {"primaryImage": "/images/products/RAINBOW_234.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('f6ff42ff-0ec1-43ef-a931-5a00f5f0dc13', 'FAN-AURA', 'AURA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('8fa1ac81-90e8-4d18-9b53-b28cc6b486f3', 'f6ff42ff-0ec1-43ef-a931-5a00f5f0dc13', 'FAN-AURA-235', 'AURA', 39770, 39770, true, true, '{"blade_type": "Transparent Dark Brown Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm / D 42in", "height_of_fan": "530mm / 20in", "light_option": "3000K, 4000K & 6000K  LED 32 Watts", "motor_spec": "172 x 15 / copper winding A/C motor", "airflow": "7950", "colour": "Matte Dare Coffee", "media": {"primaryImage": "/images/products/AURA_235.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('2a1bbe6f-9119-4f2e-aa2b-e9ffe5be8285', 'FAN-PRO', 'PRO', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('3386a5b0-6295-4e80-907b-230c9b15bb8f', '2a1bbe6f-9119-4f2e-aa2b-e9ffe5be8285', 'FAN-PRO-236', 'PRO', 21770, 21770, true, true, '{"blade_type": "Transparent  Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm / D 42in", "height_of_fan": "591mm / 23in", "light_option": "3000K, 4000K & 6000K  LED 52 Watts", "motor_spec": "153 x 12 / copper winding D/C motor", "airflow": "7950 / Summer /Winter option", "colour": "Matte White", "media": {"primaryImage": "/images/products/PRO_236.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('38fef3d0-ca14-422a-97a6-cc926e418f70', 'FAN-REBEL_PLUS', 'REBEL PLUS', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('ae137cc4-0e37-4d59-ad93-b159687fddfa', '38fef3d0-ca14-422a-97a6-cc926e418f70', 'FAN-REBEL_PLUS-237', 'REBEL PLUS', 11770, 11770, true, true, '{"blade_type": "White ABS Assured Durability / 3 Blades", "suitable_for": "True Ceiling", "sweep": "406mm / 16in", "height_of_fan": "178mm / 7in", "motor_spec": "A/C motor", "rpm": "380", "colour": "Matte White", "media": {"primaryImage": "/images/products/REBEL_PLUS_237.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('4a6153c1-2b34-4b50-8279-11a1e91c9724', 'FAN-REBEL_PREMIUM', 'REBEL PREMIUM', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('a7418791-69ff-4845-8355-1dd38692e8f3', '4a6153c1-2b34-4b50-8279-11a1e91c9724', 'FAN-REBEL_PREMIUM-238', 'REBEL PREMIUM', 9770, 9770, true, true, '{"blade_type": "White ABS Assured Durability / 3 Blades", "suitable_for": "False Ceiling", "sweep": "406mm / 16in", "height_of_fan": "591mm / 23in", "light_option": "LED 4000K 5Watts", "motor_spec": "A/C motor", "rpm": "380", "colour": "Matte White", "media": {"primaryImage": "/images/products/REBEL_PREMIUM_238.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('9ea2cdd1-2a53-4562-8022-adc8510c7d6d', 'FAN-GARDENIA', 'GARDENIA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('faf45ff9-d629-4d57-8d4d-1b846c99fc44', '9ea2cdd1-2a53-4562-8022-adc8510c7d6d', 'FAN-GARDENIA-239', 'GARDENIA', 86770, 86770, true, true, '{"blade_type": "Brown ABS / 5 blades", "suitable_for": "Floor / Granite Tabletop Included", "sweep": "1320mm / D 52in", "height_of_fan": "2743mm / 108in", "light_option": "3 Light kit E27 Holder", "motor_spec": "153 x 18  / copper winding A/C motor", "airflow": "7112", "colour": "Brown / Hand Painted Black", "media": {"primaryImage": "/images/products/GARDENIA_239.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('2b589b2d-9bc8-4604-bd3a-720c6b59f19d', 'FAN-EIFFEL', 'EIFFEL', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('2de865ba-c8c2-4929-a4b8-a1d3c060d157', '2b589b2d-9bc8-4604-bd3a-720c6b59f19d', 'FAN-EIFFEL-240', 'EIFFEL', 17770, 17770, true, true, '{"blade_type": ": ABS", "suitable_for": "Stand / Tower / Floor", "height_of_fan": "1270mm / 50in", "motor_spec": "A/C motor", "rpm": "350", "oscillation": "60\u00ba wide-angle", "colour": "Black", "media": {"primaryImage": "/images/products/EIFFEL_240.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('aa245653-db06-4717-b75c-2a1009005087', '2b589b2d-9bc8-4604-bd3a-720c6b59f19d', 'FAN-EIFFEL-241', 'EIFFEL', 18770, 18770, true, true, '{"blade_type": "ABS", "suitable_for": "Stand / Tower / Floor", "height_of_fan": "1270mm / 50in", "motor_spec": "A/C motor", "rpm": "350", "oscillation": "60\u00ba wide-angle", "colour": "White", "media": {"primaryImage": "/images/products/EIFFEL_241.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('8faadf0f-2681-4041-acc9-530e585e065b', '2b589b2d-9bc8-4604-bd3a-720c6b59f19d', 'FAN-EIFFEL-242', 'EIFFEL', 19770, 19770, true, true, '{"blade_type": "ABS", "suitable_for": "Stand / Tower / Floor", "height_of_fan": "1270mm / 50in", "motor_spec": "A/C motor", "rpm": "350", "oscillation": "60\u00ba wide-angle", "colour": "Wood", "media": {"primaryImage": "/images/products/EIFFEL_242.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('945ff3d5-d77e-48b5-9c6e-3c51c1f8213d', 'FAN-STANDIE', 'STANDIE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('467b43a9-e394-4820-a471-7a77d84b3ad3', '945ff3d5-d77e-48b5-9c6e-3c51c1f8213d', 'FAN-STANDIE-243', 'STANDIE', 15770, 15770, true, true, '{"blade_type": "ABS", "suitable_for": "Stand / Tower / Floor", "height_of_fan": "1143mm/45 in", "motor_spec": "A/C motor", "special_feature": "Human Sensor / Touch Control Panel", "rpm": "330", "oscillation": "60\u00ba+90\u00ba+180\u00ba +360\u00ba Horizontal wide-angle", "colour": "Matte White", "media": {"primaryImage": "/images/products/STANDIE_243.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('53b721e9-329d-46df-98c4-2ace2e40ac7d', 'FAN-SPLASH', 'SPLASH', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('30adebe5-edc7-43d4-9f6a-d2098b0a14e0', '53b721e9-329d-46df-98c4-2ace2e40ac7d', 'FAN-SPLASH-244', 'SPLASH', 27770, 27770, true, true, '{"blade_type": "White ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1422mm /D 56in", "height_of_fan": "563mm / 22in", "light_option": "LED 3000, 4000 & 6000k 18watts", "motor_spec": "188 x 18  / copper winding A/C motor", "airflow": "8049", "colour": "Chrome", "media": {"primaryImage": "/images/products/SPLASH_244.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('1a96fc9a-0e5c-40e1-b79f-e44c27a1b79c', 'FAN-TWISTER', 'TWISTER +', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('d57e92da-0a19-46a5-9e9b-1bdff56df3af', '1a96fc9a-0e5c-40e1-b79f-e44c27a1b79c', 'FAN-TWISTER-245', 'TWISTER +', 31770, 31770, true, true, '{"blade_type": "Wood ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1270mm / D 50in", "height_of_fan": "563mm / 22in", "light_option": "LED 3000, 4000 & 6000k 18watts", "motor_spec": "188 x 20  / copper winding A/C motor", "airflow": "7105", "colour": "Wood", "media": {"primaryImage": "/images/products/TWISTER_245.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('88dc19e4-e691-46c3-9d39-c28c7cd29753', '1a96fc9a-0e5c-40e1-b79f-e44c27a1b79c', 'FAN-TWISTER-246', 'TWISTER +', 31770, 31770, true, true, '{"blade_type": "White ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1270mm / D 50in", "height_of_fan": "563mm / 22in", "light_option": "LED 3000, 4000 & 6000k 18watts", "motor_spec": "188 x 20  / copper winding A/C motor", "airflow": "7105", "colour": "White", "media": {"primaryImage": "/images/products/TWISTER_245.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('da0e8a83-d16e-44ca-9bcf-2047fb27612c', '1a96fc9a-0e5c-40e1-b79f-e44c27a1b79c', 'FAN-TWISTER-247', 'TWISTER', 29770, 29770, true, true, '{"blade_type": "White ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1270mm / D 50in", "height_of_fan": "563mm / 22in", "motor_spec": "188 x 20  / copper winding A/C motor", "airflow": "7105", "colour": "White", "media": {"primaryImage": "/images/products/TWISTER_247.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('d2f44f20-2b66-4394-b67c-95e1b0cf2009', '1a96fc9a-0e5c-40e1-b79f-e44c27a1b79c', 'FAN-TWISTER-248', 'TWISTER', 29770, 29770, true, true, '{"blade_type": "Wood ABS / 3 blades", "suitable_for": "Ceiling", "sweep": "1270mm / D 50in", "height_of_fan": "563mm / 22in", "motor_spec": "188 x 20  / copper winding A/C motor", "airflow": "7105", "colour": "Wood", "media": {"primaryImage": "/images/products/TWISTER_245.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('47a06b4c-593e-43f8-a6a1-eef5b171a242', 'FAN-SPIDER', 'SPIDER', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('e1da0530-ff7e-4921-8867-99e9fe6ac103', '47a06b4c-593e-43f8-a6a1-eef5b171a242', 'FAN-SPIDER-249', 'SPIDER', 85770, 85770, true, true, '{"blade_type": "Dual Plated Aluminium / 8 blades", "suitable_for": "Ceiling", "sweep": "1981mm / D 78in", "height_of_fan": "479mm / 19in", "light_option": "LED 3000, 4000 & 6000k 36watts", "motor_spec": "177 x 22  / copper winding D/C motor", "airflow": "18417 / Summer /Winter option", "body_color": "Matte White"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('6a9c66c2-c034-44cd-8500-409cefbf6118', 'FAN-DAFFODIL', 'DAFFODIL', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('6515ef73-ce47-4952-b401-f7ccd451b07e', '6a9c66c2-c034-44cd-8500-409cefbf6118', 'FAN-DAFFODIL-250', 'DAFFODIL', 36770, 36770, true, true, '{"blade_type": "Special Gold Oak wooden blades / 5 blades", "suitable_for": "Ceiling", "sweep": "1066 mm/D 42in", "height_of_fan": "390 mm / 15in", "light_option": "3000K, 4000K & 6000K  LED 33 Watts", "motor_spec": "153 x 15  / copper winding A/C motor", "airflow": "6710 / Summer /Winter option", "body_color": "Antique Brass", "media": {"primaryImage": "/images/products/DAFFODIL_250.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('1e8ef7bf-f3a4-407e-b117-e3038ee332ed', '6a9c66c2-c034-44cd-8500-409cefbf6118', 'FAN-DAFFODIL-251', 'DAFFODIL +', 35770, 35770, true, true, '{"blade_type": "Special Beige wooden blades / 5 blades", "suitable_for": "Ceiling", "sweep": "1066 mm/D 42in", "height_of_fan": "560 mm / 22in", "light_option": "3000K, 4000K & 6000K  LED 33 Watts", "motor_spec": "153 x 15  / copper winding A/C motor", "airflow": "6710 / Summer /Winter option", "body_color": "Chrome", "media": {"primaryImage": "/images/products/DAFFODIL_251.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('0dd39f25-d51d-4e85-be08-195490e689e0', 'FAN-ELITE', 'ELITE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('220aab51-7d59-4d8c-808c-c034fe014263', '0dd39f25-d51d-4e85-be08-195490e689e0', 'FAN-ELITE-252', 'ELITE', 28770, 28770, true, true, '{"blade_type": "Real Wood / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1320mm /D 52in", "height_of_fan": "220/8.6 in", "motor_spec": "153x18  / copper winding D/C motor", "airflow": "6950 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/ELITE_252.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('47945f38-3636-47d7-afe5-342813547faf', 'FAN-ISLA', 'ISLA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('6393641b-7841-4a98-b9bb-4a7493209452', '47945f38-3636-47d7-afe5-342813547faf', 'FAN-ISLA-253', 'ISLA', 68770, 68770, true, true, '{"blade_type": "Hand Crafted Real Wood / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm /D 52in", "height_of_fan": "720mm / 28 in", "light_option": "5 Light Kit E27 Holder", "motor_spec": "188 x 15  / copper winding A/C motor", "airflow": "7060 / Summer /Winter option", "colour": "Hand Painted & Multi Coloured Stained Glass", "media": {"primaryImage": "/images/products/ISLA_253.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('82bfd57a-83b4-4d3d-b4ce-8263f76ae410', 'FAN-PROPELLER', 'PROPELLER', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('fcf66489-1783-4bdf-bccc-3a135d92c36a', '82bfd57a-83b4-4d3d-b4ce-8263f76ae410', 'FAN-PROPELLER-254', 'PROPELLER', 29770, 29770, true, true, '{"blade_type": "Real Wood / 2 blades", "suitable_for": "Ceiling", "sweep": "1320mm /D 52in", "height_of_fan": "480mm / 19 in", "motor_spec": "153*18  / copper winding D/C motor", "airflow": "7950 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/PROPELLER_254.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('29776f20-30f5-4323-ac7b-816445314363', 'FAN-JASPER', 'JASPER', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('bd43ba28-273a-454b-a5e8-1262b4795188', '29776f20-30f5-4323-ac7b-816445314363', 'FAN-JASPER-255', 'JASPER', 30770, 30770, true, true, '{"blade_type": "Transparent  Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm / D 42in", "height_of_fan": "680mm / 27in", "light_option": "3000K, 4000K & 6000K  LED 32 Watts", "motor_spec": "153 x 15 / copper winding A/C motor", "airflow": "7950", "colour": "French Gold + Matte Black", "media": {"primaryImage": "/images/products/JASPER_255.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('cc330d04-0b4f-4e0d-9907-da8af3d13851', 'FAN-AMBER', 'AMBER', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('74b644af-a36e-41e9-bf21-a2d2a97cd99b', 'cc330d04-0b4f-4e0d-9907-da8af3d13851', 'FAN-AMBER-256', 'AMBER', 26770, 26770, true, true, '{"blade_type": "Matte Black Blade ABS / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm /D 52in", "height_of_fan": "540mm / 21in", "motor_spec": "180 x 20  / copper winding A/C motor", "airflow": "9250 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/AMBER_256.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('65c79ac5-2ac4-43f1-a7c9-0fd4e1baacd8', 'cc330d04-0b4f-4e0d-9907-da8af3d13851', 'FAN-AMBER-257', 'AMBER', 26770, 26770, true, true, '{"blade_type": "Matte White ABS Blade / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm /D 52in", "height_of_fan": "540mm / 21in", "motor_spec": "180 x 20  / copper winding A/C motor", "airflow": "9250 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/AMBER_257.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('8d139889-6e7f-4894-9180-aebb5019c326', 'FAN-DESIRE', 'DESIRE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('9909cd9f-e97a-45ca-8ada-793d7689adab', '8d139889-6e7f-4894-9180-aebb5019c326', 'FAN-DESIRE-258', 'DESIRE', 29770, 29770, true, true, '{"blade_type": "Matte White ABS Blade / 5 blades", "suitable_for": "Ceiling", "sweep": "1320mm /D 52in", "height_of_fan": "570mm / 22in", "light_option": "LED 3000, 4000 & 6000K 24Watts", "motor_spec": "180 x 20  / copper winding A/C motor", "airflow": "8850 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/DESIRE_258.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('ae53ddca-0ed9-4f81-a945-320ce0be2d16', 'FAN-SLEEKAIR_42', 'SLEEKAIR 42"', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('0d50511b-4c98-4ed3-b19d-a7d5f7bb940b', 'ae53ddca-0ed9-4f81-a945-320ce0be2d16', 'FAN-SLEEKAIR_42-259', 'SLEEKAIR 42"', 24770, 24770, true, true, '{"blade_type": "Matte White ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1067mm / D 42in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/SLEEKAIR_42_259.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('3d084ace-d9aa-4efc-91da-ed12f5014543', 'ae53ddca-0ed9-4f81-a945-320ce0be2d16', 'FAN-SLEEKAIR_42-260', 'SLEEKAIR 42"', 26770, 26770, true, true, '{"blade_type": "Matte White ABS blades/  4 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1067mm / D 42in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/SLEEKAIR_42_260.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('1d943ec5-8a8b-41c3-922f-dd53bbdc3ef4', 'ae53ddca-0ed9-4f81-a945-320ce0be2d16', 'FAN-SLEEKAIR_42-261', 'SLEEKAIR 42"', 28770, 28770, true, true, '{"blade_type": "Matte White ABS blades/ 4 blades", "suitable_for": "Low ceiling / Hugger", "light_option": "LED 3000, 4000 & 6000K 18 watts", "sweep": "1067mm / D 42in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/SLEEKAIR_42_261.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('df6ce5a4-ee0d-4d56-8e00-6e28c0acb82b', 'ae53ddca-0ed9-4f81-a945-320ce0be2d16', 'FAN-SLEEKAIR_42-262', 'SLEEKAIR 42"', 26770, 26770, true, true, '{"blade_type": "Matte White ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "light_option": "LED 3000, 4000 & 6000K 18 watts", "sweep": "1067mm / D 42in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/SLEEKAIR_42_262.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('9346aad6-3ec1-4f5e-964e-929bdd83191b', 'ae53ddca-0ed9-4f81-a945-320ce0be2d16', 'FAN-SLEEKAIR_42-263', 'SLEEKAIR 42"', 24770, 24770, true, true, '{"blade_type": "Matte Black ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1067mm / D 42in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/SLEEKAIR_42_263.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('298248c9-99b6-4380-93d3-4cc6d3b3b27a', 'ae53ddca-0ed9-4f81-a945-320ce0be2d16', 'FAN-SLEEKAIR_42-264', 'SLEEKAIR 42"', 26770, 26770, true, true, '{"blade_type": "Matte Black ABS blades/ 4 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1067mm / D 42in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/SLEEKAIR_42_264.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('0f56a81a-7c9e-44cc-9316-72f6af2faee7', 'ae53ddca-0ed9-4f81-a945-320ce0be2d16', 'FAN-SLEEKAIR_42-265', 'SLEEKAIR 42"', 26770, 26770, true, true, '{"blade_type": "Matte Black ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "light_option": "LED 3000, 4000 & 6000K 18 watts", "sweep": "1067mm / D 42in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/SLEEKAIR_42_265.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b0f3781e-f4a5-4574-8687-dce50475a6c5', 'ae53ddca-0ed9-4f81-a945-320ce0be2d16', 'FAN-SLEEKAIR_42-266', 'SLEEKAIR 42"', 28770, 28770, true, true, '{"blade_type": "Matte Black ABS blades/ 4 blades", "suitable_for": "Low ceiling / Hugger", "light_option": "LED 3000, 4000 & 6000K 18 watts", "sweep": "1067mm / D 42in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/SLEEKAIR_42_266.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('020430e7-d575-47bb-8d42-a55bbd2eb841', 'FAN-SLEEKAIR_48', 'SLEEKAIR 48"', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('19b8d804-7eea-41ff-8213-7a9bcb575ab3', '020430e7-d575-47bb-8d42-a55bbd2eb841', 'FAN-SLEEKAIR_48-267', 'SLEEKAIR 48"', 24770, 24770, true, true, '{"blade_type": "Matte White ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/SLEEKAIR_48_267.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('00f77625-1d4b-4876-aff5-f0277ac466d8', '020430e7-d575-47bb-8d42-a55bbd2eb841', 'FAN-SLEEKAIR_48-268', 'SLEEKAIR 48"', 26770, 26770, true, true, '{"blade_type": "Matte White ABS blades/  4 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/SLEEKAIR_48_268.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('449f0431-a8bb-428a-894d-6587f7e85628', '020430e7-d575-47bb-8d42-a55bbd2eb841', 'FAN-SLEEKAIR_48-269', 'SLEEKAIR 48"', 28770, 28770, true, true, '{"blade_type": "Matte White ABS blades/ 4 blades", "suitable_for": "Low ceiling / Hugger", "light_option": "LED 3000, 4000 & 6000K 18 watts", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/SLEEKAIR_48_269.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('9ea2109b-1c22-4405-bc4d-b90500bed4ea', '020430e7-d575-47bb-8d42-a55bbd2eb841', 'FAN-SLEEKAIR_48-270', 'SLEEKAIR 48"', 26770, 26770, true, true, '{"blade_type": "Matte White ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "light_option": "LED 3000, 4000 & 6000K 18 watts", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/SLEEKAIR_48_270.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('ae4eb049-41b9-481e-8ae2-7233785fa947', '020430e7-d575-47bb-8d42-a55bbd2eb841', 'FAN-SLEEKAIR_48-271', 'SLEEKAIR 48"', 24770, 24770, true, true, '{"blade_type": "Matte Black ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/SLEEKAIR_48_271.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b12b089d-b60f-41c4-a1a3-8fc3a0c7efa8', '020430e7-d575-47bb-8d42-a55bbd2eb841', 'FAN-SLEEKAIR_48-272', 'SLEEKAIR 48"', 26770, 26770, true, true, '{"blade_type": "Matte Black ABS blades/ 4 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/SLEEKAIR_48_272.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('22eeac16-efd4-4bf1-9bb3-643b75e5ac37', '020430e7-d575-47bb-8d42-a55bbd2eb841', 'FAN-SLEEKAIR_48-273', 'SLEEKAIR 48"', 26770, 26770, true, true, '{"blade_type": "Matte Black ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "light_option": "LED 3000, 4000 & 6000K 18 watts", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/SLEEKAIR_48_273.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('2baed349-d551-448c-bf85-e928491f2bb1', '020430e7-d575-47bb-8d42-a55bbd2eb841', 'FAN-SLEEKAIR_48-274', 'SLEEKAIR 48"', 28770, 28770, true, true, '{"blade_type": "Matte Black ABS blades/ 4 blades", "suitable_for": "Low ceiling / Hugger", "light_option": "LED 3000, 4000 & 6000K 18 watts", "sweep": "1219mm / D 48in", "height_of_fan": "180mm / 7 in", "motor_spec": "153 x 15  / copper winding D/C motor", "airflow": "7450 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/SLEEKAIR_48_274.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('a00e2c2d-a8b3-4a22-b84c-ae826bc6df56', 'FAN-MILLENIUM', 'MILLENIUM', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('a4a78fcc-1468-468a-bf09-0e623e70fcd3', 'a00e2c2d-a8b3-4a22-b84c-ae826bc6df56', 'FAN-MILLENIUM-275', 'MILLENIUM', 23770, 23770, true, true, '{"blade_type": "Matte White ABS blades / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1270mm /D 50 in", "height_of_fan": "200mm / 8 in", "motor_spec": "153 x 16 copper winding A/C motor", "airflow": "6550 * Summer /Winter option", "colour": "Matte White", "media": {"primaryImage": "/images/products/MILLENIUM_275.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('2fb6eef3-bf6c-49e7-9cca-0ada4f353715', 'a00e2c2d-a8b3-4a22-b84c-ae826bc6df56', 'FAN-MILLENIUM-276', 'MILLENIUM', 23770, 23770, true, true, '{"blade_type": "Matte Black ABS blades / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1270mm /D 50 in", "height_of_fan": "200mm / 8 in", "motor_spec": "153 x 16 copper winding A/C motor", "airflow": "6550 * Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/MILLENIUM_276.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('c41ef8ce-58eb-4512-96a4-5975dfd77209', 'FAN-COSMO', 'COSMO', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b4295b9d-1169-47a8-961b-ee4afbca9f5e', 'c41ef8ce-58eb-4512-96a4-5975dfd77209', 'FAN-COSMO-277', 'COSMO', 24770, 24770, true, true, '{"blade_type": "Real Wood / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1320mm / 52 in", "height_of_fan": "240mm / 9  in", "motor_spec": "153 x 18 copper winding A/C motor", "airflow": "8250", "colour": "Matte Gold", "media": {"primaryImage": "/images/products/COSMO_277.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('13950360-b97c-4725-82cd-0d10b3e0d9b4', 'FAN-MAESTRO', 'MAESTRO', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('176e6893-df50-4839-80fc-705e20c03069', '13950360-b97c-4725-82cd-0d10b3e0d9b4', 'FAN-MAESTRO-278', 'MAESTRO', 25770, 25770, true, true, '{"blade_type": "Matte White ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1193mm / D 47in", "height_of_fan": "280mm /  11in", "light_option": "LED 3000, 4000 & 6000K 18Watts", "motor_spec": "145 x 15 / copper winding D/C motor", "airflow": "6550 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/MAESTRO_278.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('1171c062-af98-4d12-9025-e80d2d32b335', '13950360-b97c-4725-82cd-0d10b3e0d9b4', 'FAN-MAESTRO-279', 'MAESTRO', 27770, 27770, true, true, '{"blade_type": "Ash Wood ABS blades/ 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1193mm / D 47in", "height_of_fan": "280mm /  11in", "light_option": "LED 3000, 4000 & 6000K 18Watts", "motor_spec": "145 x 15 / copper winding D/C motor", "airflow": "6550 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/MAESTRO_279.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('244c1075-6ee6-4691-8ac4-291475267ed7', '13950360-b97c-4725-82cd-0d10b3e0d9b4', 'FAN-MAESTRO-280', 'MAESTRO', 25770, 25770, true, true, '{"blade_type": "Matte Black ABS / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1175mm / D 47in", "height_of_fan": "280mm /  11in", "light_option": "LED 3000, 4000 & 6000K 18Watts", "motor_spec": "145 x 15 / copper winding D/C motor", "airflow": "6550 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/MAESTRO_280.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('a760cf10-1b8c-4e3f-b04d-fec6bb9f7fd9', '13950360-b97c-4725-82cd-0d10b3e0d9b4', 'FAN-MAESTRO-281', 'MAESTRO', 27770, 27770, true, true, '{"blade_type": "Matte Sand Gold ABS / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "1175mm / D 47in", "height_of_fan": "280mm /  11in", "light_option": "LED 3000, 4000 & 6000K 18Watts", "motor_spec": "145 x 15 / copper winding D/C motor", "airflow": "6550 / Summer /Winter option", "colour": "Matte Sand Gold", "media": {"primaryImage": "/images/products/MAESTRO_281.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('be9a6d01-dd4a-4fa7-83ff-07e2965ca712', 'FAN-NOVA_BIG', 'NOVA BIG', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('0cc60bb3-3383-419a-a543-95ef884c98ec', 'be9a6d01-dd4a-4fa7-83ff-07e2965ca712', 'FAN-NOVA_BIG-282', 'NOVA BIG', 24770, 24770, true, true, '{"blade_type": "No Blade / ABS", "suitable_for": "Ceiling", "height_of_fan": "1090 x 690 x 170mm", "light_option": "LED 3000k - 6000k 180 x 2 watts (Dimming)", "motor_spec": "D/C motor", "oscillation": "60\u00ba wide-angle", "body_color": "Matte White", "media": {"primaryImage": "/images/products/NOVA_BIG_282.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('f7ae25c8-d920-4108-be72-126e94e3e2f3', 'FAN-NOVA_MINI', 'NOVA MINI', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('734d26e6-ce45-41c8-ac03-e0dc87b1115b', 'f7ae25c8-d920-4108-be72-126e94e3e2f3', 'FAN-NOVA_MINI-283', 'NOVA MINI', 14770, 14770, true, true, '{"blade_type": "No Blade / ABS", "suitable_for": "Ceiling", "height_of_fan": "490 x 490 x 150mm", "light_option": "LED 3000k - 6000k 58 x 2 watts (Dimming)", "motor_spec": "D/C motor", "oscillation": "60\u00ba wide-angle", "body_color": "Matte White", "media": {"primaryImage": "/images/products/NOVA_MINI_283.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('7bdbdd2a-43f3-44e6-ba56-f5b88c36b4de', 'FAN-AEROWAVE', 'AEROWAVE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('61c828b2-f515-4478-8a65-10ade7210469', '7bdbdd2a-43f3-44e6-ba56-f5b88c36b4de', 'FAN-AEROWAVE-284', 'AEROWAVE', 34770, 34770, true, true, '{"blade_type": "No Blade / ABS", "suitable_for": "Ceiling", "sweep": "610mm / D 24in", "height_of_fan": "100mm / 4in", "light_option": "LED 3000K - 6000k 45watts (Dimming)", "motor_spec": "153 x 15 copper winding D/C motor", "airflow": "6950", "colour": "Matte White", "media": {"primaryImage": "/images/products/AEROWAVE_284.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('f7392c5f-0284-449e-a618-bc0f768e3930', 'FAN-ENIGMA', 'ENIGMA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('6bd66032-6dfe-4ed7-ada1-13d08b9b4eec', 'f7392c5f-0284-449e-a618-bc0f768e3930', 'FAN-ENIGMA-285', 'ENIGMA', 22770, 22770, true, true, '{"blade_type": "Matte Dark Brown ABS / 5 blades", "suitable_for": "Ceiling", "sweep": "762mm / D 30in", "height_of_fan": "510mm / 20in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 12 / copper winding D/C motor", "airflow": "7550 / Summer /Winter option", "colour": "Walnut", "media": {"primaryImage": "/images/products/ENIGMA_285.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('ce0c1be7-5725-43f5-a77a-3bf9ad3cb7de', 'f7392c5f-0284-449e-a618-bc0f768e3930', 'FAN-ENIGMA-286', 'ENIGMA', 20770, 20770, true, true, '{"blade_type": "Matte White ABS / 5 blades", "suitable_for": "Ceiling", "sweep": "762mm / D 30in", "height_of_fan": "510mm / 20in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 12 / copper winding D/C motor", "airflow": "7550 / Summer /Winter option", "colour": "White", "media": {"primaryImage": "/images/products/ENIGMA_286.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('eb9de074-2da7-4d04-91df-a341c465bf69', 'f7392c5f-0284-449e-a618-bc0f768e3930', 'FAN-ENIGMA-287', 'ENIGMA', 20770, 20770, true, true, '{"blade_type": "Matte Black ABS / 5 blades", "suitable_for": "Ceiling", "sweep": "762mm / D 30in", "height_of_fan": "510mm / 20in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 12 / copper winding D/C motor", "airflow": "7550 / Summer /Winter option", "colour": "Black", "media": {"primaryImage": "/images/products/ENIGMA_287.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('dd94737d-fe2e-4d5f-9787-21dea7611d25', 'FAN-SPECTRA', 'SPECTRA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('99dedea4-d33a-467d-a611-1d1a999fe517', 'dd94737d-fe2e-4d5f-9787-21dea7611d25', 'FAN-SPECTRA-288', 'SPECTRA', 23770, 23770, true, true, '{"blade_type": "Matte White ABS blades / 5 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "470mm / 18in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 15 / copper winding D/C motor", "airflow": "9650 / Summer /Winter option", "body_color": "White", "media": {"primaryImage": "/images/products/SPECTRA_288.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('bfc2b0a3-02d7-4067-ae53-754d6b5efce4', 'dd94737d-fe2e-4d5f-9787-21dea7611d25', 'FAN-SPECTRA-289', 'SPECTRA', 23770, 23770, true, true, '{"blade_type": "Matte Black ABS  blades / 5 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "470mm / 18in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 15 / copper winding D/C motor", "airflow": "9650 / Summer /Winter option", "body_color": "Black", "media": {"primaryImage": "/images/products/SPECTRA_289.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('a22d8fdb-6dd7-41b5-aa51-6a2be5943c79', 'dd94737d-fe2e-4d5f-9787-21dea7611d25', 'FAN-SPECTRA-290', 'SPECTRA', 25770, 25770, true, true, '{"blade_type": "Light Walnut Wooden  ABS blades / 5 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "470mm / 18in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 15 / copper winding D/C motor", "airflow": "9650 / Summer /Winter option", "body_color": "Black", "media": {"primaryImage": "/images/products/SPECTRA_290.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('43b3f11d-8d9d-4250-94e3-7792d5f91551', 'dd94737d-fe2e-4d5f-9787-21dea7611d25', 'FAN-SPECTRA-291', 'SPECTRA', 25770, 25770, true, true, '{"blade_type": "Oakgold Wooden ABS blades / 5 blades", "suitable_for": "Ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "470mm / 18in", "light_option": "LED 3000, 4000 & 6000k 24Watts", "motor_spec": "153 x 15 / copper winding D/C motor", "airflow": "9650 / Summer /Winter option", "body_color": "Black", "media": {"primaryImage": "/images/products/SPECTRA_291.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('4fd21291-b48b-4647-bda0-b3c1848b18ba', 'FAN-FINCH', 'FINCH', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('31ea62fb-594c-4d6b-95fb-db2b8faa6d99', '4fd21291-b48b-4647-bda0-b3c1848b18ba', 'FAN-FINCH-292', 'FINCH', 28770, 28770, true, true, '{"blade_type": "Matte White ABS blades / 3 blades", "suitable_for": "Ceiling", "sweep": "914mm / D 36in", "height_of_fan": "490mm / 19in", "light_option": "LED 3000, 4000 & 6000k 35Watts", "motor_spec": "153 x 12 / copper winding D/C motor", "airflow": "7250 / Summer /Winter option", "body_color": "White", "media": {"primaryImage": "/images/products/FINCH_292.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('0d72aa3f-c134-409b-8952-20aa1bdb9a06', 'FAN-REVA', 'REVA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('53e402eb-aab4-4eff-89d0-23685537e2ef', '0d72aa3f-c134-409b-8952-20aa1bdb9a06', 'FAN-REVA-293', 'REVA', 28770, 28770, true, true, '{"blade_type": "Special Wooden + Stainless steel Coffee / 3 blades", "suitable_for": "Ceiling", "sweep": "1320mm / D 52in", "height_of_fan": "450mm / 18in", "motor_spec": "172 x 20 / copper winding A/C motor", "airflow": "7740 / Summer /Winter option", "colour": "Matte Coffee", "media": {"primaryImage": "/images/products/REVA_293.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('1ea2a82a-ae1c-4d00-8e4b-c4fa9cc8bb9a', 'FAN-DIANNA', 'DIANNA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('716c334e-fb85-4741-9313-ebe73a2cddf5', '1ea2a82a-ae1c-4d00-8e4b-c4fa9cc8bb9a', 'FAN-DIANNA-294', 'DIANNA', 26770, 26770, true, true, '{"blade_type": "Transparent  Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm / D 42in", "height_of_fan": "530mm / 21in", "light_option": "3000K, 4000K & 6000K  LED 36 Watts", "motor_spec": "172 x 15 / copper winding A/C motor", "airflow": "7950", "colour": "French Gold + Matte Black", "media": {"primaryImage": "/images/products/DIANNA_294.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('af9fbf36-f3b5-4a8b-806d-9e8a6b32604a', 'FAN-JASMIN', 'JASMIN', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('65f6caeb-6199-47b7-aae0-928d996d5c89', 'af9fbf36-f3b5-4a8b-806d-9e8a6b32604a', 'FAN-JASMIN-295', 'JASMIN', 26770, 26770, true, true, '{"blade_type": "Transparent  Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm / D 42in", "height_of_fan": "530mm / 21in", "light_option": "3000K, 4000K & 6000K  LED 36 Watts", "motor_spec": "172 x 15 / copper winding A/C motor", "airflow": "7950", "colour": "French Gold + Matte White", "media": {"primaryImage": "/images/products/JASMIN_295.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('ce153b24-9255-462d-ac40-c8143a51e932', 'FAN-LUKER', 'LUKER', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('c210a4d5-ee75-459a-905b-886b64a95582', 'ce153b24-9255-462d-ac40-c8143a51e932', 'FAN-LUKER-296', 'LUKER', 30770, 30770, true, true, '{"blade_type": "Walnut ABS blades / 3 blades", "suitable_for": "ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "410mm / 16in", "motor_spec": "153 x 16  / copper winding D/C motor", "airflow": "10550 / Summer /Winter option", "body_color": "Black", "media": {"primaryImage": "/images/products/LUKER_296.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('aef8ab73-3733-45d6-b01f-9efe1a01689d', 'ce153b24-9255-462d-ac40-c8143a51e932', 'FAN-LUKER-297', 'LUKER', 27770, 27770, true, true, '{"blade_type": "Black ABS blades / 3 blades", "suitable_for": "ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "410mm / 16in", "motor_spec": "153 x 16  / copper winding D/C motor", "airflow": "10550 / Summer /Winter option", "body_color": "Black", "media": {"primaryImage": "/images/products/LUKER_297.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('225301d9-7558-4aec-9efb-298ebcc5fcc4', 'ce153b24-9255-462d-ac40-c8143a51e932', 'FAN-LUKER-298', 'LUKER', 27770, 27770, true, true, '{"blade_type": "White ABS  Blades / 3 blades", "suitable_for": "ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "410mm / 16in", "motor_spec": "153 x 16  / copper winding D/C motor", "airflow": "10550 / Summer /Winter option", "body_color": "White", "media": {"primaryImage": "/images/products/LUKER_298.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('d0a0013a-b7dc-4011-9cfb-ae54e04277db', 'ce153b24-9255-462d-ac40-c8143a51e932', 'FAN-LUKER-299', 'LUKER', 30770, 30770, true, true, '{"blade_type": "Pine Wood ABS Blades / 3 blades", "suitable_for": "ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "410mm / 16in", "motor_spec": "153 x 16  / copper winding D/C motor", "airflow": "10550 / Summer /Winter option", "body_color": "Black", "media": {"primaryImage": "/images/products/LUKER_299.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('0d29e069-c4ea-4aad-81dc-7f9b6e95a46e', 'FAN-HARRIER', 'HARRIER', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('90272dd4-3cbf-43f8-bb36-8644890339c1', '0d29e069-c4ea-4aad-81dc-7f9b6e95a46e', 'FAN-HARRIER-300', 'HARRIER', 23770, 23770, true, true, '{"blade_type": "Matte Black ABS / 3 blades", "suitable_for": "ceiling", "sweep": "1270mm /D 50in", "height_of_fan": "400 mm/16in", "motor_spec": "153 x 12  / copper winding D/C motor", "airflow": "8950 / Summer /Winter option", "body_color": "Black", "media": {"primaryImage": "/images/products/HARRIER_300.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('cbfcc50d-4cf0-468b-a798-13caa8e3eabf', '0d29e069-c4ea-4aad-81dc-7f9b6e95a46e', 'FAN-HARRIER-301', 'HARRIER', 23770, 23770, true, true, '{"blade_type": "Matte White ABS / 3 blades", "suitable_for": "ceiling", "sweep": "1270mm /D 50in", "height_of_fan": "400 mm/16in", "motor_spec": "153 x 12  / copper winding D/C motor", "airflow": "8950 / Summer /Winter option", "body_color": "White", "media": {"primaryImage": "/images/products/HARRIER_301.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('1553a50a-c81e-431c-93f2-d96a95531ade', '0d29e069-c4ea-4aad-81dc-7f9b6e95a46e', 'FAN-HARRIER-302', 'HARRIER', 25770, 25770, true, true, '{"blade_type": "Dark wooden ABS blades / 3 blades", "suitable_for": "ceiling", "sweep": "1270mm /D 50in", "height_of_fan": "400 mm/16in", "motor_spec": "153 x 12  / copper winding D/C motor", "airflow": "8950 / Summer /Winter option", "body_color": "Wooden", "media": {"primaryImage": "/images/products/HARRIER_302.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('daa7170b-3e88-4099-ba61-03a8a5c7003e', '0d29e069-c4ea-4aad-81dc-7f9b6e95a46e', 'FAN-HARRIER-303', 'HARRIER', 25770, 25770, true, true, '{"blade_type": "Dark wooden ABS blades / 3 blades", "suitable_for": "ceiling", "sweep": "1270mm /D 50in", "height_of_fan": "400 mm/16in", "motor_spec": "153 x 12  / copper winding D/C motor", "airflow": "8950 / Summer /Winter option", "body_color": "Black", "media": {"primaryImage": "/images/products/HARRIER_303.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('e13e9fa4-0f48-4010-afc5-42362cf4a757', 'FAN-FALCON', 'FALCON', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('12ad7ec5-93cc-4153-928a-9cc2ab3e314e', 'e13e9fa4-0f48-4010-afc5-42362cf4a757', 'FAN-FALCON-304', 'FALCON', 25770, 25770, true, true, '{"blade_type": "Matte Black ABS blades / 3 blades", "suitable_for": "ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "440mm / 17in", "light_option": "LED 3000, 4000 & 6000K 18Watts", "motor_spec": "153 x 12  / copper winding D/C motor", "airflow": "9350 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/FALCON_304.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('88a991b1-44fd-43fe-a3b5-01d4b4c15d15', 'e13e9fa4-0f48-4010-afc5-42362cf4a757', 'FAN-FALCON-305', 'FALCON', 25770, 25770, true, true, '{"blade_type": "Matte White ABS / 3 blades", "suitable_for": "ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "440mm / 17in", "light_option": "LED 3000, 4000 & 6000K 18Watts", "motor_spec": "153 x 12  / copper winding D/C motor", "airflow": "9350 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/FALCON_305.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('542d85de-7125-42f9-be62-0494288eb327', 'e13e9fa4-0f48-4010-afc5-42362cf4a757', 'FAN-FALCON-306', 'FALCON', 27770, 27770, true, true, '{"blade_type": "Light Walnut Wood ABS blades/ 3 blades", "suitable_for": "ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "440mm / 17in", "light_option": "LED 3000, 4000 & 6000K 18Watts", "motor_spec": "153 x 12  / copper winding D/C motor", "airflow": "9350 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/FALCON_306.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('74e81746-ad4c-488b-96b1-f090c95eb0f5', 'e13e9fa4-0f48-4010-afc5-42362cf4a757', 'FAN-FALCON-307', 'FALCON', 27770, 27770, true, true, '{"blade_type": "Oakgold Wooden ABS blade / 3 blades", "suitable_for": "ceiling", "sweep": "1422mm / D 56in", "height_of_fan": "440mm / 17in", "light_option": "LED 3000, 4000 & 6000K 18Watts", "motor_spec": "153 x 12  / copper winding D/C motor", "airflow": "9350 / Summer /Winter option", "body_color": "Matte Black", "media": {"primaryImage": "/images/products/FALCON_307.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('e6a0889e-0ca5-46d9-969b-5ffb8a017e2d', 'FAN-ROSY', 'ROSY', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('48a7a212-76c5-47df-9442-8a4aa0e7aa54', 'e6a0889e-0ca5-46d9-969b-5ffb8a017e2d', 'FAN-ROSY-308', 'ROSY', 31770, 31770, true, true, '{"blade_type": "Matte Rose Gold ABS / 3 blades", "suitable_for": "ceiling", "sweep": "609mm / D 24in", "height_of_fan": "500mm / 20in", "light_option": "LED 3000, 4000 & 6000K 100Watts", "motor_spec": "100x15  / copper winding D/C motor", "airflow": "8250 / Summer /Winter option", "colour": "Rose Gold", "media": {"primaryImage": "/images/products/ROSY_308.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('725ccd30-3a5b-469a-b23c-29c15f49b7ec', 'e6a0889e-0ca5-46d9-969b-5ffb8a017e2d', 'FAN-ROSY-309', 'ROSY', 30770, 30770, true, true, '{"blade_type": "Matte Gold ABS / 3 blades", "suitable_for": "ceiling", "sweep": "609mm / D 24in", "height_of_fan": "500mm / 20in", "light_option": "LED 3000, 4000 & 6000K 100Watts", "motor_spec": "100x15  / copper winding D/C motor", "airflow": "8250 / Summer /Winter option", "colour": "French Gold", "media": {"primaryImage": "/images/products/ROSY_309.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('de246ca0-9e6c-40ba-b8a7-c88023fb7d3c', 'FAN-NISSAR', 'NISSAR', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('7b595a9c-b6a1-45d0-a5df-76ae6530f6cf', 'de246ca0-9e6c-40ba-b8a7-c88023fb7d3c', 'FAN-NISSAR-310', 'NISSAR', 53770, 53770, true, true, '{"blade_type": "Special Ash wooden Blades / 6 blades", "suitable_for": "ceiling", "sweep": "1828mm/ D32x2 in", "height_of_fan": "560mm / 22in", "light_option": "LED 3000, 4000 & 6000K 22Watts Dimmable", "motor_spec": "2 x 153x12  / copper winding A/C motor", "airflow": "8250", "colour": "Matte Black", "media": {"primaryImage": "/images/products/NISSAR_310.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('9c165f42-ac21-4c5d-9f40-a89c1e8598af', 'FAN-FLORENCE', 'FLORENCE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('c406c613-1e70-447d-9c19-3e2a407d7466', '9c165f42-ac21-4c5d-9f40-a89c1e8598af', 'FAN-FLORENCE-311', 'FLORENCE', 26770, 26770, true, true, '{"blade_type": "Matte Gold ABS / 3 blades", "suitable_for": "ceiling", "sweep": "609mm / D 24in", "height_of_fan": "500mm / 20in", "light_option": "LED 3000, 4000 & 6000K 100Watts", "motor_spec": "100x15  / copper winding D/C motor", "airflow": "8250 / Summer /Winter option", "colour": "French Gold", "media": {"primaryImage": "/images/products/FLORENCE_311.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b145261b-f218-41fd-b833-1a7dadbf71f5', '9c165f42-ac21-4c5d-9f40-a89c1e8598af', 'FAN-FLORENCE-312', 'FLORENCE', 27770, 27770, true, true, '{"blade_type": "Matte Rose ABS / 3 blades", "suitable_for": "ceiling", "sweep": "609mm / D 24in", "height_of_fan": "500mm / 20in", "light_option": "LED 3000, 4000 & 6000K 100Watts", "motor_spec": "100x15  / copper winding D/C motor", "airflow": "8250 / Summer /Winter option", "colour": "Rose Gold", "media": {"primaryImage": "/images/products/FLORENCE_312.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('46b5e923-4b22-4aaf-8f66-5c92c5f11055', 'FAN-SAFFRON', 'SAFFRON', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('56a5feba-0bbd-4b1c-973d-dc211c5afe56', '46b5e923-4b22-4aaf-8f66-5c92c5f11055', 'FAN-SAFFRON-313', 'SAFFRON', 31770, 31770, true, true, '{"blade_type": "Matte French Gold ABS / 3 blades", "suitable_for": "ceiling", "sweep": "610mm / D 24in", "height_of_fan": "500mm / 20in", "light_option": "LED 3000, 4000 & 6000K 120Watts", "motor_spec": "100x15  / copper winding D/C motor", "airflow": "8250 / Summer /Winter option", "colour": "French Gold", "media": {"primaryImage": "/images/products/SAFFRON_313.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('1222f639-7dc8-40dd-82e9-e715ca1051d7', '46b5e923-4b22-4aaf-8f66-5c92c5f11055', 'FAN-SAFFRON-314', 'SAFFRON', 32770, 32770, true, true, '{"blade_type": "Matte Rose Gold ABS / 3 blades", "suitable_for": "ceiling", "sweep": "610mm / D 24in", "height_of_fan": "500mm / 20in", "light_option": "LED 3000, 4000 & 6000K 120Watts", "motor_spec": "100x15  / copper winding D/C motor", "airflow": "8250 / Summer /Winter option", "colour": "Rose Gold", "media": {"primaryImage": "/images/products/SAFFRON_314.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('a2c2263a-bb55-48c5-a1b6-a97594286187', 'FAN-ZEPHYRE', 'ZEPHYRE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('04a626e7-ecd3-412b-870d-b19d630884b4', 'a2c2263a-bb55-48c5-a1b6-a97594286187', 'FAN-ZEPHYRE-315', 'ZEPHYRE', 23770, 23770, true, true, '{"blade_type": "Matte White ABS / 7 blades", "suitable_for": "ceiling", "sweep": "304mm / D 12in", "height_of_fan": "490mm / 19in", "light_option": "LED 3000, 4000 & 6000K 36Watts (Dimming)", "motor_spec": "153x12  / copper winding D/C motor", "airflow": "6450 / Summer /Winter option", "colour": "White", "media": {"primaryImage": "/images/products/ZEPHYRE_315.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('bcaefab6-0c6e-4df2-bd5a-f0e26cd70585', 'a2c2263a-bb55-48c5-a1b6-a97594286187', 'FAN-ZEPHYRE-316', 'ZEPHYRE', 25770, 25770, true, true, '{"blade_type": "Matte Wood ABS / 7 blades", "suitable_for": "ceiling", "sweep": "304mm / D 12in", "height_of_fan": "490mm / 19in", "light_option": "LED 3000, 4000 & 6000K 36Watts (Dimming)", "motor_spec": "153x12  / copper winding D/C motor", "airflow": "6450 / Summer /Winter option", "colour": "Wood", "media": {"primaryImage": "/images/products/ZEPHYRE_316.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('79529393-8780-4572-a093-404f49ed9b15', 'FAN-LENOX', 'LENOX', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('7c05634c-d9f1-4279-b3bb-7055d1b89c36', '79529393-8780-4572-a093-404f49ed9b15', 'FAN-LENOX-317', 'LENOX', 19770, 19770, true, true, '{"blade_type": "Retractable ABS / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "356mm / D 14in", "height_of_fan": "178mm / 7in", "light_option": "3000K, 4000K & 6000K  LED", "motor_spec": "Spec: 140 x 20   / copper winding D/C motor", "airflow": "6450  / Summer / Winter option", "colour": "White", "media": {"primaryImage": "/images/products/LENOX_317.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('7a39f135-08fb-4e0e-95e9-1f90d320c502', 'FAN-TWIN', 'TWIN', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('555bbfb9-2bea-4176-a86e-cdb10795682c', '7a39f135-08fb-4e0e-95e9-1f90d320c502', 'FAN-TWIN-318', 'TWIN', 41770, 41770, true, true, '{"blade_type": "Special wooden / 9 blades", "suitable_for": "Ceiling", "sweep": "965 mm / D38in", "height_of_fan": "457mm / 18in", "light_option": "LED 3000, 4000 & 6000k 12watts", "motor_spec": "78 x 20 x 3 / copper winding D/C motor", "airflow": "9400  / Summer / Winter option", "oscillation": "360\u00ba wide-angle", "colour": "Antique Brass", "media": {"primaryImage": "/images/products/TWIN_318.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('3a315221-ffc8-4562-81a8-b0b894b6aab6', 'FAN-VISION', 'VISION', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('ad2b8d2b-b5db-449a-b890-2c65eb8a0563', '3a315221-ffc8-4562-81a8-b0b894b6aab6', 'FAN-VISION-319', 'VISION', 19770, 19770, true, true, '{"blade_type": "Retractable ABS / 3 blades", "suitable_for": "Low ceiling / Hugger", "sweep": "356mm / D 14in", "height_of_fan": "178mm / 7in", "light_option": "3000K, 4000K & 6000K  LED", "motor_spec": "Spec: 140 x 20   / copper winding D/C motor", "airflow": "6450  / Summer / Winter option", "colour": "White", "media": {"primaryImage": "/images/products/VISION_319.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('a08f4551-31ff-44f4-82c8-0bfc428398ba', 'FAN-SOFIA', 'SOFIA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('3ea10f52-c807-4fc3-8505-2e2bb82168e3', 'a08f4551-31ff-44f4-82c8-0bfc428398ba', 'FAN-SOFIA-320', 'SOFIA', 26770, 26770, true, true, '{"blade_type": "Transparent  Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm / D 42in", "height_of_fan": "500mm / 20in", "light_option": "3000K, 4000K & 6000K  LED 36 Watts", "motor_spec": "172 x 15 / copper winding A/C motor", "airflow": "8250", "colour": "Champaign Gold", "media": {"primaryImage": "/images/products/SOFIA_320.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('b5633ef0-6e3c-45b1-8a52-c01d509f8dac', 'FAN-HERITAGE', 'HERITAGE', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('03cd18db-f2e4-4ad2-953a-0c109a32e06b', 'b5633ef0-6e3c-45b1-8a52-c01d509f8dac', 'FAN-HERITAGE-321', 'HERITAGE', 24770, 24770, true, true, '{"blade_type": "Transparent Brass ABS / 5 blades", "suitable_for": "Stand / Tower / Floor", "sweep": "407mm / D 16in", "height_of_fan": "1270mm / 50in", "motor_spec": "A/C motor", "rpm": "350", "oscillation": "90\u00ba wide-angle", "colour": "Antique Brass with Wooden", "media": {"primaryImage": "/images/products/HERITAGE_321.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('ffe38058-3c30-4bff-91e7-1b02517d5173', 'FAN-AVIATOR', 'AVIATOR', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('1daf5d7f-4579-4756-ae1e-43a34ba1d5cf', 'ffe38058-3c30-4bff-91e7-1b02517d5173', 'FAN-AVIATOR-322', 'AVIATOR', 36770, 36770, true, true, '{"blade_type": "Matte Blue ABS blades / 3 blades", "suitable_for": "ceiling", "sweep": "914mm / D 36in", "height_of_fan": "490mm / 19in", "light_option": "LED 3000, 4000 & 6000K 20Watts", "motor_spec": "140 x 20   / copper winding D/C motor", "airflow": "6450 / Summer /Winter option", "colour": "Matte Blue", "media": {"primaryImage": "/images/products/AVIATOR_322.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('83d2b314-d09f-44ee-9fe2-fe3482f2e8d0', 'FAN-LUSTER', 'LUSTER', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('989de0f7-1834-48de-afe1-8cc94d31901a', '83d2b314-d09f-44ee-9fe2-fe3482f2e8d0', 'FAN-LUSTER-323', 'LUSTER', 31770, 31770, true, true, '{"blade_type": "Transparent French Rose Gold ABS/ 6 blades", "suitable_for": "ceiling", "sweep": "558mm / D 22in", "height_of_fan": "560mm/22in", "light_option": "LED 3000, 4000 & 6000K 92Watts", "motor_spec": "140 x 20   / copper winding D/C motor", "airflow": "8025 / Summer /Winter option", "colour": "Gold", "media": {"primaryImage": "/images/products/LUSTER_323.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('8699c9b7-021d-478c-86f1-2d6b6cd3c75e', 'FAN-VELOCITY', 'VELOCITY', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('a3ff41ea-26c0-49c8-90b9-af28b1159928', '8699c9b7-021d-478c-86f1-2d6b6cd3c75e', 'FAN-VELOCITY-324', 'VELOCITY', 29770, 29770, true, true, '{"blade_type": "Reversible Special Wooden Blades / Matte Black + Ash wood/ 4 blades", "suitable_for": "Ceiling", "sweep": "1219mm / D 48in", "height_of_fan": "530mm / 21in", "motor_spec": "153 x 12 / copper winding D/C motor", "light_option": "LED 3000, 4000 & 6000k 18 Watts", "airflow": "7250  / Summer /Winter option", "colour": "Gun Metal", "media": {"primaryImage": "/images/products/VELOCITY_324.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('3da5e1ab-3ae3-4dc2-bfe8-0abfc65d08f0', '8699c9b7-021d-478c-86f1-2d6b6cd3c75e', 'FAN-VELOCITY-325', 'VELOCITY', 29770, 29770, true, true, '{"blade_type": "Reversible Special Wooden Blades / Red Wood + Light Walnut/ 4 blades", "suitable_for": "Ceiling", "sweep": "1219mm / D 48in", "height_of_fan": "530mm / 21in", "motor_spec": "153 x 12 / copper winding D/C motor", "light_option": "LED 3000, 4000 & 6000k 18 Watts", "airflow": "7250  / Summer /Winter option", "colour": "Gold", "media": {"primaryImage": "/images/products/VELOCITY_325.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('eb6cd2e2-18e3-4b3a-9ee7-b3934d376b20', 'FAN-REGAL', 'REGAL', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('5af32a7f-3c3d-4cea-ae7b-1b95b688b4ca', 'eb6cd2e2-18e3-4b3a-9ee7-b3934d376b20', 'FAN-REGAL-326', 'REGAL', 26770, 26770, true, true, '{"blade_type": "Transparent ABS blades/ 4 blades", "suitable_for": "Ceiling", "sweep": "1066 / D 42 in", "height_of_fan": "530mm / 21in", "motor_spec": "153 x 12 / copper winding D/C motor", "light_option": "LED 3000, 4000 & 6000k 24 Watts", "airflow": "7950 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/REGAL_326.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('d67835ac-4638-4303-af5c-9d511c522d05', 'FAN-MEGAN', 'MEGAN', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('fe990db4-99d3-468a-baab-68a3ed5c7fc5', 'd67835ac-4638-4303-af5c-9d511c522d05', 'FAN-MEGAN-327', 'MEGAN', 25770, 25770, true, true, '{"blade_type": "White ABS / 3 blades", "suitable_for": "ceilig", "sweep": "1321mm /D 52in", "height_of_fan": "356 mm/14in", "motor_spec": "108 x 20  / copper winding D/C motor", "airflow": "9450 / Summer /Winter option", "colour": "Matte White", "media": {"primaryImage": "/images/products/MEGAN_327.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('c66c1429-a781-4244-99b1-f44a63498c86', 'd67835ac-4638-4303-af5c-9d511c522d05', 'FAN-MEGAN-328', 'MEGAN', 27770, 27770, true, true, '{"blade_type": "Dark Walnut ABS / 3 blades", "suitable_for": "ceilig", "sweep": "1321mm /D 52in", "height_of_fan": "356 mm/14in", "motor_spec": "108 x 20  / copper winding D/C motor", "airflow": "9450 / Summer /Winter option", "colour": "Matte Black", "media": {"primaryImage": "/images/products/MEGAN_328.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('4a713f1c-eb20-41ab-a056-8652c2b0ff74', 'FAN-AMELIA', 'AMELIA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('6cbb6388-ab38-41c6-ab1a-36124b06854f', '4a713f1c-eb20-41ab-a056-8652c2b0ff74', 'FAN-AMELIA-329', 'AMELIA', 26770, 26770, true, true, '{"blade_type": "Transparent Retractable ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066mm /D 42in", "height_of_fan": "457mm / 18in", "light_option": "3000K, 4000K & 6000K  LED 36 Watts", "motor_spec": "172 x 15  / copper winding D/C motor", "airflow": "7950 / Summer / Winter option", "colour": "French Gold", "media": {"primaryImage": "/images/products/AMELIA_329.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('ee75f0d5-831b-4986-8273-5a736306ca36', 'FAN-DAHLIA', 'DAHLIA', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('83acc580-f95e-4b39-b95c-8817d16ed63e', 'ee75f0d5-831b-4986-8273-5a736306ca36', 'FAN-DAHLIA-330', 'DAHLIA', 26770, 26770, true, true, '{"blade_type": "Transparent ABS / 4 blades", "suitable_for": "Ceiling", "sweep": "1066 / D 42 in", "height_of_fan": "530mm / 21in", "motor_spec": "153 x 15 / copper winding A/C motor", "light_option": "LED 3000, 4000 & 6000k 36 Watts", "airflow": "7950 / Summer /Winter option", "body_color": "Matte White", "media": {"primaryImage": "/images/products/DAHLIA_330.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('b5d07db3-6970-4482-ae7c-bbe97cf606ab', 'FAN-MEF_332', 'MEF-332', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('8cf50c81-662e-4a40-8125-7afd312e2d7e', 'b5d07db3-6970-4482-ae7c-bbe97cf606ab', 'FAN-MEF_332-331', 'MEF-332', 3350, 3350, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A158 X B19 X C30 X D81 X E99 mm", "inch": "\"\u2300 6\"", "fising": "Black", "media": {"primaryImage": "/images/products/MEF_332_331.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('d327b288-79c5-4d09-b800-3690ce5f87bc', 'b5d07db3-6970-4482-ae7c-bbe97cf606ab', 'FAN-MEF_332-332', 'MEF-332', 3350, 3350, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A158 X B19 X C30 X D81 X E99 mm", "inch": "\"\u2300 6\"", "fising": "White", "media": {"primaryImage": "/images/products/MEF_332_332.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('1393f76d-0d7a-4c26-8d30-b9b1b14278c4', 'FAN-MEF_333', 'MEF-333', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('fc31a433-f192-402b-8865-6f3cc9543195', '1393f76d-0d7a-4c26-8d30-b9b1b14278c4', 'FAN-MEF_333-333', 'MEF-333', 3650, 3650, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A158 X B19 X C30 X D81 X E99 mm", "inch": "\"\u2300 6\"", "fising": "Rose Gold", "media": {"primaryImage": "/images/products/MEF_333_333.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('749f916b-7f0b-4a97-aaf1-34b57b272483', '1393f76d-0d7a-4c26-8d30-b9b1b14278c4', 'FAN-MEF_333-334', 'MEF-333', 3650, 3650, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A158 X B19 X C30 X D81 X E99 mm", "inch": "\"\u2300 6\"", "fising": "French Gold", "media": {"primaryImage": "/images/products/MEF_333_334.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('f401114d-9148-4b81-9a82-3bcab65dbd9e', 'FAN-MEF_311', 'MEF-311', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('64479c99-bd56-43fb-b605-2d08e6561d6f', 'f401114d-9148-4b81-9a82-3bcab65dbd9e', 'FAN-MEF_311-335', 'MEF-311', 0, 0, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A158 X B158 X C39 X D81 X E99 mm", "inch": "\"\u2300 4\"", "fising": "Brushed Sliver", "media": {"primaryImage": "/images/products/MEF_311_335.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('0c6d4ee8-dc64-4a46-8625-80efe6adacac', 'FAN-MEF_312', 'MEF-312', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('dd75eb68-3ebf-4804-b7be-d156ad3c5fc8', '0c6d4ee8-dc64-4a46-8625-80efe6adacac', 'FAN-MEF_312-336', 'MEF-312', 3070, 3070, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A196 X B170 X C43 X D125 X E145 mm", "inch": "\"\u2300 6\"", "fising": "Brushed Sliver", "media": {"primaryImage": "/images/products/MEF_312_336.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('2487f301-347c-4cd0-854f-7460d11d84f8', 'FAN-MEF_313', 'MEF-313', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('478674a1-abf7-45ef-8ba2-87e9fef4a4a3', '2487f301-347c-4cd0-854f-7460d11d84f8', 'FAN-MEF_313-337', 'MEF-313', 2570, 2570, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A158 X B158 X C39 X D81 X E99 mm", "inch": "\"\u2300 4\"", "fising": "Glassy Black", "media": {"primaryImage": "/images/products/MEF_313_337.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('0cb1cfef-4185-45a4-ad8a-53c934f9aecb', 'FAN-MEF_314', 'MEF-314', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('fe7cd7f0-ff64-4c9b-9bda-04b84b257dba', '0cb1cfef-4185-45a4-ad8a-53c934f9aecb', 'FAN-MEF_314-338', 'MEF-314', 3070, 3070, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A196 X B170 X C43 X D125 X E145 mm", "inch": "\"\u2300 6\"", "fising": "Glassy Black", "media": {"primaryImage": "/images/products/MEF_314_338.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('3df5ad1c-cd15-4e2b-a11a-df005bed5a77', 'FAN-MEF_315', 'MEF-315', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('c3b4cf72-f72b-4538-ba8f-7e5df5240dea', '3df5ad1c-cd15-4e2b-a11a-df005bed5a77', 'FAN-MEF_315-339', 'MEF-315', 2070, 2070, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A158 X B158 X C39 X D81 X E99 mm", "inch": "\"\u2300 4\"", "fising": "White", "media": {"primaryImage": "/images/products/MEF_315_339.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('54aef654-d108-4c34-abcb-8a59981ebebb', 'FAN-MEF_316', 'MEF-316', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('29402cb8-d1bb-4546-b9e7-bfc68d7983a6', '54aef654-d108-4c34-abcb-8a59981ebebb', 'FAN-MEF_316-340', 'MEF-316', 2370, 2370, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A196 X B170 X C43 X D125 X E145 mm", "inch": "\"\u2300 6\"", "fising": "White", "media": {"primaryImage": "/images/products/MEF_316_340.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('537983ea-8550-4d39-9ad2-0141cb8e9626', 'FAN-MEF_318', 'MEF-318', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('f3f1722b-e8dd-4eb9-81a0-dea0a31e1175', '537983ea-8550-4d39-9ad2-0141cb8e9626', 'FAN-MEF_318-341', 'MEF-318', 3670, 3670, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A158 X B158 X C39 X D81 X E99 mm", "light_option": "LED / Center and sides", "inch": "\"\u2300 4\"", "fising": "Brushed Sliver", "media": {"primaryImage": "/images/products/MEF_318_341.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('4d43942b-3028-4af0-bbf1-bd32721698ba', 'FAN-MEF_319', 'MEF-319', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('6b027d55-977d-42dd-9636-7e83f5d877e2', '4d43942b-3028-4af0-bbf1-bd32721698ba', 'FAN-MEF_319-342', 'MEF-319', 4170, 4170, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A196 X B170 X C43 X D125 X E145 mm", "light_option": "LED / Center and sides", "inch": "\"\u2300 6\"", "fising": "Brushed Sliver", "media": {"primaryImage": "/images/products/MEF_319_342.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('d0ee2961-bbe1-43f5-866c-199ec3553f38', 'FAN-MEF_320', 'MEF-320', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('053bac82-1c62-4d84-8b74-7dfd69d72e8f', 'd0ee2961-bbe1-43f5-866c-199ec3553f38', 'FAN-MEF_320-343', 'MEF-320', 3670, 3670, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A158 X B158 X C39 X D81 X E99 mm", "light_option": "LED / Center and sides", "inch": "\"\u2300 4\"", "fising": "Glassy Black", "media": {"primaryImage": "/images/products/MEF_320_343.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('5a14dd9f-acba-4f98-b9ac-f0a8428e3e9e', 'FAN-MEF_321', 'MEF-321', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('40e88118-02fa-4343-ade4-be7544549f7f', '5a14dd9f-acba-4f98-b9ac-f0a8428e3e9e', 'FAN-MEF_321-344', 'MEF-321', 4170, 4170, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A196 X B170 X C43 X D125 X E145 mm", "light_option": "LED / Center and sides", "inch": "\"\u2300 6\"", "fising": "Glassy Black", "media": {"primaryImage": "/images/products/MEF_321_344.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('dc420405-f341-40fb-8835-7c959ded3e88', 'FAN-MEF_322', 'MEF-322', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('2d5ffc6c-97ec-45c7-b82c-654304c9be0b', 'dc420405-f341-40fb-8835-7c959ded3e88', 'FAN-MEF_322-345', 'MEF-322', 3370, 3370, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A158 X B158 X C39 X D81 X E99 mm", "light_option": "LED / sides", "inch": "\"\u2300 4\"", "fising": "Brushed silver", "media": {"primaryImage": "/images/products/MEF_322_345.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('9b259d5f-1cb1-45be-8abd-9e8b193d47a8', 'FAN-MEF_323', 'MEF-323', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('f8c6b21b-810b-45a5-b2a0-f9221cb9d2e5', '9b259d5f-1cb1-45be-8abd-9e8b193d47a8', 'FAN-MEF_323-346', 'MEF-323', 3770, 3770, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A196 X B170 X C43 X D125 X E145 mm", "light_option": "LED / sides", "inch": "\"\u23006\"", "fising": "Brushed silver", "media": {"primaryImage": "/images/products/MEF_323_346.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('40e4043f-297f-466f-b6c9-5aa848301910', 'FAN-MEF_324', 'MEF-324', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('0d96a259-a1ef-41d5-bc46-587ca63d62e1', '40e4043f-297f-466f-b6c9-5aa848301910', 'FAN-MEF_324-347', 'MEF-324', 3370, 3370, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A158 X B158 X C39 X D81 X E99 mm", "light_option": "LED / sides", "inch": "\"\u2300 4\"", "fising": "Glassy White", "media": {"primaryImage": "/images/products/MEF_324_347.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('05c98f33-847d-4737-9169-a7dc993d842c', 'FAN-MEF_325', 'MEF-325', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('a55bf7b6-fd52-4451-b3db-7219edaf4552', '05c98f33-847d-4737-9169-a7dc993d842c', 'FAN-MEF_325-348', 'MEF-325', 3770, 3770, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A196 X B170 X C43 X D125 X E145 mm", "light_option": "LED / sides", "inch": "\"\u23006\"", "fising": "Glassy Black", "media": {"primaryImage": "/images/products/MEF_325_348.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('a944dff2-e7a8-46f4-b73d-ac903fc2c8b7', 'FAN-MEF_309', 'MEF-309', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('70f1b310-dc7c-4e79-9886-fcc1e6f9eeaa', 'a944dff2-e7a8-46f4-b73d-ac903fc2c8b7', 'FAN-MEF_309-349', 'MEF-309', 3370, 3370, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A158 X B158 X C39 X D81 X E99 mm", "light_option": "LED / sides", "inch": "\"\u2300 4\"", "fising": "Glassy White", "media": {"primaryImage": "/images/products/MEF_309_349.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('a2dbd2df-3034-4a00-9887-401c8b420a7d', 'FAN-MEF_310', 'MEF-310', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('9bf35cf4-f788-41bc-88ed-782dee86ad84', 'a2dbd2df-3034-4a00-9887-401c8b420a7d', 'FAN-MEF_310-350', 'MEF-310', 3870, 3870, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A196 X B170 X C43 X D125 X E145 mm", "light_option": "LED / sides", "inch": "\"\u23006\"", "fising": "Glassy White", "media": {"primaryImage": "/images/products/MEF_310_350.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('9b568f5d-5d3e-4ace-8740-c5f171688e27', 'FAN-MEF_317_CM', 'MEF-317-CM', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('d747343b-14dc-4c14-916e-52b70e44f967', '9b568f5d-5d3e-4ace-8740-c5f171688e27', 'FAN-MEF_317_CM-351', 'MEF-317-CM', 2270, 2270, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust ceiling", "size": "A246 X B20 X C51 X D98 X E206 X F242 mm", "inch": "\"8\"", "fising": "White", "media": {"primaryImage": "/images/products/MEF_317_CM_351.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('5c0453c5-51f4-47e4-9178-7a8489ce425c', 'FAN-MEF_326', 'MEF-326', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('a573012e-49a7-4c3e-a5ae-7bcee792b490', '5c0453c5-51f4-47e4-9178-7a8489ce425c', 'FAN-MEF_326-352', 'MEF-326', 0, 0, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A196 X B170 X C43 X D125 X E145 mm", "inch": "\"\u2300 6\"", "fising": "Rose Wood", "media": {"primaryImage": "/images/products/MEF_326_352.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('cb268222-e1e5-41d4-b285-1169c2b73c0f', 'FAN-MEF_327', 'MEF-327', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('9c559d53-ea06-4ced-a373-c128445c57ef', 'cb268222-e1e5-41d4-b285-1169c2b73c0f', 'FAN-MEF_327-353', 'MEF-327', 0, 0, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A196 X B170 X C43 X D125 X E145 mm", "inch": "\"\u2300 6\"", "fising": "Beach Wood", "media": {"primaryImage": "/images/products/MEF_327_353.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('d432759b-108f-47fe-947d-b3aa47b0ab02', 'FAN-MEF_328', 'MEF-328', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('a3749021-db8c-4490-a2ed-ebc0bd5c9194', 'd432759b-108f-47fe-947d-b3aa47b0ab02', 'FAN-MEF_328-354', 'MEF-328', 2970, 2970, true, true, '{"model": "Areo Air Series", "suitable_for": "Exhaust (Wall & ceiling)", "size": "A196 X B170 X C43 X D125 X E145 mm", "inch": "\"\u2300 6\"", "fising": "Gold", "media": {"primaryImage": "/images/products/MEF_328_354.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('4799efa3-9d5a-4248-9c4c-9cdb4ce97f29', 'FAN-MEF_329', 'MEF-329', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('40d96c40-16a7-4dd0-be7b-e55e6e6543b5', '4799efa3-9d5a-4248-9c4c-9cdb4ce97f29', 'FAN-MEF_329-355', 'MEF-329', 1170, 1170, true, true, '{"model": "Fresh Air Series", "suitable_for": "Exhaust Wall", "size": "150mm", "inch": "\"6\"", "fising": "White"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('7ce6057f-1119-426d-9d4e-f1ae1455810f', 'FAN-MEF_330', 'MEF-330', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('c6e19d4a-ba26-4fad-bb8e-6b1edafac7df', '7ce6057f-1119-426d-9d4e-f1ae1455810f', 'FAN-MEF_330-356', 'MEF-330', 1370, 1370, true, true, '{"model": "Fresh Air Series", "suitable_for": "Exhaust Wall", "size": "200 mm", "inch": "\"8\"", "fising": "White"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('cc17a2bd-ad11-4441-8957-f76d5f851b9f', 'FAN-MEF_331', 'MEF-331', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('ebed8a42-a666-460a-bb95-836a82b0af3b', 'cc17a2bd-ad11-4441-8957-f76d5f851b9f', 'FAN-MEF_331-357', 'MEF-331', 1570, 1570, true, true, '{"model": "Fresh Air Series", "suitable_for": "Exhaust Wall", "size": "250 mm", "inch": "\"10\"", "fising": "White", "media": {"primaryImage": "/images/products/MEF_331_357.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('70067c00-a6e9-4f11-812f-5fc99499078a', 'FAN-MEF_301', 'MEF-301', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('43d4786c-83d4-4fbf-bbdc-af0b36c84f18', '70067c00-a6e9-4f11-812f-5fc99499078a', 'FAN-MEF_301-358', 'MEF-301', 1270, 1270, true, true, '{"model": "Fresh Air Series", "suitable_for": "Exhaust Wall", "size": "A150 X B205 X C40 X D38 X E150 mm", "inch": "\"6\"", "fising": "White"}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('a4f99dcc-72fb-4caf-b34f-12adc86fe4c9', 'FAN-MEF_302', 'MEF-302', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('6954b6dd-16b6-44f6-9bd1-017048a4ccb6', 'a4f99dcc-72fb-4caf-b34f-12adc86fe4c9', 'FAN-MEF_302-359', 'MEF-302', 1270, 1270, true, true, '{"model": "Fresh Air Series", "suitable_for": "Exhaust Wall / Pull Chain", "size": "A150 X B100 X C158 X D168 mm", "inch": "\"4\"", "fising": "White", "media": {"primaryImage": "/images/products/MEF_302_359.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('2eb5164f-2299-4a41-8d0d-1b9355cc03e8', 'FAN-MEF_303', 'MEF-303', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b9678d2b-7976-4893-8434-3d2b3ad3fbbe', '2eb5164f-2299-4a41-8d0d-1b9355cc03e8', 'FAN-MEF_303-360', 'MEF-303', 1370, 1370, true, true, '{"model": "Fresh Air Series", "suitable_for": "Exhaust Wall / Pull Chain", "size": "A155 X B146 X C203 X D216 mm", "inch": "\"6\"", "fising": "White", "media": {"primaryImage": "/images/products/MEF_303_360.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('3621f5af-03c8-4aa5-b6f3-135f2f2753d0', 'FAN-MEF_304', 'MEF-304', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('14a7831b-01d5-4816-af59-e579453a08b1', '3621f5af-03c8-4aa5-b6f3-135f2f2753d0', 'FAN-MEF_304-361', 'MEF-304', 0, 0, true, true, '{"model": "Fresh Air Series", "suitable_for": "Exhaust Wall / Auto Shutter", "size": "A155 X B146 X C203 X D70 mm", "inch": "\"4\"", "fising": "White", "media": {"primaryImage": "/images/products/MEF_304_361.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('931665c1-48c9-47b5-b967-7373c6461550', 'FAN-MEF_305', 'MEF-305', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('f2852bc2-381f-4baf-8078-f181b6a6a20d', '931665c1-48c9-47b5-b967-7373c6461550', 'FAN-MEF_305-362', 'MEF-305', 970, 970, true, true, '{"model": "Fresh Air Series", "suitable_for": "Exhaust Wall", "size": "A150 X B100 X C140 X D140 mm", "inch": "\"4\"", "fising": "White", "media": {"primaryImage": "/images/products/MEF_305_362.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('858fcd3e-9245-4704-9a49-30e7ad056616', 'FAN-MEF_306', 'MEF-306', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('b02d2fd5-4d28-4612-8896-fb41febc7ae5', '858fcd3e-9245-4704-9a49-30e7ad056616', 'FAN-MEF_306-363', 'MEF-306', 0, 0, true, true, '{"model": "Fresh Air Series", "suitable_for": "Exhaust Wall", "size": "A155 X B148 X C205 X D205 mm", "inch": "\"6\"", "fising": "White", "media": {"primaryImage": "/images/products/MEF_306_363.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('ce1a6637-e16a-4948-a8ad-b8ca149f3ec1', 'FAN-MEF_307', 'MEF-307', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('ade87eef-260d-4456-99d8-20512ed8565d', 'ce1a6637-e16a-4948-a8ad-b8ca149f3ec1', 'FAN-MEF_307-364', 'MEF-307', 970, 970, true, true, '{"model": "Fresh Air Series", "suitable_for": "Exhaust Wall", "size": "A150 X B95 X C149 X D149 mm", "inch": "\"4\"", "fising": "White", "media": {"primaryImage": "/images/products/MEF_307_364.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;


  INSERT INTO product_templates ("templateId", "skuFamily", name, "categoryId", "itemType", "isConfigurable", "updatedAt")
  VALUES ('3150fa59-b943-4b04-9898-ed38267435ed', 'FAN-MEF_308', 'MEF-308', fan_category_id, 'FinishedGood', false, CURRENT_TIMESTAMP)
  ON CONFLICT ("skuFamily") DO UPDATE SET name = EXCLUDED.name, "updatedAt" = CURRENT_TIMESTAMP;


  INSERT INTO product_variants ("variantId", "templateId", sku, "variantName", "catalogPrice", "showroomPrice", "isSellable", "isStockTracked", attributes, "updatedAt")
  VALUES ('39e60892-6b49-4052-9525-34d3a16ca6ca', '3150fa59-b943-4b04-9898-ed38267435ed', 'FAN-MEF_308-365', 'MEF-308', 1270, 1270, true, true, '{"model": "Fresh Air Series", "suitable_for": "Exhaust Wall", "size": "A155 X B145 X C207 X D207 mm", "inch": "\"6\"", "fising": "White", "media": {"primaryImage": "/images/products/MEF_308_365.jpg"}}'::jsonb, CURRENT_TIMESTAMP)
  ON CONFLICT (sku) DO NOTHING;

END $$;