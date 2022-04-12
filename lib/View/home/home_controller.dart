import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_quanly/View/product/product_controller.dart';
import 'package:get/get.dart';

import '../../API/api_manager.dart';
import '../../Model/sales.dart';
import '../../Model/sellout.dart';

class HomeController extends GetxController {
  DateTimeRange dateTimeRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 7)),
    end: DateTime.now(),
  );
  //du lieu ao? chua xu ly'
  List<SalesData> data = [
    SalesData((DateTime.now().year - 4).toString(), 40),
    SalesData((DateTime.now().year - 3).toString(), 32),
    SalesData((DateTime.now().year - 2).toString(), 34),
    SalesData((DateTime.now().year - 1).toString(), 28),
    SalesData(DateTime.now().year.toString(), 35),
  ];
  RxInt tongSoDonHang = 0.obs;
  RxInt tongDoanhThu = 0.obs;
  RxInt tongKhachHang = 0.obs;
  RxInt tongTonKho = 0.obs;
  RxInt giaTriTonKho = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getData().then((value) {
      List<int> listKhachHang = [];
      value.forEach((element) {
        tongDoanhThu.value += element.amount!;
        listKhachHang.add(element.customerId!); //den' xem so' khach' hang`
      });

      tongSoDonHang.value = value.length;
      tongKhachHang.value = listKhachHang.toSet().length; //neu' trung` nhau thi` loai bo?, xong tra ve` do dai`

      return value;
    });
    Get.put(ProductController()).getData("").then((value) {
      value.forEach((element) {
        tongTonKho.value += element.stock!;
        giaTriTonKho += element.stock! * element.price!;
      });

      return value;
    });
  }

  List<SellOut> sellOut = [];
  Future<List<SellOut>> getData() async {
    print("getData");
    sellOut = await apiGetSellout();
    return sellOut;
  }
}
