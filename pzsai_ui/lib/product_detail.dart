import 'package:flutter/material.dart';
import 'models/product.dart';

class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail(this.product);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text(product.brand)),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _section(product.brand, Colors.white),
              _section(product.description, Colors.white),
              _section(product.proteinG.toString(), Colors.white),
              _section(product.fatG.toString(), Colors.white),
              _section(product.carbohydrateG.toString(), Colors.white),
              _section(product.energyKcal.toString(), Colors.white),
            ]));
  }

  Widget _section(String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
      ),
      child: Text(title),
    );
  }
}
