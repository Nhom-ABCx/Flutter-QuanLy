import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../all_page.dart';

class ProductController extends ChangeNotifier {
  List<Product> product = [];
  Future<List<Product>> getData(String txtTimKiem) async {
    print("getData");
    product = await apiGetProduct(txtTimKiem);
    return product;
  }
}
