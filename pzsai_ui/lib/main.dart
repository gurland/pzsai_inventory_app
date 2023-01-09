import 'package:pzsai_ui/mocks/mock_product.dart';

import 'product_detail.dart';
import 'package:flutter/material.dart';
import 'models/product.dart';

void main() {
  final Product mockProduct = MockProduct.FetchAny();

  return runApp(MaterialApp(home: ProductDetail(mockProduct)));
}
