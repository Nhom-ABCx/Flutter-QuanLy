import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../all_page.dart';

class ProductController extends ChangeNotifier {
  List<Product> product = [];
  Future<List<Product>> getData(String txtTimKiem, [String categoryTimKiem = "Tất cả"]) async {
    print("getData");
    product = await apiGetProduct(txtTimKiem, categoryTimKiem);
    return product;
  }
}
