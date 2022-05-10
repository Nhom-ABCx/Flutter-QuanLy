import 'package:flutter/material.dart';
import 'package:flutter_quanly/Config/theme.dart';
import 'package:get/get.dart';

import 'pages.dart';

void main() {
  //chinh cai' mau` cua nen` pin
  //SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.green));
  runApp(const MyApp());
}
// SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false, //tat cai' debug tren appbar
        title: 'Quan Ly Ban Hang',
        theme: ThemeConfig.lightTheme,
        initialRoute: Pages.initPage,
        getPages: Pages.getPages,
      );
}
