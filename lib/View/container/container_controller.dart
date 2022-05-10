import 'package:flutter/cupertino.dart';
import 'package:flutter_quanly/View/container/setting/setting_page.dart';
import 'package:get/get.dart';
import 'donhang/donhang_page.dart';
import 'home/home_page.dart';

class ContainerController extends GetxController {
  final List<Widget> widgetPage = [
    const HomePage(),
    const DonHangPage(),
    const Center(child: Text("Sản phẩm page")),
    const SettingPage(),
  ];

  RxInt currentIndexBottomNav = 0.obs;
}
