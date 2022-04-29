import 'package:flutter_quanly/View/container/donhang/chitiet/chitiet_donhang_page.dart';
import 'package:flutter_quanly/View/container/donhang/donhang_binding.dart';
import 'package:flutter_quanly/View/container/donhang/donhang_page.dart';
import 'package:flutter_quanly/View/container/donhang/them/them_donhang_page.dart';
import 'package:flutter_quanly/View/customer/customer_page.dart';
import 'package:flutter_quanly/View/product/product_binding.dart';
import 'View/container/container_binding.dart';
import 'View/container/container_page.dart';
import 'View/container/home/home_binding.dart';
import 'package:get/get.dart';
import 'View/product/product_page.dart';

part 'routes.dart';

class Pages {
  static const initPage = Routes.CONTAINER;

  static final getPages = [
    GetPage(
      name: Routes.CONTAINER,
      page: () => const ContainerPage(),
      bindings: [
        ContainerBinding(),
        HomeBinding(),
      ],
    ),
    GetPage(name: Routes.DONHANG, page: () => const DonHangPage(), binding: DonHangBinding(), children: [
      GetPage(
        name: Routes.THEMDONHANG,
        page: () => const ThemDonHangPage(),
      ),
      GetPage(
        name: Routes.CHITIETDONHANG,
        page: () => const ChiTietDonHangPage(),
      ),
    ]),
    GetPage(
      name: Routes.PRODUCT,
      page: () => const ProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.CUSTOMER,
      page: () => const CustomerPage(),
    ),
  ];
}
