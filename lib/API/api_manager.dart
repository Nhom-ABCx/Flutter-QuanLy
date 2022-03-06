import 'dart:convert';
import 'dart:core';
import '../all_page.dart';

Future<List<Product>> apiGetProduct(String txtTimKiem, String categoryTimKiem) async {
  List<Product> lst = [];
  try {
    final response = await Http().get("/getProduct");
    if (response.statusCode == 200) {
      List jsonRaw = json.decode(response.body);
      lst = jsonRaw.map((data) => Product.fromJson(data)).where((element) {
        final nameLower = element.category!.categoryName!.toLowerCase();
        final queryLower = (categoryTimKiem == "Tất cả") ? "" : categoryTimKiem.toLowerCase();
        return nameLower.contains(queryLower);
      }).where((element) {
        final nameLower = element.productName!.toLowerCase(); //chuyen cai ten thanh chu thuong` het
        final queryLower = txtTimKiem.toLowerCase();
        return nameLower.contains(queryLower); //tra ve ton` tai
      }).toList();
    } else {
      throw Exception("Something get wrong! Status code ${response.statusCode}");
    }
    // ignore: empty_catches
  } catch (e) {}

  return lst;
}

Future<List<SellOut>> apiGetSellout() async {
  List<SellOut> lst = [];
  try {
    final response = await Http().get("/getSellout");
    if (response.statusCode == 200) {
      List jsonRaw = json.decode(response.body);
      lst = jsonRaw.map((data) => SellOut.fromJson(data)).toList();
    } else {
      throw Exception("Something get wrong! Status code ${response.statusCode}");
    }
    // ignore: empty_catches
  } catch (e) {}

  return lst;
}
