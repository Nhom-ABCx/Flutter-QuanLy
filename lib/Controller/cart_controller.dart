import 'dart:async';
import 'package:flutter/material.dart';
import '../all_page.dart';

class CartController extends ChangeNotifier {
  List<Product> lstCartProduct = [];
  int tongSoLuong = 0;
  int tongTien = 0;
  Customer customer = Customer(customerName: "Khách lẻ", customerMobile: "");
  String ghiChu = "";

  void themSanPhamVaoCart(Product _product) {
    bool daCo = false;
    lstCartProduct.forEach((element) {
      if (_product.id == element.id) {
        element.stock = element.stock! + 1;
        tongSoLuong += 1;
        tongTien += element.price!;

        daCo = true;
        return;
      }
    });
    if (!daCo) {
      _product.stock = 1;

      lstCartProduct.add(_product);
      tongSoLuong += _product.stock!;
      tongTien += _product.price!;
    }
  }

  Future<void> chuyenDenTrangProduct(BuildContext context) async {
    //tao 1 bien nhan gia tri tu trang tiep theo gui ve`
    final value = await Navigator.push(
      context,
      MaterialPageRoute<Product>(
        builder: (context) => const ProductPage(),
      ),
    );
    FocusScope.of(context).requestFocus(FocusNode());
    if (value == null) return;
    themSanPhamVaoCart(value);
  }

  void giamSoLuong(int index) {
    if (lstCartProduct[index].stock! == 1) {
      tongSoLuong -= 1;
      tongTien -= lstCartProduct[index].price!;
      lstCartProduct.removeAt(index);
    } else {
      lstCartProduct[index].stock = lstCartProduct[index].stock! - 1;
      tongSoLuong -= 1;
      tongTien -= lstCartProduct[index].price!;
    }
    notifyListeners();
  }

  void tangSoLuong(int index) {
    lstCartProduct[index].stock = lstCartProduct[index].stock! + 1;
    tongSoLuong += 1;
    tongTien += lstCartProduct[index].price!;
    notifyListeners();
  }
}
