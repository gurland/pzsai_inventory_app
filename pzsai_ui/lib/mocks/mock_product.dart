import '../models/product.dart';
import "dart:math";

class MockProduct extends Product {
  MockProduct(
      {required super.brand,
      required super.description,
      required super.proteinG,
      required super.fatG,
      required super.carbohydrateG});

  static Product FetchAny() {
    final _random = new Random();

    var products = [
      Product(
          bannerURL:
              "https://imagekit.io/blog/content/images/2020/06/Server_User.png",
          brand: "FRESH & EASY",
          description: "Fresh & easy, tilapia",
          category: "frozen fish & seafood",
          proteinG: 17.90000,
          fatG: 0.89000,
          carbohydrateG: 0,
          energyKcal: 89),
      Product(
          bannerURL: null,
          brand: "CLAWSON",
          description: "Lemon zest",
          ingredients:
              "White stilton (pasteurized cow's milk, salt, vegetarian rennet, dairy cultures), lemon compote (12%) (water, sugar, lemon juice concentrate, rice starch, flavoring), candied lemon peel (9%) (lemon peel, glucose-fructose syrup, sugar, citric acid as an acidity regulator).",
          category: "cheese",
          proteinG: 14.30000,
          fatG: 25.00000,
          carbohydrateG: 10.7,
          energyKcal: 357.00000)
    ];

    return products[_random.nextInt(products.length)];
  }
}
