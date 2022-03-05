import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/all_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentIndexBottomNav = 0;
  final List<Widget> _widgetPage = [
    const TongQuanPage(),
    const DonHangPage(),
    const TongQuanPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      //huy keyboard khi bam ngoai man hinh
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //Hide
        //drawer: const NavigationDrawer(),
        body: _widgetPage.elementAt(currentIndexBottomNav),
        //Footer
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, //ko cho no thu nho? mat chu~
          currentIndex: currentIndexBottomNav,
          //selectedItemColor: Colors.indigo,
          onTap: (index) => setState(() => currentIndexBottomNav = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Tổng quan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: 'Đơn hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory),
              label: 'Sản phẩm',
            ),
          ],
        ),
      ),
    ));
  }
}
