class Product {
  final int id;

  String? bannerURL;
  final String? ingredients;
  final String? category;

  final String brand;
  final String description;

  final double proteinG;
  final double fatG;
  final double carbohydrateG;
  final double? energyKcal;

  Product({
    required this.id,
    this.bannerURL,
    this.ingredients,
    this.category,
    required this.brand,
    required this.description,
    required this.proteinG,
    required this.fatG,
    required this.carbohydrateG,
    this.energyKcal,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      brand: json['brand'],
      description: json['description'],
      ingredients: json['ingredients'],
      category: json['category'],
      proteinG: double.parse(json['protein_g']),
      fatG: double.parse(json['fat_g']),
      carbohydrateG: double.parse(json['carbohydrate_g']),
      energyKcal: double.parse(json['energy_kcal']),
    );
  }
}
