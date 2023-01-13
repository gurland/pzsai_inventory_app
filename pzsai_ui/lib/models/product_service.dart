import 'dart:convert';

import 'package:http/http.dart' as http;
import 'product.dart';

class ProductService {
  static const String baseURL = "http://10.0.2.2:80";

  static Future<List<Product>> GetProducts(String searchTerm) async {
    final response = await http
        .get(Uri.parse('$baseURL/api/products?search_term=$searchTerm'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Product> p = List<Product>.from(jsonDecode(response.body)
          .map((productJson) => Product.fromJson(productJson)));
      return p;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }

    http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  }
}
