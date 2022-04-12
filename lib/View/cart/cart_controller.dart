import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_quanly/routes.dart';
import 'package:get/get.dart';

import '../../Model/customer.dart';
import '../../Model/product.dart';

class CartController extends GetxController {
  RxList<Product> lstCartProduct = <Product>[].obs;
  RxInt tongSoLuong = 0.obs;
  RxInt tongTien = 0.obs;
  Rx<Customer> customer = Customer(customerName: "Khách lẻ", customerMobile: "").obs;
  String ghiChu = "";

  void themSanPhamVaoCart(Product _product) {
    bool daCo = false;
    lstCartProduct.forEach((element) {
      if (_product.id == element.id) {
        element.stock = element.stock! + 1;
        tongSoLuong.value += 1;
        tongTien.value += element.price!;

        daCo = true;
        return;
      }
    });
    if (!daCo) {
      _product.stock = 1;

      lstCartProduct.add(_product);
      tongSoLuong.value += _product.stock!;
      tongTien.value += _product.price!;
    }
  }

  Future<void> chuyenDenTrangProduct(BuildContext context) async {
    //tao 1 bien nhan gia tri tu trang tiep theo gui ve`
    final value = await Get.toNamed(Routes.PRODUCT);
    if (value == null) return;
    themSanPhamVaoCart(value);
  }

  void giamSoLuong(int index) {
    if (lstCartProduct[index].stock! == 1) {
      tongSoLuong.value -= 1;
      tongTien.value -= lstCartProduct[index].price!;
      lstCartProduct.removeAt(index);
    } else {
      lstCartProduct[index].stock = lstCartProduct[index].stock! - 1;
      tongSoLuong.value -= 1;
      tongTien.value -= lstCartProduct[index].price!;
    }
  }

  void tangSoLuong(int index) {
    lstCartProduct[index].stock = lstCartProduct[index].stock! + 1;
    tongSoLuong.value += 1;
    tongTien.value += lstCartProduct[index].price!;
  }
}
