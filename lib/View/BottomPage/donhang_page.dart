import 'package:flutter/material.dart';
import 'package:flutter_quanly/all_page.dart';

class DonHangPage extends StatefulWidget {
  const DonHangPage({Key? key}) : super(key: key);
  @override
  State<DonHangPage> createState() => _DonHangPageState();
}

class _DonHangPageState extends State<DonHangPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          centerTitle: true,
          title: Text("Đơn hàng"),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: TextButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const ThemDonHangPage(),
                      ),
                    ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.add),
                    Text(
                      "Tạo hóa đơn",
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: const BorderSide(color: Colors.grey))),
                )),
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              leading: const Icon(Icons.business),
              title: const Text("Danh sách đơn hàng"),
              trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.double_arrow_outlined)),
            ),
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              leading: const Icon(Icons.undo),
              title: const Text("Khách trả hàng"),
              trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.double_arrow_outlined)),
            ),
          ),
        ])),
      ],
    );
  }
}
