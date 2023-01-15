import 'package:flutter/material.dart';

import 'models/product.dart';
import 'mocks/mock_product.dart';
import 'product_list.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'models/product_service.dart';
import 'package:easy_search_bar/easy_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchTerm = "Soda";

  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = ProductService.SearchProducts(searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text('Products'),
        onSearch: (searchTerm) => {
          if (searchTerm.length > 1)
            {
              setState(
                () => {_products = ProductService.SearchProducts(searchTerm)},
              )
            }
        },
        suggestions: ["Soda", "Chips", "Pepsi"],
        actions: [
          IconButton(
            icon: const Icon(Icons.document_scanner_outlined),
            iconSize: 26,
            tooltip: 'Search by barcode',
            onPressed: () async {
              String barcodeScanRes;
              try {
                barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    '#ff6666', 'Cancel', true, ScanMode.BARCODE);
                print(barcodeScanRes);
                if (barcodeScanRes != "-1") {
                  setState(
                    () => {
                      _products = ProductService.SearchProducts(barcodeScanRes)
                    },
                  );
                }
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
