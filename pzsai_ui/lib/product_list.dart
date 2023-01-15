import 'package:flutter/material.dart';
import 'package:pzsai_ui/product_detail.dart';
import 'package:pzsai_ui/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'product_detail.dart';

import 'models/product.dart';

class ProductList extends StatelessWidget {
  final List<Product> _products;

  ProductList(this._products);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _products.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: _itemThumbnail(_products[index]),
          title: _itemTitle(_products[index]),
          onTap: () {
            Product product = _products[index];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetail(product),
              ),
            );
          },
        );
      },
    );
  }

  Widget _itemThumbnail(Product product) {
    return Container(
      constraints: BoxConstraints.tightFor(width: 100.0),
      child: ProductDetail.banner(product.bannerURL, 30),
    );
  }

  Widget _itemTitle(Product product) {
    return Text(
      product.brand,
      style: Styles.textDefault,
    );
  }
}
