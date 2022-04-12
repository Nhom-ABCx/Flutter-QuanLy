import 'package:flutter_quanly/View/donhang/donhang_binding.dart';
import 'package:flutter_quanly/View/donhang/them/them_donhang_page.dart';
import 'package:flutter_quanly/View/product/product_binding.dart';

import 'View/container/container_binding.dart';
import 'View/container/container_page.dart';
import 'View/home/home_binding.dart';
import 'package:get/get.dart';
import 'View/product/product_page.dart';
import 'routes.dart';

final routePages = [
  GetPage(
    name: Routes.CONTAINER,
    page: () => const ContainerPage(),
    bindings: [
      ContainerBinding(),
      HomeBinding(),
      DonHangBinding(),
    ],
  ),
  GetPage(
    name: Routes.THEMDONHANG,
    page: () => const ThemDonHangPage(),
    binding: DonHangBinding(),
  ),
  GetPage(
    name: Routes.PRODUCT,
    page: () => const ProductPage(),
    binding: ProductBinding(),
  ),
];
