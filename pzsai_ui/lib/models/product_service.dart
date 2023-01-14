import 'dart:convert';

import 'package:http/http.dart' as http;
import 'product.dart';

class ProductService {
  static const String baseURL = "http://192.168.1.218:80";

  static Future<List<Product>> GetProducts(String searchTerm) async {
    final response = await http
        .get(Uri.parse('$baseURL/api/products?search_term=$searchTerm'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Product> products = List<Product>.from(jsonDecode(response.body)
          .map((productJson) => Product.fromJson(productJson)));

      for (Product product in products) {
        product.bannerURL = "$baseURL/images/${product.category}";
      }
      return products;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }

    http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  }
}
