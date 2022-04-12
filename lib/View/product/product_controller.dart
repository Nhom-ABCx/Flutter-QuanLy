import 'dart:async';
import 'package:get/get.dart';
import '../../API/api_manager.dart';
import '../../Model/product.dart';

class ProductController extends GetxController {
  List<Product> product = [];
  Future<List<Product>> getData(String txtTimKiem, [String categoryTimKiem = "Tất cả"]) async {
    print("getData");
    product = await apiGetProduct(txtTimKiem, categoryTimKiem);
    return product;
  }
}
