import 'package:flutter/cupertino.dart';
import 'package:flutter_quanly/View/donhang/donhang_page.dart';
import 'package:get/get.dart';

import '../home/home_page.dart';

class ContainerController extends GetxController {
   final List<Widget> widgetPage = [
    const HomePage(),
    const DonHangPage(),
    Container(),
  ];

  
  RxInt currentIndexBottomNav = 0.obs;
}
