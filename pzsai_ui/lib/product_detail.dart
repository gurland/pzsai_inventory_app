import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'models/product.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:barcode_image/barcode_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pdf/pdf.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ProductDetail extends StatelessWidget {
  final Product product;
  final barcodeDoc = pw.Document();

  ProductDetail(this.product);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(product.description),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _renderBody(context, product),
        ),
      ),
    );
  }

  List<Widget> _renderBody(BuildContext context, Product product) {
    var result = <Widget>[];
    result.add(_sectionTitle(product.description));
    result.add(banner(product.bannerURL, 170.0));
    result.add(
      _sectionText(
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.black),
            children: [
              _textSpanIngredients(product.ingredients),
              _textSpanKeyValue("Brand", product.brand),
              product.category != null
                  ? _textSpanKeyValue("Category", product.category!)
                  : TextSpan(),
              _textSpanKeyValue("Protein", "${product.proteinG} g"),
              _textSpanKeyValue("Fat", "${product.fatG} g"),
              _textSpanKeyValue("Carbohydrate", "${product.carbohydrateG} g"),
              _textSpanKeyValue("Food energy", "${product.energyKcal} g"),
            ],
          ),
        ),
      ),
    );
    result.add(_sectionBarcode(context, product.id));

    return result;
  }

  static Widget banner(String? url, double height) {
    const Image noBannerImage = Image(
        image: AssetImage("images/no_banner_image.jpg"), fit: BoxFit.fitHeight);
    Widget bannerImage = url != null
        ? CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            placeholder: (context, url) => SizedBox(
              child: CircularProgressIndicator(),
              height: 50.0,
              width: 50.0,
            ),
            errorWidget: (context, url, error) => noBannerImage,
          )
        : noBannerImage;

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
            style: const TextStyle(
              fontSize: 25.0,
              color: Colors.black,
            )));
  }

  Widget _sectionBarcode(BuildContext context, int product_id) {
    var barcodeData = product_id.toString().length % 2 == 0
        ? product_id.toString()
        : '0' + product_id.toString();
    BarcodeWidget barcode = BarcodeWidget(
      barcode: Barcode.itf(), // Barcode type and settings
      data: barcodeData, // Content
      width: 300,
      height: 100,
    );

    final image = img.Image(600, 300);

    // Fill it with a solid color (white)
    img.fill(image, img.getColor(255, 255, 255));

    // Draw the barcode
    drawBarcode(image, Barcode.itf(), barcodeData, font: img.arial_24);

    var encoder = img.PngEncoder();
    encoder.addFrame(image);

    barcodeDoc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(
              pw.MemoryImage(
                Uint8List.fromList(encoder.finish() ?? []),
              ),
            ),
          ); // Center
        },
      ),
    ); // Page

    return InkWell(
        onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: Text("PDF Preview"),
                      ),
                      body: Container(
                        child: PdfPreview(
                          build: (format) => barcodeDoc.save(),
                        ),
                      ),
                    ),
                  ))
            },
        child: Container(
          padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 10.0),
          child: barcode,
        ));
  }
}
