import '../models/product.dart';

class MockProduct extends Product {
  MockProduct(
      {required super.brand,
      required super.description,
      required super.proteinG,
      required super.fatG,
      required super.carbohydrateG});

  static Product FetchAny() {
    return Product(
        brand: "PEPSICO, INC",
        description: "RASPBERRY ICED TEA, RASPBERRY",
        proteinG: 0,
        fatG: 0,
        carbohydrateG: 5.35);
  }
}
