import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'donhang/donhang_page.dart';
import 'home/home_page.dart';

class ContainerController extends GetxController {
  final List<Widget> widgetPage = [
    const HomePage(),
    const DonHangPage(),
    const Center(child: Text("Sản phẩm page")),
    const Center(child: Text("Setting page")),
  ];

  RxInt currentIndexBottomNav = 0.obs;
}
