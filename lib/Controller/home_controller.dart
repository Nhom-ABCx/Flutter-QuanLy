import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../all_page.dart';

class HomeController extends ChangeNotifier {
  List<SellOut> sellOut = [];
  Future<List<SellOut>> getData() async {
    print("getData");
    sellOut = await apiGetSellout();
    return sellOut;
  }
}
