class Product {
  final String brand;
  final String description;
  final double proteinG;
  final double fatG;
  final double carbohydrateG;
  final double? energyKcal;

  Product({
    required this.brand,
    required this.description,
    required this.proteinG,
    required this.fatG,
    required this.carbohydrateG,
    this.energyKcal,
  });
}
