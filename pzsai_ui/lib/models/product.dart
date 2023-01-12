class Product {
  final String? bannerURL;
  final String? ingredients;
  final String? category;

  final String brand;
  final String description;

  final double proteinG;
  final double fatG;
  final double carbohydrateG;
  final double? energyKcal;

  Product({
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
}
