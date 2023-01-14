import 'package:flutter/material.dart';

import 'models/product.dart';
import 'mocks/mock_product.dart';
import 'product_list.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'models/product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchTerm = "cola";

  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = ProductService.GetProducts(searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            icon: const Icon(Icons.document_scanner_outlined),
            iconSize: 38,
            tooltip: 'Search by barcode',
            onPressed: () async {
              String barcodeScanRes;
              try {
                barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    '#ff6666', 'Cancel', true, ScanMode.BARCODE);
                print(barcodeScanRes);
              } on PlatformException {
                barcodeScanRes = 'Failed to get platform version.';
              }
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProductList(snapshot.data!);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
