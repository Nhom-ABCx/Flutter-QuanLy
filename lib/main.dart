import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'all_page.dart'; //lam` v cho no' nho? ra

Future<void> main() async {
  runApp(const MyApp());
}
// SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => ChangeLayOut()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, //tat cai' debug tren appbar
        title: 'Quan Ly Ban Hang',
        theme: ThemeData(
          //brightness: Brightness.dark, //che'do toi' hay sang'
          //primarySwatch: Colors.indigo, //cai nen`cua title ngoai`
          //appBarTheme: const AppBarTheme(color: Colors.white),
          //0xFF
          //scaffoldBackgroundColor: const Color(0xFFe5e8ff),
          //primaryTextTheme: Theme.of(context).primaryTextTheme.apply(bodyColor: Colors.indigo),
        ),
        //home: const WellcomePage(),
        routes: {
          //'/Wellcome': (context) => const WellcomePage(),
        },
        builder: EasyLoading.init(),
      ),
    );
    //);
  }
}
