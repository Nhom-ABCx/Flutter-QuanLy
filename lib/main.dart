import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'all_page.dart'; //lam` v cho no' nho? ra

void main() {
  //chinh cai' mau` cua nen` pin
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.green));
  runApp(const MyApp());
}
// SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeController()),
          ChangeNotifierProvider(create: (_) => ProductController()),
          ChangeNotifierProvider(create: (_) => CustomerController()),
          ChangeNotifierProvider(create: (_) => CartController()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false, //tat cai' debug tren appbar
          title: 'Quan Ly Ban Hang',
          theme: ThemeData(
            //brightness: Brightness.dark, //che'do toi' hay sang'
            scaffoldBackgroundColor: const Color(0xFFEEEEEE),
            primarySwatch: Colors.green,
          ),
          home: const HomePage(),
          //builder: EasyLoading.init(),
        ),
      );
}
