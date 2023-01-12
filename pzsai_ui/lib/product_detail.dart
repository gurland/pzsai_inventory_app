import 'package:flutter/material.dart';
import 'models/product.dart';

class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail(this.product);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text(product.description)),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _renderBody(context, product)));
  }

  List<Widget> _renderBody(BuildContext context, Product product) {
    var result = <Widget>[];
    result.add(_sectionTitle(product.description));
    result.add(_banner(product.bannerURL, 170.0));
    result.add(_sectionText(RichText(
        text: TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.black),
            children: [
          _textSpanIngredients(product.ingredients),
          _textSpanKeyValue("Brand", product.brand),
          _textSpanKeyValue("Protein", "${product.proteinG} g"),
          _textSpanKeyValue("Fat", "${product.fatG} g"),
          _textSpanKeyValue("Carbohydrate", "${product.carbohydrateG} g"),
          _textSpanKeyValue("Food energy", "${product.energyKcal} g"),
        ]))));

    return result;
  }

  Widget _banner(String? url, double height) {
    Image bannerImage = url != null
        ? Image.network(url, fit: BoxFit.fitWidth)
        : const Image(
            image: AssetImage("images/no_banner_image.jpg"),
            fit: BoxFit.fitHeight);

    return Container(
        constraints: BoxConstraints.tightFor(height: height),
        child: bannerImage);
  }

  Widget _sectionText(RichText text) {
    return Container(
        padding: EdgeInsets.fromLTRB(15.0, 5.0, 25.0, 15.0), child: text);
  }

  TextSpan _textSpanIngredients(String? ingredients) {
    if (ingredients == null) {
      return TextSpan();
    }
    return TextSpan(children: [
      _textSpanKeyValue("Ingredients", ingredients + "\n\n"),
    ]);
  }

  TextSpan _textSpanKeyValue(String key, String value) {
    return TextSpan(children: [
      TextSpan(text: "${key}: ", style: TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(text: value),
      TextSpan(text: "\n")
    ]);
  }

  TextSpan _textSpanPlain(String text) {
    return TextSpan(text: "$text\n\n");
  }

  Widget _sectionTitle(String text) {
    return Container(
        padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
        child: Text(text,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.black,
            )));
  }
}