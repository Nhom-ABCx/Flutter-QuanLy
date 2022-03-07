import 'package:flutter/material.dart';
import 'package:flutter_quanly/all_page.dart';

class ChiTietDonHangPage extends StatefulWidget {
  const ChiTietDonHangPage({Key? key}) : super(key: key);
  @override
  State<ChiTietDonHangPage> createState() => _ChiTietDonHangPageState();
}

class _ChiTietDonHangPageState extends State<ChiTietDonHangPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      //huy keyboard khi bam ngoai man hinh
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //Hide
        //drawer: const NavigationDrawer(),
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              centerTitle: true,
              title: Text("Mã đơn hàng 01XBYS"),
            ),
            SliverList(delegate: SliverChildListDelegate([])),
          ],
        ),
      ),
    ));
  }
}
