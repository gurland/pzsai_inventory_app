import time

import ijson
from models import Product


s = time.time()
bulk_products = []

# To obtain dataset JSON file please visit https://fdc.nal.usda.gov/download-datasets.html
with open("FoodData_Central_branded_food_json_2022-10-28.json", "rb") as f:
    for product_record in ijson.items(f, "BrandedFoods.item"):
        product = Product.from_dict(product_record)
        bulk_products.append(product)

        if len(bulk_products) > 998:
            Product.bulk_create(bulk_products)
            bulk_products.clear()

    Product.bulk_create(bulk_products)
    bulk_products.clear()

print("Seconds from seeding start: ", end="")
print(time.time()-s)
