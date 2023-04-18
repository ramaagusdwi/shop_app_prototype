import 'package:flutter/material.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductService().getProducts();
      // List<ProductModel> fixProduct = [];
      // for (var i = 1; i < products.length; i++) {
      //   // Body of the loop
      //   var produk = products[i].copyWith(name: 'Voucher $i');
      //   fixProduct.add(produk);
      // }
      // _products = fixProduct;
      _products = products;
    } catch (e) {
      print(e);
    }
  }
}
