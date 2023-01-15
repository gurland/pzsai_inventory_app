from playhouse.postgres_ext import *
from settings import PG_USER, PG_PASSWORD, PG_DB, PG_HOST


db = PostgresqlDatabase(PG_DB, user=PG_USER, host=PG_HOST, password=PG_PASSWORD)


class Base(Model):
    class Meta:
        database = db


class Product(Base):
    id = IntegerField(primary_key=True)
    brand = CharField()
    description = TextField()
    search_content = TSVectorField()
    ingredients = TextField()
    category = CharField(null=True)
    protein_g = DecimalField()
    fat_g = DecimalField()
    carbohydrate_g = DecimalField()
    energy_kcal = DecimalField(null=True)

    def to_dict(self):
        return {'id': self.id, 'brand': self.brand, 'description': self.description,
                'ingredients': self.ingredients, 'category': self.category,
                'protein_g': self.protein_g, 'fat_g': self.fat_g,
                'carbohydrate_g': self.carbohydrate_g, 'energy_kcal': self.energy_kcal}

    @classmethod
    def from_dict(cls, record):
        protein_g, fat_g, carbohydrate_g, energy_kcal = 0, 0, 0, None
        category = record.get("brandedFoodCategory", None)
        if category:
            category = category.lower()
        for n in record["foodNutrients"]:
            if n["nutrient"]['number'] == "203":
                protein_g = n["amount"]
            elif n["nutrient"]['number'] == "204":
                fat_g = n["amount"]
            elif n["nutrient"]['number'] == "205":
                carbohydrate_g = n["amount"]
            elif n["nutrient"]['number'] == "208":
                energy_kcal = n["amount"]

        return Product(
            id=record["fdcId"],
            brand=record["brandOwner"],
            description=record["description"].capitalize(),
            search_content=fn.to_tsvector(f'{record["fdcId"]} {record["brandOwner"]} {record["description"].capitalize()}'),
            ingredients=record["ingredients"].capitalize(),
            category=category,
            protein_g=protein_g,
            fat_g=fat_g,
            carbohydrate_g=carbohydrate_g,
            energy_kcal=energy_kcal
        )


db.create_tables([Product])
